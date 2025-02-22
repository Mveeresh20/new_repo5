import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xffB81736),
                  Color(0xff281537),
                ],
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 60.0, left: 22),
              child: Text(
                'Forgot\nPassword?',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.25),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Column(
                  children: [
                    SizedBox(height: screenHeight * 0.05),
                    const TextField(
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.check, color: Colors.grey),
                        label: Text(
                          'Enter your Gmail',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffB81736),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    _buildButton(
                      screenWidth,
                      'Send Reset Link',
                      const LinearGradient(
                        colors: [
                          Color(0xffB81736),
                          Color(0xff281537),
                        ],
                      ),
                          () async {
                        // Add logic for sending reset link
                        print('Send reset link button pressed');
                        await Future.delayed(Duration(seconds: 2)); // Simulate delay
                        print('Reset link sent');
                      },
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context); // Go back to the login screen
                            },
                            child: Text(
                              "Back to Login",
                                style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
      double screenWidth, String text, Gradient gradient, Future<void> Function() onPressed) {
    return GestureDetector(
      onTap: () async {
        await onPressed();
      },
      child: Container(
        height: 55,
        width: screenWidth * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: gradient,
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
