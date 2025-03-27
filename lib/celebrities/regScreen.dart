/*import 'package:flutter/material.dart';
import 'loginScreen.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tngtong/config.dart'; // Import the config file
import 'package:tngtong/toast_utils.dart';
import 'ValidateEmailScreen.dart';
import 'package:tngtong/celebrities/regScreen.dart' as celebrities;
import 'package:tngtong/customer/regScreen.dart' as customer;
import 'package:tngtong/affiliate/regScreen.dart' as affiliate;

class RegScreen extends StatefulWidget {
  const RegScreen({Key? key}) : super(key: key);

  @override
  _RegScreenState createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  bool _passwordVisible = false; // For Password visibility toggle
  bool _confirmPasswordVisible = false; // For Confirm Password visibility toggle

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _referralIdController = TextEditingController();

  Future<void> _registerUser() async {
    // Prepare the data to send to the backend
    final String fullName = _fullNameController.text;
    final String email = _emailController.text;
    final String mob = _mobController.text;

    final String password = _passwordController.text;
    final String cpassword = _confirmPasswordController.text;
    final String referralId = _referralIdController.text;

    // Use the Config class to get the API domain and endpoint
    final url = Uri.parse('${Config.apiDomain}${Config.celebrity_reg}');

    // Send a POST request to the PHP backend
    final response = await http.post(
      url,
      body: {
        'c_name': fullName,
        'c_email': email,
        'c_mob': mob, // Update the variable name as per your input controller
        'c_password': password,
        'c_cpassword': cpassword,
        'referralId':referralId,
      },

    );

    print(response.body);  // Add this to see the actual response
    final responseData = json.decode(response.body);
    /*if (response.statusCode == 200) {
      ToastUtils.showSuccess('Registration successful!');
    }*/
    if (responseData.containsKey('message') && responseData['message'] != null) {
      // Display the message from the response
      ToastUtils.showSuccess(responseData['message']);
    } else {
      // Handle the case where the message is not available
      ToastUtils.showSuccess('Something is wrong!!');
    }
    // print('Response status code: ${response.statusCode}');


    if (response.statusCode == 200) {
      // ToastUtils.showSuccess('Something is wrong!!');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ValidateEmailScreen(email: email),
        ),
      );


      // Navigate to the next screen
      /* Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ValidateEmailScreen()),
      );*/
      // ToastUtils.showSuccess('Registration successful!');
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xffFF04AB),
                Color(0xffAE26CD),
              ]),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 60.0, left: 22),
              child: Text(
                'Create Your\nAccount',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _fullNameController,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.check,
                          color: Colors.grey,
                        ),
                        label: Text(
                          'Full Name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffFF04AB),
                          ),
                        ),
                      ),
                    ),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.check,
                          color: Colors.grey,
                        ),
                        label: Text(
                          'Email',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffFF04AB),
                          ),
                        ),
                      ),
                    ),TextField(
                      controller: _mobController,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.check,
                          color: Colors.grey,
                        ),
                        label: Text(
                          'Mobile No',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffFF04AB),
                          ),
                        ),
                      ),
                    ),
                    TextField(
                      controller: _passwordController,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
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
                    TextField(
                      controller: _confirmPasswordController,
                      obscureText: !_confirmPasswordVisible,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _confirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _confirmPasswordVisible = !_confirmPasswordVisible;
                            });
                          },
                        ),
                        label: const Text(
                          'Confirm Password',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffFF04AB),
                          ),
                        ),
                      ),
                    ),
                    TextField(
                      controller: _referralIdController,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.check,
                          color: Colors.grey,
                        ),
                        label: Text(
                          'Refferal Id',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffFF04AB),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: _registerUser, // Call the register function
                      child: Container(
                        height: 55,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xffFF04AB),
                              Color(0xffAE26CD),
                            ],
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Column(
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),

                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => loginScreen()),
                            );
                          },
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:tngtong/celebrities/regScreen.dart' as celebrities;
import 'package:tngtong/customer/regScreen.dart' as customer;
import 'package:tngtong/registration_type_state.dart';
import 'loginScreen.dart';
import 'package:tngtong/affiliate/regScreen.dart' as affiliate;

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tngtong/config.dart'; // Import the config file
import 'package:tngtong/toast_utils.dart';
import 'ValidateEmailScreen.dart';
import 'package:url_launcher/url_launcher.dart';

class RegScreen extends StatefulWidget {
  const RegScreen({Key? key}) : super(key: key);

  @override
  _RegScreenState createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  bool isChecked = false;
  bool _passwordVisible = false; // For Password visibility toggle
  bool _confirmPasswordVisible = false;
  String? errorMessage; // For Confirm Password visibility toggle

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();
  final TextEditingController _referralIdController = TextEditingController();

  void _validateAndSubmit() {
    setState(() {
      if (!isChecked) {
        errorMessage = "You must agree to the terms and conditions.";
      } else {
        errorMessage = null;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Form submitted successfully! ✅")),
        );
      }
    });
  }

  Future<void> _registerUser() async {

    if (!isChecked) {
      setState(() {
        errorMessage = "You must agree to the Terms and Conditions.";
      });
      return; // Stop execution if checkbox is unchecked
    }
    // Prepare the data to send to the backend
    final String fullName = _fullNameController.text;
    final String email = _emailController.text;
    final String mob = _mobController.text;

    final String password = _passwordController.text;
    final String cpassword = _confirmPasswordController.text;
    final String referralId = _referralIdController.text;

    // Use the Config class to get the API domain and endpoint
    final url = Uri.parse('${Config.apiDomain}${Config.celebrity_reg}');

    // Send a POST request to the PHP backend
    final response = await http.post(
      url,
      body: {
        'c_name': fullName,
        'c_email': email,
        'c_mob': mob, // Update the variable name as per your input controller
        'c_password': password,
        'c_cpassword': cpassword,
        'referralId': referralId,
      },
    );

    print(response.body); // Add this to see the actual response
    final responseData = json.decode(response.body);
    /*if (response.statusCode == 200) {
      ToastUtils.showSuccess('Registration successful!');
    }*/
    if (responseData.containsKey('message') &&
        responseData['message'] != null) {
      // Display the message from the response
      ToastUtils.showSuccess(responseData['message']);
    } else {
      // Handle the case where the message is not available
      ToastUtils.showSuccess('Something is wrong!!');
    }
    // print('Response status code: ${response.statusCode}');

    if (response.statusCode == 200) {
      // ToastUtils.showSuccess('Something is wrong!!');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ValidateEmailScreen(email: email),
        ),
      );

      // Navigate to the next screen
      /* Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ValidateEmailScreen()),
      );*/
      // ToastUtils.showSuccess('Registration successful!');
    }
  }
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
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
                  "Select a Profile & Register",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                )
              ],
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
              controller: _fullNameController,
              decoration: InputDecoration(
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
                labelText: "Your name",
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 8),
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
              controller: _mobController,
              decoration: InputDecoration(
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
                  labelText: "Mobile Number",
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
              keyboardType: TextInputType.number,
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
                labelText: "Set Your Password",
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
              height: 8,
            ),
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: !_confirmPasswordVisible,
              decoration: InputDecoration(
                contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                prefixIcon: Icon(Icons.confirmation_num),
                suffixIcon: IconButton(
                  icon: Icon(
                    _confirmPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _confirmPasswordVisible = !_confirmPasswordVisible;
                    });
                  },
                ),
                label: const Text(
                  'Confirm Password',
                  // style: TextStyle(
                  //   fontWeight: FontWeight.bold,
                  //   color: Color(0xffB81736),
                  // ),
                ),
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: _referralIdController,
              decoration: InputDecoration(
                contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                prefixIcon: Icon(Icons.person_add),
                suffixIcon: Icon(
                  Icons.check,
                ),
                label: Text(
                  'Refferal Code',
                  // style: TextStyle(
                  //   fontWeight: FontWeight.bold,
                  //   color: Color(0xffB81736),
                  // ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: isChecked, // Replace with your state
                  onChanged: (bool? value) {

                    setState(() {
                      isChecked = value!;
                      errorMessage = null; // Clear error when checked
                    });
                  },
                ),
                GestureDetector(
                  onTap: () {
                    _launchURL("https://influencersetter.com/terms-conditions.html"); // Replace with your URL
                  },
                  child: Text.rich( // Add `child:` here
                    TextSpan(
                      children: [
                        const TextSpan(text: "I agree to the "),
                        TextSpan(
                          text: "Terms and Conditions",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            color: Colors.black, // Optional: Add color to make it look like a link
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],

            ),
            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  errorMessage!,
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _registerUser();
              },
              child: Text(
                "Create Account",
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
            SizedBox(
              height: 20,
            ),
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
                  onPressed: () {
                    // Handle Google login
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => loginScreen()),
                    );
                  },
                  child: Text(
                    "Login here",
                    style: TextStyle(color: Colors.purple.shade500),
                  ),
                ),
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/advertisemmet_app_logo.png',
                  height: 90, width: 210),
            ),
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
                    celebrities.RegScreen()), // Navigate to the businessman screen, if it's the same, then it's ok.
          );
        } else if (type == 'Businessman') {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    customer.RegScreen()), // Navigate to the businessman screen, if it's the same, then it's ok.
          );
        } else if (type == 'Associate') {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    affiliate.RegScreen()), // Navigate to the job seeker screen.
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



