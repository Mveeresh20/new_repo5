import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tngtong/customer/home_screen.dart';
//import 'celebrity_dashboard.dart';
import 'package:tngtong/WelcomeScreen.dart';
import 'package:tngtong/celebrities/regScreen.dart';

Future<void> checkLoginStatus(BuildContext context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? isBrandLogin = prefs.getString('isBrandLogin');
  final String? isCelLogin = prefs.getString('isCelLogin');

  // Navigate to appropriate screen based on login status
  if (isBrandLogin == 'True') {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  } else if (isCelLogin == 'True') {
   /* Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const CelebrityDashboard()),
    );*/
  } else {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const RegScreen()),
    );
  }
}
