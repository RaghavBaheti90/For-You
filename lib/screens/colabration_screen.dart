import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StudentClassesPage extends StatefulWidget {
  @override
  _StudentClassesPageState createState() => _StudentClassesPageState();
}

class _StudentClassesPageState extends State<StudentClassesPage> {
  late final double screenWidth;
  late final double screenHeight;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }

  // Example students' class data
  final List<Map<String, String>> _classes = [
    {
      'name': 'Aarav',
      'subject': 'Mechanical Engineering',
      'topic': 'torque',
      'price': '50Rs/hour'
    },
    {
      'name': 'Isha',
      'subject': 'Electrical Engineering',
      'topic': 'Circuit Analysis',
      'price': '45Rs/hour'
    },
    {
      'name': 'Rohan',
      'subject': 'Civil Engineering',
      'topic': 'Structural Analysis',
      'price': '55Rs/hour'
    },
    {
      'name': 'Priya',
      'subject': 'Computer Engineering',
      'topic': 'Structures',
      'price': '60Rs/hour'
    },
    {
      'name': 'Karan',
      'subject': 'Chemical Engineering',
      'topic': 'Process Control',
      'price': '50Rs/hour'
    },
    {
      'name': 'Ananya',
      'subject': 'Aerospace Engineering',
      'topic': 'Fluid',
      'price': '70Rs/hour'
    },
  ];

  // Method to show a "Class Booking Request Sent" popup
  void _showBookingRequestDialog(String name) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Booking Request Sent'),
          content: Text('You have sent a booking request to $name.'),
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.arrowLeft, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Class Listings',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.045),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 columns
            crossAxisSpacing: 10.0, // Spacing between columns
            mainAxisSpacing: 10.0, // Spacing between rows
            childAspectRatio: 0.55, // Decreased aspect ratio to increase height
          ),
          itemCount: _classes.length,
          itemBuilder: (context, index) {
            return Container(
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
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blueAccent.shade100,
                      child: Text(
                        _classes[index]['name']![0], // First letter of name
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _classes[index]['name']!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Subject: ${_classes[index]['subject']}',
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                    Text(
                      'Topic: ${_classes[index]['topic']}',
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Price: ${_classes[index]['price']}',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(FontAwesomeIcons.userPlus,
                              color: Colors.blueAccent),
                          onPressed: () {
                            _showBookingRequestDialog(_classes[index]['name']!);
                          },
                        ),
                        IconButton(
                          icon: Icon(FontAwesomeIcons.comment,
                              color: Colors.blueAccent),
                          onPressed: () {
                            // Implement chat feature here
                            _showBookingRequestDialog(_classes[index]['name']!);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
