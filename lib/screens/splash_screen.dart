import 'package:flutter/material.dart';
import 'package:smart_r_p/screens/login_screen.dart';

class SchoolERPPage extends StatefulWidget {
  const SchoolERPPage({Key? key}) : super(key: key);

  @override
  _SchoolERPPageState createState() => _SchoolERPPageState();
}

class _SchoolERPPageState extends State<SchoolERPPage> {
  @override
  void initState() {
    super.initState();
    // Navigate to the next screen after a delay
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => LoginPage()), // Replace with your next screen
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.transparent, // Background color set to transparent
      extendBodyBehindAppBar: true, // Extend the body behind the app bar
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF2855AE), // Start color
                  Color(0xFF7292CF), // End color
                ],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title
                Text(
                  'For You',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily:
                        'Kanit-Regular', // or any other font you want to use
                  ),
                ),
                SizedBox(height: 20), // Space between title and image

                // Image placeholder (use an actual image asset in your app)
                // Container(
                //   height: 300, // Adjust height as needed
                //   decoration: BoxDecoration(
                //     image: DecorationImage(
                //       image: AssetImage(
                //           'asset/images/ss_img.png'), // Replace with your image path
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),
                // Space below the image

                // Additional text or buttons can be added here
              ],
            ),
          ),
        ],
      ),
    );
  }
}
