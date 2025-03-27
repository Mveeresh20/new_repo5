import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tngtong/config.dart'; // Import the config file
import 'cel_dashboard.dart';

class ValidateEmailScreen extends StatefulWidget {
  final String email;

  const ValidateEmailScreen({Key? key, required this.email}) : super(key: key);

  @override
  _ValidateEmailScreenState createState() => _ValidateEmailScreenState();
}

class _ValidateEmailScreenState extends State<ValidateEmailScreen> {
  final List<TextEditingController> _otpControllers =
  List.generate(6, (index) => TextEditingController());
  bool _isOtpValid = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.25),
            child: _buildContent(screenHeight, screenWidth),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
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
          'Validate\nEmail',
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildContent(double screenHeight, double screenWidth) {
    return Container(
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
            SizedBox(height: screenHeight * 0.03),
            Text(
              'OTP sent to ${widget.email}. Please check your email and validate.',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenHeight * 0.03),
            const Text(
              'Enter OTP',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xffFF04AB),
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            _buildOtpInputs(screenWidth),
            SizedBox(height: screenHeight * 0.05),
            _buildButton(
              screenWidth,
              'Validate OTP',
              const LinearGradient(
                colors: [
                  Color(0xffFF04AB),
                  Color(0xffAE26CD),
                ],
              ),
              _isOtpValid && !_isLoading ? _validateOtp : null,
            ),
            SizedBox(height: screenHeight * 0.02),
            _buildButton(
              screenWidth,
              'Resend OTP',
              const LinearGradient(
                colors: [
                  Color(0xffFF04AB),
                  Color(0xffAE26CD),
                ],
              ),
              _resendOtp,
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Text(
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
    );
  }

  Widget _buildOtpInputs(double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, (index) {
        return SizedBox(
          width: screenWidth * 0.12,
          child: TextField(
            controller: _otpControllers[index],
            onChanged: (value) {
              if (value.isNotEmpty && index < 5) {
                FocusScope.of(context).nextFocus();
              }
              setState(() {
                _isOtpValid =
                    _otpControllers.every((controller) => controller.text.isNotEmpty);
              });
            },
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: const InputDecoration(
              counterText: '',
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffFF04AB), width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffFF04AB), width: 2),
              ),
              hintText: '-',
              hintStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        );
      }),
    );
  }

  Widget _buildButton(
      double screenWidth,
      String text,
      Gradient gradient,
      Future<void> Function()? onPressed,
      ) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 55,
        width: screenWidth * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: gradient,
        ),
        child: Center(
          child: _isLoading && text == 'Validate OTP'
              ? const CircularProgressIndicator(color: Colors.white)
              : Text(
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
/*
  Future<void> _validateOtp() async {
    setState(() {
      _isLoading = true;
    });

    //final otp = _otpControllers.map((controller) => controller.text).join();
    final otp ="191469";
    final url = Uri.parse('${Config.apiDomain}${Config.CustomerEmailotpverify}');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': widget.email, 'otp': otp}),
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(responseData['message'])),
      );
      Navigator.pushReplacementNamed(context, '/nextScreen');
    } else {
      final responseData = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(responseData['message'])),
      );
    }
  }*/
  Future<void> _validateOtp() async {
    setState(() {
      _isLoading = true;
    });
    //final otp ="191469";
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final otp = _otpControllers.map((controller) => controller.text).join(); // Dynamic OTP
    final url = Uri.parse('${Config.apiDomain}${Config.CelEmailotpverify}');

    try {
      /*final response = await http.post(
        url,
        //headers: {'Content-Type': 'application/json'},
      //  body: jsonEncode({'email': widget.email, 'otp': otp}),
        body:{'email': widget.email, 'otp': otp},
      );*/
      final response = await http.post(
        url,
        body: {'email':widget.email, 'otp': otp}, // Sending form-data
      );


      setState(() {
        _isLoading = false;
      });

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'])),
        );
        await prefs.setString('isBrandLogin', 'False');
        await prefs.setString('isCelLogin', 'True');
        await prefs.setString('loginEmail', widget.email);
        /*Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );*/

        //Navigator.pushReplacementNamed(context, '/HomeScreen'); // Navigate to the next screen
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'])),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Something went wrong. Please try again.')),
      );
      print('Error validating OTP: $e');
    }
  }


  Future<void> _resendOtp() async {
    // Show loading snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Resending OTP...')),
    );

    try {
      final url = Uri.parse('${Config.apiDomain}${Config.resendOtpEndpoint}');
      // final url = Uri.parse('https://demo.infoskaters.com/api/resendOtp.php');
      print('Sending request to: $url'); // Debug print

      final response = await http.post(
        url,
        // headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': '${widget.email}',
          'user_type': "celebrity",
        }),
      );



      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Success - show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'])),
        );
      } else {
        // Error - show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'] ?? 'Failed to resend OTP')),
        );
      }
    } catch (e) {
      // Network or other errors
      print('Error: ${e.toString()}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }
}
