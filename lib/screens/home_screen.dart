import 'package:flutter/material.dart';
import 'package:smart_r_p/screens/alumini_screen.dart';

import 'package:smart_r_p/screens/book_rent_screen.dart';
import 'package:smart_r_p/screens/chat_bot.dart';
import 'package:smart_r_p/screens/chat_room.dart';
import 'package:smart_r_p/screens/colabration_screen.dart';
import 'package:smart_r_p/screens/loste&founde_screen.dart';
import 'package:smart_r_p/screens/myearning_screen.dart';
import 'package:smart_r_p/screens/poste_screen.dart';
import 'package:smart_r_p/screens/profile_screen.dart';
import 'package:smart_r_p/screens/time_tabble.dart';
import 'package:smart_r_p/widgets/bottom_bar.dart';

class StudentDashboardPage extends StatelessWidget {
  final int _selectedIndex = 0; // Define the _selectedIndex variable
  const StudentDashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StudentDashboardPage()),
              );
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Notification'),
                    content: Text('You are already on the home page.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreatePostPage()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
              break;
          }
        },
      ),
      backgroundColor: Colors.white, // Background color
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  // Color(0xFFc80af2),
                  // Color(0xFF000000)
                  Color(0xFF2855AE), // Start color
                  Color(0xFF7292CF), // End color
                ],
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(
                    screenWidth * 0.05), // Padding around the content
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: screenHeight * 0.01), // Space below header
                      child: Text(
                        'Hi Student',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: "Kanit-Regular",
                        ),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                'Hey everyone welcome to our app one stop \nfor all your problems',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: "",
                              color: Colors.grey.shade100,
                            ),
                          ),
                          TextSpan(
                            text: '  ',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(
                    //     height: screenHeight *
                    //         0.02), // Space below registration number
                    // Text(
                    //   '2020-2021',
                    //   style: TextStyle(
                    //     fontSize: 16,
                    //     color: Colors.grey.shade100,
                    //   ),
                    // ),
                    SizedBox(height: screenHeight * 0.02), // Space below year

                    // Attendance and Fees Due
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: _buildInfoCard(
                              context,
                              "asset/images/Earnings.png",
                              'Earnings',
                              () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyEarningsPage(),
                                  ),
                                );
                              },
                              Colors.white,
                            ),
                          ),
                          SizedBox(
                              width: screenWidth * 0.05), // Space between cards
                          Expanded(
                            child: _buildInfoCard(
                              context,
                              "asset/images/Post1.png",
                              'Post',
                              () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CreatePostPage(),
                                  ),
                                );
                              },
                              Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.02), // Space below cards

                    // Features Grid
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics:
                          NeverScrollableScrollPhysics(), // Disable scrolling for the grid
                      childAspectRatio:
                          1.5, // Adjust the aspect ratio as needed
                      children: [
                        _buildFeatureCard(context, "asset/images/intern.png",
                            'Internship Post', () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreatePostPage(),
                            ),
                          );
                        }),
                        _buildFeatureCard(
                            context,
                            "asset/images/assignment.png",
                            'Rent-a-Resource', () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BooksEcommercePage(),
                            ),
                          );
                        }),
                        _buildFeatureCard(
                            context, "asset/images/Posts.png", 'Alumni Network',
                            () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AlumniListPage(),
                            ),
                          );
                        }),
                        _buildFeatureCard(
                            context, "asset/images/Reminder.png", 'Networking',
                            () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatRoomPage(),
                            ),
                          );
                        }),
                        _buildFeatureCard(
                            context,
                            "asset/images/Lost & Found.png",
                            'Lost & Found', () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LostAndFoundPage(),
                            ),
                          );
                        }),
                        _buildFeatureCard(context, "asset/images/outher.png",
                            'Collaborations', () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StudentClassesPage(),
                            ),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, String imagePath, String value,
      void Function()? ontap, Color backgroundColor) {
    final screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.all(screenWidth * 0.05), // Adjust padding
        decoration: BoxDecoration(
          color: backgroundColor, // Set the background color
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(2, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    Colors.transparent, // Circle background color for the image
              ),
              padding: EdgeInsets.all(12), // Padding around the image
              child: Image.asset(
                imagePath,
                width: 50, // Adjust size as needed
                height: 50,
                fit: BoxFit.contain, // Fit image inside the container
              ),
            ),
            SizedBox(height: 8), // Fixed space below image
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Change text color to black
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, String imagePath, String label,
      void Function()? ontap) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.all(screenWidth * 0.02), // Add margin around the card
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          onTap: ontap,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Use Image.asset to load the image
                Image.asset(
                  imagePath, // Image path
                  width: screenWidth * 0.1, // Set width for the image
                  height: screenWidth * 0.1, // Set height for the image
                  fit: BoxFit.cover, // Ensure the image covers the space
                ),
                SizedBox(height: screenHeight * 0.01), // Space below image
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF2855AE),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
