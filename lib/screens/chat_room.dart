import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ChatRoomPage extends StatefulWidget {
  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  User? _user;
  TextEditingController _messageController = TextEditingController();
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
  }

  // Method to pick an image from gallery
  Future<void> _pickImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No image selected')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: $e')),
      );
    }
  }

  // Method to upload the selected image to Firebase Storage
  Future<String?> _uploadImage(File image) async {
    try {
      // Create a unique filename for the image using the timestamp
      final String fileName =
          'chat_images/${DateTime.now().millisecondsSinceEpoch}.jpg';
      final ref = _storage.ref().child(fileName);

      // Upload the file
      TaskSnapshot uploadTask = await ref.putFile(image);

      // Get the download URL of the uploaded image
      String downloadUrl = await uploadTask.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload image: $e')),
      );
      return null;
    }
  }

  // Method to send a message (with or without an image)
  Future<void> _sendMessage(String text) async {
    if (_user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User not logged in!')),
      );
      return;
    }

    String? imageUrl;
    if (_imageFile != null) {
      imageUrl = await _uploadImage(_imageFile!);
      setState(() {
        _imageFile = null; // Clear the image file after sending
      });
    }

    try {
      await _firestore.collection('chat_room').add({
        'text': text.trim(),
        'createdAt': Timestamp.now(),
        'userId': _user!.uid,
        'email': _user!.email,
        'imageUrl': imageUrl, // Add image URL if available
      });
      _messageController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send message: $e')),
      );
    }
  }

  // Build the chat messages list
  // Build the chat messages list
  Widget _buildChatMessages() {
    return StreamBuilder<QuerySnapshot>(
      stream:
          _firestore.collection('chat_room').orderBy('createdAt').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final messages = snapshot.data!.docs;

        return ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index].data() as Map<String, dynamic>;
            final bool isMe = message['userId'] == _user?.uid;

            return _buildMessageBubble(message, isMe, messages[index].id);
          },
        );
      },
    );
  }

  // Build individual message bubble
  Widget _buildMessageBubble(
      Map<String, dynamic> message, bool isMe, String messageId) {
    return GestureDetector(
      onLongPress: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                    leading: Icon(FontAwesomeIcons.trash),
                    title: Text('Delete'),
                    onTap: () async {
                      Navigator.of(context).pop();
                      await _firestore
                          .collection('chat_room')
                          .doc(messageId)
                          .delete();
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                message['email'] ?? 'Unknown',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isMe ? Colors.black : Colors.black,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: isMe ? Colors.blueAccent : Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment:
                      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    if (message['imageUrl'] != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          message['imageUrl'],
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    if (message['text'] != null && message['text'].isNotEmpty)
                      Text(
                        message['text'],
                        style: TextStyle(
                            color: isMe ? Colors.white : Colors.black),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.arrowLeft),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Chat Room'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildChatMessages(),
          ),
          if (_imageFile != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                width: 100,
                child: Image.file(_imageFile!),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(FontAwesomeIcons.image, color: Colors.black),
                  onPressed: _pickImage,
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(FontAwesomeIcons.arrowRight, color: Colors.black),
                  onPressed: () {
                    if (_messageController.text.isNotEmpty ||
                        _imageFile != null) {
                      _sendMessage(_messageController.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
