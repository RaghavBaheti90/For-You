import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomNavigationBar(
      iconSize: 24.0, // Size of the icons
      selectedColor: Colors.blue, // Color when selected
      unSelectedColor: Colors.grey, // Color when not selected
      backgroundColor: Colors.white, // Background color of the navigation bar
      currentIndex: currentIndex, // The current index
      onTap: onTap, // Callback when a tab is tapped
      items: [
        CustomNavigationBarItem(
          icon: Image.asset(
            'asset/images/home.png', // Replace with your image path
            width: 24,
            height: 24,
          ),
        ),
        CustomNavigationBarItem(
          icon: Image.asset(
            'asset/images/Post1.png', // Replace with your image path
            width: 24,
            height: 24,
          ),
        ),
        CustomNavigationBarItem(
          icon: Image.asset(
            'asset/images/profile.png', // Replace with your image path
            width: 30,
            height: 24,
          ),
        ),
      ],
    );
  }
}
