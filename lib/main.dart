/*import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'WelcomeScreen.dart';
void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: ('inter'),
        useMaterial3: true,
      ),
      home:const WelcomeScreen(),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'WelcomeScreen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // Transparent status bar
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'inter', // Custom font
        useMaterial3: true, // Material 3 design
      ),
      home: const WelcomeScreen(),
    );
  }
}*/import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'WelcomeScreen.dart'; // Ensure this file exists and contains WelcomeScreen
import 'package:tngtong/customer/home_screen.dart'; // Ensure this file exists and contains HomeScreen
import 'package:tngtong/celebrities/cel_dashboard.dart'; // Ensure this file exists and contains HomeScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<Widget> _getInitialScreen() async {
    await Future.delayed(const Duration(seconds: 4)); // 2-second splash delay
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      // Print all stored preferences for debugging
      print('All Preferences: ${prefs.getKeys()}');
      for (var key in prefs.getKeys()) {
        print('$key: ${prefs.get(key)}');
      }

      final String? isBrandLogin = prefs.getString('isBrandLogin');
      final String? isCelLogin = prefs.getString('isCelLogin');

      print('isBrandLogin: $isBrandLogin');
      print('isCelLogin: $isCelLogin');

      if (isBrandLogin == 'True') {
        return const HomeScreen();
      } else if (isCelLogin == 'True') {
        return const CelebrityDashboardScreen();
      } else {
        return const WelcomeScreen();
      }
    } catch (e) {
      print('Error in _getInitialScreen: $e');
      return const WelcomeScreen(); // Fallback to WelcomeScreen in case of an error
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'inter', // Custom font
        useMaterial3: true, // Material 3 design
      ),
      home: FutureBuilder<Widget>(
        future: _getInitialScreen(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          } else if (snapshot.hasError) {
            return const Scaffold(
              body: Center(child: Text('Error loading app.')),
            );
          } else {
            return snapshot.data!;
          }
        },
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffB81736), // Primary color
              Color(0xff281537), // Secondary color
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage('assets/logo.jpg'), // Replace with your logo path
                width: 120,
                height: 120,
              ),
              const SizedBox(height: 20),
              const Text(
                'Welcome to TNGTong',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Connecting Celebrities and Brands',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 30),
              const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/*
class CelebrityDashboard extends StatelessWidget {
  const CelebrityDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Celebrity Dashboard')),
      body: const Center(child: Text('Welcome, Celebrity!')),
    );
  }
}*/
