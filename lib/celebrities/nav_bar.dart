import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tngtong/WelcomeScreen.dart'; // Import WelcomeScreen to navigate after logout
import 'package:tngtong/celebrities/cel_profile.dart'; // Import ProfileUpdateScreen
import 'package:tngtong/celebrities/ImageUploaderService.dart'; // Import ProfileUpdateScreen

class NavBar extends StatelessWidget {
  final VoidCallback onClose;

  const NavBar({Key? key, required this.onClose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250, // Fixed width of the NavBar
      decoration: const BoxDecoration(
        color: Color(0xff281537),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Close Button at the Top-Left Corner
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: onClose,
            ),
          ),
          const SizedBox(height: 20),

          // Menu Items
          _buildMenuItem(Icons.home, "Home", context),
          _buildMenuItem(Icons.trending_up, "Trending", context,nextScreen: ImageUploader()),
          _buildMenuItem(Icons.person, "Profile", context, nextScreen: ProfileUpdateScreen()),
          _buildMenuItem(Icons.settings, "Settings", context),
          _buildMenuItem(Icons.logout, "Logout", context, isLogout: true),
        ],
      ),
    );
  }

  // Helper method to build menu items
  Widget _buildMenuItem(IconData icon, String label, BuildContext context, {bool isLogout = false, Widget? nextScreen}) {
    return InkWell(
      onTap: () async {
        if (isLogout) {
          // Clear shared preferences
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.clear(); // Removes all keys

          // Navigate to the WelcomeScreen after logging out
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                (Route<dynamic> route) => false, // Removes all previous routes
          );
        } else if (nextScreen != null) {
          // Navigate to the ProfileUpdateScreen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => nextScreen),
          );
        } else {
          print("Clicked on $label");
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


