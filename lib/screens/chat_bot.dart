import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:googleapis_auth/auth_io.dart'; // For authenticating using a service account

const String dialogflowProjectId =
    'for-me-438917'; // Replace with your Dialogflow project ID
const String serviceAccountKeyPath =
    'AIzaSyBmnrK7_5QS3kjSIpcREtZoE_IaLlcwYFY'; // Path to the service account key file

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({Key? key}) : super(key: key);

  @override
  ChatBotPageState createState() => ChatBotPageState();
}

class ChatBotPageState extends State<ChatBotPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  late AuthClient _authClient;

  @override
  void initState() {
    super.initState();
    authenticate(); // Authenticate when the app starts
  }

  // Function to authenticate with Dialogflow using a service account
  Future<void> authenticate() async {
    final credentials = ServiceAccountCredentials.fromJson(
        File(serviceAccountKeyPath).readAsStringSync());
    final scopes = ['https://www.googleapis.com/auth/cloud-platform'];

    _authClient = await clientViaServiceAccount(credentials, scopes);
  }

  // Function to send a message to Dialogflow API
  Future<void> sendMessage(String message) async {
    setState(() {
      _messages.add({'text': message, 'isUser': true});
    });

    final url = Uri.parse(
        'https://dialogflow.googleapis.com/v2/projects/$dialogflowProjectId/agent/sessions/12345:detectIntent');

    final body = jsonEncode({
      "queryInput": {
        "text": {
          "text": message,
          "languageCode": "en",
        }
      }
    });

    final response = await _authClient.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final botResponse = data['queryResult']['fulfillmentText'];
      setState(() {
        _messages.add({'text': botResponse, 'isUser': false});
      });
    } else {
      setState(() {
        _messages
            .add({'text': 'Error: Unable to connect to bot', 'isUser': false});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatBot'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return Align(
                    alignment: _messages[index]['isUser']
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _messages[index]['isUser']
                            ? Colors.blueAccent
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        _messages[index]['text'],
                        style: TextStyle(
                          color: _messages[index]['isUser']
                              ? Colors.white
                              : Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      sendMessage(_controller.text);
                      _controller.clear();
                    }
                  },
                  backgroundColor: Colors.blueAccent,
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
