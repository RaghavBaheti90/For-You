import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HowToEarnScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.arrowLeft),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('How to Earn'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blueAccent,
                ),
                height: screenHeight * 0.27,
                width: screenWidth,
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    'Give Your Resources ,Who wants Theam',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Kanit-Regular",
                        color: Colors.white,
                        fontSize: screenWidth * 0.06),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.greenAccent,
                ),
                height: screenHeight * 0.27,
                width: screenWidth,
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    'Personalised Coaching',
                    style: TextStyle(
                        fontFamily: "Kanit-Regular",
                        color: Colors.white,
                        fontSize: screenWidth * 0.06),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.redAccent,
                ),
                height: screenHeight * 0.27,
                width: screenWidth,
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    'Adevertisement',
                    style: TextStyle(
                        fontFamily: "Kanit-Regular",
                        color: Colors.white,
                        fontSize: screenWidth * 0.06),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// In your main.dart or wherever you want to navigate to this page
void navigateToHowToEarnScreen(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => HowToEarnScreen()),
  );
}
