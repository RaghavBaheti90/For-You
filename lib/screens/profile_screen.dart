import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_r_p/screens/home_screen.dart';
import 'package:smart_r_p/screens/howtoearn_screen.dart';
import 'package:smart_r_p/screens/login_screen.dart';
import 'package:smart_r_p/screens/myearning_screen.dart';
import 'package:smart_r_p/screens/poste_screen.dart';
import 'package:smart_r_p/widgets/bottom_bar.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  // Method to pick image from gallery
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
      _saveProfileImage(pickedFile.path); // Save the selected image path
    }
  }

  // Load profile image from SharedPreferences
  Future<void> _loadProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('profile_image');
    if (imagePath != null && mounted) {
      setState(() {
        _profileImage = File(imagePath);
      });
    }
  }

  // Save profile image path to SharedPreferences
  Future<void> _saveProfileImage(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('profile_image', path);
  }

  // Method to sign out
  Future<void> _signOut() async {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (context) => LoginPage()), // Assuming a SignInScreen exists
    );
  }

  // Method to confirm sign out
  void _confirmSignOut() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sign Out'),
          content: Text('Are you sure you want to sign out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                _signOut();
              },
              child: Text(
                'Sign Out',
                style: TextStyle(color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.arrowLeft, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            // Profile Image Section
            Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: _profileImage != null
                      ? FileImage(_profileImage!)
                      : AssetImage('assets/avatar.png') as ImageProvider,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      child: Icon(FontAwesomeIcons.camera, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Text(
              "Robi",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              "robi80@gmail.com",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 30),
            // Profile Options List
            Expanded(
              child: ListView(
                children: [
                  _buildProfileOption(
                      context, FontAwesomeIcons.moneyBill, "My Earnings", () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyEarningsPage()));
                  }),
                  // _buildProfileOption(
                  //     context, Icons.location_on, "Shipping Address", () {
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => StudentDashboardPage()));
                  // }),
                  // _buildProfileOption(
                  //     context, Icons.request_page, "Create Request", () {
                  //   // Add navigation or functionality for creating request
                  // }),
                  _buildProfileOption(
                      context, FontAwesomeIcons.list, "Privacy Policy", () {
                    // Add navigation or functionality for privacy policy
                  }),
                  _buildProfileOption(context, FontAwesomeIcons.signOut,
                      "Log out", _confirmSignOut),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0, // Set the current index as needed
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StudentDashboardPage()));
              break;
            case 1:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreatePostPage()));
              break;
            case 2:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePage()));
              break;
          }
        },
      ),
    );
  }

  Widget _buildProfileOption(BuildContext context, IconData icon, String title,
      void Function()? onTap) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.orange.shade100,
        child: Icon(icon, color: Colors.orange),
      ),
      title: Text(title),
      trailing: Icon(FontAwesomeIcons.arrowRight, size: 16),
      onTap: onTap,
    );
  }
}
