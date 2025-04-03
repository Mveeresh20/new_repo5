import 'package:flutter/material.dart';


class NewOtpScreen extends StatefulWidget {
  final String email;
  final String mobile;

  const NewOtpScreen({Key? key, required this.email, required this.mobile}) : super(key: key);

  @override
  NewOtpScreenState createState() => NewOtpScreenState();
}

class NewOtpScreenState extends State<NewOtpScreen> {
  final List<TextEditingController> _emailOtpControllers = List.generate(6, (index) => TextEditingController());
  final List<TextEditingController> _mobileOtpControllers = List.generate(6, (index) => TextEditingController());
  bool _isEmailOtpValid = false;
  bool _isMobileOtpValid = false;
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
          'Validate\nOTPs',
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
              'OTPs sent to ${widget.email} and ${widget.mobile}. Please check and validate.',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenHeight * 0.03),
            const Text(
              'Email OTP',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xffFF04AB),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            _buildOtpInputs(screenWidth, _emailOtpControllers, (value) {
              setState(() {
                _isEmailOtpValid = _emailOtpControllers.every((controller) => controller.text.isNotEmpty);
              });
            }),
            SizedBox(height: screenHeight * 0.02),
            _buildVerifyResendButtons(screenWidth, 'Email', _isEmailOtpValid ? _validateEmailOtp : null, _resendEmailOtp),
            SizedBox(height: screenHeight * 0.03),
            const Text(
              'Mobile OTP',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xffFF04AB),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            _buildOtpInputs(screenWidth, _mobileOtpControllers, (value) {
              setState(() {
                _isMobileOtpValid = _mobileOtpControllers.every((controller) => controller.text.isNotEmpty);
              });
            }),
            SizedBox(height: screenHeight * 0.02),
            _buildVerifyResendButtons(screenWidth, 'Mobile', _isMobileOtpValid ? _validateMobileOtp : null, _resendMobileOtp),
            SizedBox(height: screenHeight * 0.05),
            _buildButton(
              screenWidth,
              'Submit',
              const LinearGradient(
                colors: [
                  Color(0xffFF04AB),
                  Color(0xffAE26CD),
                ],
              ),
              (_isEmailOtpValid && _isMobileOtpValid && !_isLoading) ? _submit : null,
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

  Widget _buildOtpInputs(double screenWidth, List<TextEditingController> controllers, Function(String) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, (index) {
        return SizedBox(
          width: screenWidth * 0.12,
          child: TextField(
            controller: controllers[index],
            onChanged: (value) {
              if (value.isNotEmpty && index < 5) {
                FocusScope.of(context).nextFocus();
              }
              onChanged(value);
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

  Widget _buildVerifyResendButtons(double screenWidth, String type, Future<void> Function()? onVerify, Future<void> Function()? onResend) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButton(
          screenWidth * 0.35,
          'Verify $type',
          const LinearGradient(
            colors: [
              Color(0xffFF04AB),
              Color(0xffAE26CD),
            ],
          ),
          onVerify,
        ),
        _buildButton(
          screenWidth * 0.35,
          'Resend $type',
          const LinearGradient(
            colors: [
              Color(0xffFF04AB),
              Color(0xffAE26CD),
            ],
          ),
          onResend,
        ),
      ],
    );
  }

  Widget _buildButton(double screenWidth, String text, Gradient gradient, Future<void> Function()? onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 35,
        width: 142,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: gradient,
        ),
        child: Center(
          child: _isLoading && text == 'Submit'
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

  Future<void> _validateEmailOtp() async {
    // Implement email OTP validation logic here
    // Use _emailOtpControllers to get the entered OTP
    // Make API call to validate the OTP
    // Update _isLoading state accordingly
    // Handle success and error scenarios
  }

  Future<void> _resendEmailOtp() async {
    // Implement email OTP resend logic here
    // Make API call to resend the OTP
    // Update _isLoading state accordingly
    // Handle success and error scenarios
  }

  Future<void> _validateMobileOtp() async {
    // Implement mobile OTP validation logic here
    // Use _mobileOtpControllers to get the entered OTP
    // Make API call to validate the OTP
    // Update _isLoading state accordingly
    // Handle success and error scenarios
  }

  Future<void> _resendMobileOtp() async {
    // Implement mobile OTP resend logic here
    // Make API call to resend the OTP
    // Update _isLoading state accordingly
    // Handle success and error scenarios
  }

  Future<void> _submit() async {
    // Implement submit logic here
    // This function will be called when both email and mobile OTPs are valid
    // Make API call to submit the validated data
    // Update _isLoading state accordingly
    // Handle success and error scenarios
  }
}