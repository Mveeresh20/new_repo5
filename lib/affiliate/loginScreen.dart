/*import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'regScreen.dart';
import 'home_screen.dart';
import 'ForgotPasswordScreen.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<loginScreen> {
  bool _isPasswordVisible = false;

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
                'Hello\nSign in!',
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
              child: SingleChildScrollView( // Added to handle overflow
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight * 0.05),
                      const TextField(
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.check, color: Colors.grey),
                          label: Text(
                            'Gmail',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffB81736),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      TextField(
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          label: const Text(
                            'Password',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffB81736),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            // Navigate to the Forgot Password screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                            );
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Color(0xff281537),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      _buildButton(
                        screenWidth,
                        'SIGN IN',
                        const LinearGradient(
                          colors: [
                            Color(0xffB81736),
                            Color(0xff281537),
                          ],
                        ),
                            () async {
                          // Add SIGN IN logic here
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomeScreen()),
                          );
                        },
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      _buildButton(
                        screenWidth,
                        'SIGN IN WITH GOOGLE',
                        const LinearGradient(
                          colors: [
                            Color(0xffB81736),
                            Color(0xff281537),
                          ],
                        ),
                            () async {
                          GoogleSignIn _googleSignIn = GoogleSignIn();
                          try {
                            var result = await _googleSignIn.signIn();
                            print(result);
                          } catch (error) {
                            print(error);
                          }
                        },
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      Text(
                        "Don't have an account?",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegScreen()),
                          );
                        },
                        child: Text(
                          "Sign Up",
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
}*/



/*
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tngtong/affiliate/regScreen.dart';
import 'package:tngtong/affiliate/affilate_dashboard.dart';
import 'package:tngtong/affiliate/ForgotPasswordScreen.dart';


import 'package:tngtong/config.dart'; // Import the config file
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tngtong/loginstatus.dart';
class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<loginScreen> {
  bool _isPasswordVisible = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    try {
      // Send POST request to the backend
      final response = await http.post(
        Uri.parse('${Config.apiDomain}${Config.affiliater_login}'),
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['message'] == 'Login successful') {
          // Navigate to the home screen on successful login
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AffiliateDashboardScreen()),
          );
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('isAffiliaterLogin', 'True');
          await prefs.setString('isBrandLogin', 'False');
          await prefs.setString('isCelLogin', 'False');
          await prefs.setString('loginEmail', email);
        } else {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['message'])),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to log in')),
        );
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred. Please try again')),
      );
    }
  }

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
                  Color(0xffFF04AB),
                  Color(0xffAE26CD),
                ],
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 60.0, left: 22),
              child: Text(
                'Hello\nSign in!',
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
              child: SingleChildScrollView( // Added to handle overflow
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight * 0.05),
                      TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          label: Text(
                            'Email',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffFF04AB),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      TextField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          label: const Text(
                            'Password',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffFF04AB),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                            );
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Color(0xffAE26CD),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      _buildButton(
                        screenWidth,
                        'SIGN IN',
                        const LinearGradient(
                          colors: [
                            Color(0xffFF04AB),
                            Color(0xffAE26CD),
                          ],
                        ),
                        _login,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      _buildButton(
                        screenWidth,
                        'SIGN IN WITH GOOGLE',
                        const LinearGradient(
                          colors: [
                            Color(0xffFF04AB),
                            Color(0xffAE26CD),
                          ],
                        ),
                            () async {
                          GoogleSignIn _googleSignIn = GoogleSignIn();
                          try {
                            var result = await _googleSignIn.signIn();
                            print(result);
                          } catch (error) {
                            print(error);
                          }
                        },
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegScreen()),
                          );
                        },
                        child: const Text(
                          "Sign Up",
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
}*/

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tngtong/affiliate/regScreen.dart';
import 'package:tngtong/affiliate/affilate_dashboard.dart';
import 'package:tngtong/affiliate/ForgotPasswordScreen.dart';
import 'package:tngtong/celebrities/loginScreen.dart';


import 'package:tngtong/config.dart'; // Import the config file
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tngtong/customer/loginScreen.dart';
import 'package:tngtong/loginstatus.dart';
import 'package:tngtong/registration_type_state.dart';
import 'package:tngtong/celebrities/loginScreen.dart' as celebrity;
import 'package:tngtong/customer/loginScreen.dart' as customer;
import 'package:tngtong/affiliate/loginScreen.dart' as affiliate;
class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<loginScreen> {
  bool _passwordVisible = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    try {
      // Send POST request to the backend
      final response = await http.post(
        Uri.parse('${Config.apiDomain}${Config.affiliater_login}'),
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['message'] == 'Login successful') {
          // Navigate to the home screen on successful login
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AffiliateDashboardScreen()),
          );
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('isAffiliaterLogin', 'True');
          await prefs.setString('isBrandLogin', 'False');
          await prefs.setString('isCelLogin', 'False');
          await prefs.setString('loginEmail', email);
        } else {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['message'])),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to log in')),
        );
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred. Please try again')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.grey[200],
        title: Row(
          children: [
            // Star on the left
            Text('Influencer Setter'),
          ],
        ),

      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Select a Profile & Login",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTypeButton("Influencer", 'Influencer'),
                _buildTypeButton("Businessman", 'Businessman'),
                _buildTypeButton("Associate", 'Associate'),
              ],
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                labelText: "Email",
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                border: OutlineInputBorder(
                    borderSide: BorderSide(width: 0.2),
                    borderRadius: BorderRadius.circular(15)),
                focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(width: 1)),
                labelText: "Password",
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
              obscureText: !_passwordVisible,
            ),
            SizedBox(
              height: 6,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ForgotPasswordScreen()),
                  );
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Color(0xff281537),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _login();
              },
              child: Text(
                "Login",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                minimumSize: Size(340, 35),
                backgroundColor: Colors.purple[500],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 16.0), // Spacing between buttons

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildSocialButton(
                  icon: Image.asset('assets/images/facebook-logo.png',
                      height: 24.0), // Replace with your Facebook logo asset
                  text: 'Continue with Facebook',
                  onPressed: () {
                    // Handle Facebook login
                  },
                ),
                SizedBox(height: 16.0), // Spacing between buttons
                _buildSocialButton(
                  icon: Image.asset('assets/images/googlesymbol.png',
                      height: 24.0), // Replace with your Google logo asset
                  text: 'Continue with Google',
                  onPressed: () async {
                    GoogleSignIn _googleSignIn = GoogleSignIn();
                    try {
                      var result = await _googleSignIn.signIn();
                      print(result);
                    } catch (error) {
                      print(error);
                    }

                    // Handle Google login
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?", style: TextStyle(fontSize: 16),),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegScreen()),
                    );
                  },
                  child: Text(
                    "Sign Up",
                    style:
                    TextStyle(color: Colors.purple.shade500, fontSize: 16),
                  ),
                ),
              ],
            ),
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(20),
            //   child: Image.asset('assets/images/advertisemmet_app_logo.png',
            //       height: 90, width: 210),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton(
      {required Widget icon,
        required String text,
        required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: Text(
        text,
        style: TextStyle(color: Colors.black87), // Adjust text color as needed
      ),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black87,
        backgroundColor: Colors.white, // Text color when pressed
        minimumSize: Size(280.0, 40.0), // Adjust size as needed
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0), // Pill-shaped corners
        ),
        elevation: 3.0, // Optional shadow
      ),
    );
  }

  Widget _buildTypeButton(String text, String type) {
    bool isSelected = RegistrationTypeState.selectedType.value == type;

    return ElevatedButton(
      onPressed: () {
        RegistrationTypeState.selectedType.value = type;
        // Navigate to the corresponding registration screen
        if (type == 'Influencer') {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    celebrity.loginScreen()), // Navigate to the businessman screen, if it's the same, then it's ok.
          );
        } else if (type == 'Businessman') {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    customer.loginScreen()), // Navigate to the businessman screen, if it's the same, then it's ok.
          );
        } else if (type == 'Associate') {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    affiliate.loginScreen()), // Navigate to the job seeker screen.
          );
        }
        // If it is the influencer button, then you don't need to do anything.
      },
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
        minimumSize: Size(80, 30),
        backgroundColor: isSelected ? Colors.green[900] : Colors.purple[500],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: isSelected
              ? BorderSide(color: Colors.white, width: 2)
              : BorderSide.none,
        ),
      ),
    );
  }
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


