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
}*/

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tngtong/new_otp_screen.dart';
import 'WelcomeScreen.dart'; // Ensure this file exists and contains WelcomeScreen
import 'package:tngtong/customer/home_screen.dart'; // Ensure this file exists and contains HomeScreen
import 'package:tngtong/celebrities/cel_dashboard.dart'; // Ensure this file exists and contains HomeScreen
import 'package:tngtong/affiliate/affilate_dashboard.dart'; // Ensure this file exists and contains HomeScreen
import 'package:tngtong/celebrities/regScreen.dart';
import 'dart:math'; // Add this import for sin() and cos()
import 'package:google_fonts/google_fonts.dart';

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
      } else if (isAffiliaterLogin == 'True') {
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
      // home: NewOtpScreen(email:"veersh@gmail.com" , mobile: "9087654323"),
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
  // ========== TAGLINE CUSTOMIZATION ==========
  static const String taglineText = 'Empowering Success Through Collaboration';
  static const String googleFontName = 'Lexend';
  static const double fontSize = 18.0;
  static const FontWeight fontWeight = FontWeight.w600;
  static const Color fontColor = Colors.white;
  static const double letterSpacing = 0.5;
  static const List<Shadow> fontShadows = [
    Shadow(
      blurRadius: 4,
      color: Colors.black26,
      offset: Offset(1, 1),
    )
  ];
  static const double starIconSize = 24.0;

  // Animation controllers
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _waveAnimation;
  late Animation<double> _starPulseAnimation;
  late Animation<double> _textSlideAnimation; // New animation for text
  final List<Animation<double>> _rippleAnimations = [];
  final int _rippleCount = 3;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    // Text slide up animation (new)
    _textSlideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.8, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    _waveAnimation = Tween<double>(begin: 0.0, end: 2 * pi).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.linear),
      ),
    );

    _starPulseAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 1.2), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 1.2, end: 1.0), weight: 1),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.7, 1.0, curve: Curves.easeInOut),
      ),
    );

    for (int i = 0; i < _rippleCount; i++) {
      _rippleAnimations.add(
        Tween<double>(begin: 0.0, end: 1.5).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(
              0.2 + (i * 0.2),
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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffFF04AB), Color(0xffAE26CD)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated Logo
                  _buildAnimatedLogo(),

                  const SizedBox(height: 30),

                  // Animated Tagline with decorative stars
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildAnimatedStar(),
                      const SizedBox(width: 3),
                      Flexible(
                        child: Transform.translate(
                          offset: Offset(0, _textSlideAnimation.value),
                          child: Opacity(
                            opacity: _fadeAnimation.value,
                            child: Text(
                              taglineText,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.getFont(
                                googleFontName,
                                fontSize: fontSize,
                                fontWeight: fontWeight,
                                color: fontColor,
                                letterSpacing: letterSpacing,
                                shadows: fontShadows,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 3),
                      _buildAnimatedStar(),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedLogo() {
    return Stack(
      alignment: Alignment.center,
      children: [
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
                        color: Colors.white
                            .withOpacity(0.5 - (rippleAnim.value * 0.3)),
                        width: 2.0,
                      ),
                    ),
                  ),
                )
              : const SizedBox();
        }).toList(),
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
  }

  Widget _buildAnimatedStar() {
    return AnimatedBuilder(
      animation: _starPulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _starPulseAnimation.value,
          child: Text(
            '✧',
            style: TextStyle(
              fontSize: starIconSize,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 10,
                  color: Colors.white.withOpacity(0.8),
                ),
              ],
            ),
          ),
        );
      },
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
