import 'package:flutter/material.dart';
import 'package:smart_r_p/widgets/login_popup.dart';
import 'package:smart_r_p/widgets/signup_popup.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
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
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center all children vertically
              children: [
                // Header Text: Hi Student and Sign in to continue
                Center(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.center, // Center text horizontally
                    children: [
                      // Image.asset("asset/images/jecrc.png"),
                      Text(
                        'Hi Student',
                        style: TextStyle(
                          fontSize: 32,
                          fontFamily: "Kanit-Regular",
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                          height: screenWidth *
                              0.03), // Spacing between title and subtitle
                      Text(
                        'Sign in to continue',
                        style: TextStyle(
                          fontFamily: "Kanit-Regular",
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                    height: screenHeight * 0.1), // Add spacing before buttons

                // Login and Sign Up Buttons
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        showLoginBottomSheet(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: screenWidth * 0.8,
                        height: screenWidth * 0.15,
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontFamily: "Oswald-Regular",
                              fontSize: screenWidth * 0.06,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16), // Space between buttons
                    InkWell(
                      onTap: () {
                        showSignUpBottomSheet(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: screenWidth * 0.8,
                        height: screenWidth * 0.15,
                        child: Center(
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontFamily: "Oswald-Regular",
                              fontSize: screenWidth * 0.06,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20), // Space below the buttons
              ],
            ),
          ),
        ],
      ),
    );
  }
}
