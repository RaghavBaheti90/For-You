import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AlumniListPage extends StatefulWidget {
  @override
  _AlumniListPageState createState() => _AlumniListPageState();
}

class _AlumniListPageState extends State<AlumniListPage> {
  // Example alumni data
  final List<Map<String, String>> _alumni = [
    {'name': 'John Doe', 'company': 'Google'},
    {'name': 'Jane Smith', 'company': 'Amazon'},
    {'name': 'Michael Johnson', 'company': 'Facebook'},
    {'name': 'Sarah Connor', 'company': 'Tesla'},
    {'name': 'James Anderson', 'company': 'Microsoft'},
  ];

  // Method to show a "Friend request sent" popup
  void _showFriendRequestDialog(String name) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Friend Request Sent'),
          content: Text('You have sent a friend request to $name.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK', style: TextStyle(color: Colors.blueAccent)),
            ),
          ],
        );
      },
    );
  }

  // Placeholder method for navigating to the chat page
  void _navigateToChatPage(String name) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Chat with $name'),
          content: Text('This will open a chat with $name.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK', style: TextStyle(color: Colors.blueAccent)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.arrowLeft, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Alumni List',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: ListView.builder(
          itemCount: _alumni.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(15),
                  leading: CircleAvatar(
                    backgroundColor: Colors.blueAccent.shade100,
                    child: Text(
                      _alumni[index]['name']![0], // First letter of name
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  title: Text(
                    _alumni[index]['name']!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    _alumni[index]['company']!,
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Add Friend Icon
                      IconButton(
                        icon: Icon(FontAwesomeIcons.userPlus,
                            color: Colors.black),
                        onPressed: () {
                          _showFriendRequestDialog(_alumni[index]['name']!);
                        },
                      ),
                      // Chat Icon
                      IconButton(
                        icon:
                            Icon(FontAwesomeIcons.comment, color: Colors.black),
                        onPressed: () {
                          _navigateToChatPage(_alumni[index]['name']!);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
