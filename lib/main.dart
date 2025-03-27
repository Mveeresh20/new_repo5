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
import 'package:tngtong/affiliate/affilate_dashboard.dart'; // Ensure this file exists and contains HomeScreen
import 'package:tngtong/celebrities/regScreen.dart';
import 'dart:math'; // Add this import for sin() and cos()

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
      final String? isAffiliaterLogin = prefs.getString('isAffiliaterLogin');


      print('isBrandLogin: $isBrandLogin');
      print('isCelLogin: $isCelLogin');
      print('isAffiliaterLogin: $isAffiliaterLogin');

      if (isBrandLogin == 'True') {
        return const HomeScreen();
      } else if (isCelLogin == 'True') {
        return const CelebrityDashboardScreen();
      }else if (isAffiliaterLogin == 'True') {
        return const AffiliateDashboardScreen();
      } else {
        return const RegScreen();
      }
    } catch (e) {
      print('Error in _getInitialScreen: $e');
      return const RegScreen(); // Fallback to WelcomeScreen in case of an error
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




class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _waveAnimation;
  final List<Animation<double>> _rippleAnimations = [];
  final int _rippleCount = 3; // Number of ripple waves

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    // Scale animation
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
      ),
    );

    // Fade animation
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
        ));

        // Wave border animation
        _waveAnimation = Tween<double>(begin: 0.0, end: 2 * pi).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.linear),
      ),
    );

    // Create multiple ripple animations with staggered timing
    for (int i = 0; i < _rippleCount; i++) {
      _rippleAnimations.add(
        Tween<double>(begin: 0.0, end: 1.5).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(
              0.2 + (i * 0.2), // Stagger start times
              1.0,
              curve: Curves.easeOut,
            ),
          ),
        ),
      );
    }

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffFF04AB),
              Color(0xffAE26CD),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  // Multiple ripple waves
                  ..._rippleAnimations.map((rippleAnim) {
                    return rippleAnim.value > 0
                        ? Opacity(
                      opacity: 1 - rippleAnim.value / 1.5,
                      child: Container(
                        width: 180 + 80 * rippleAnim.value,
                        height: 180 + 80 * rippleAnim.value,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withOpacity(0.5 - (rippleAnim.value * 0.3)),
                            width: 2.0,
                          ),
                        ),
                      ),
                    )
                        : const SizedBox();
                  }).toList(),

                  // Logo container with wave border
                  Container(
                    width: 200,
                    height: 200,
                    child: CustomPaint(
                      painter: _WaveBorderPainter(_waveAnimation.value),
                      child: Center(
                        child: Transform.scale(
                          scale: _scaleAnimation.value,
                          child: Opacity(
                            opacity: _fadeAnimation.value,
                            child: Image.asset(
                              'assets/images/new-logo.png',
                              width: 140,
                              height: 140,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _WaveBorderPainter extends CustomPainter {
  final double waveValue;

  _WaveBorderPainter(this.waveValue);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..shader = LinearGradient(
        colors: [Colors.white, Colors.white.withOpacity(0.7)],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    final path = Path();

    // Create wave pattern
    for (double angle = 0; angle <= 360; angle += 1) {
      final radian = angle * (pi / 180);
      final waveOffset = 10 * sin(waveValue + radian * 8);
      final point = Offset(
        center.dx + (radius + waveOffset) * cos(radian),
        center.dy + (radius + waveOffset) * sin(radian),
      );

      if (angle == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
/*class SplashScreen extends StatelessWidget {
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
              Color(0xffFF04AB), // Primary color
              Color(0xffAE26CD), // Secondary color
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
           /*   const Image(
                image: AssetImage('assets/logo.jpg'), // Replace with your logo path
                width: 120,
                height: 120,
              ),*/
              const SizedBox(height: 20),
              const Text(
                'Welcome to Influencer Setter',
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
}*/

