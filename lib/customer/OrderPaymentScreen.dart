import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tngtong/api_service.dart'; // Replace with your actual API service
import 'package:tngtong/config.dart'; // Replace with your actual config file
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tngtong/toast_utils.dart';

class OrderPaymentScreen extends StatefulWidget {
  final Map<String, dynamic> influencer;
  final String requirement;

  OrderPaymentScreen({Key? key, required this.influencer, required this.requirement}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<OrderPaymentScreen> {
  SharedPreferences? prefs;
  String? loginEmail;
  String? userId;
  double? walletBalance;
  double? earningBalance;
  String selectedPaymentMethod = ''; // To track selected payment method

  @override
  void initState() {
    super.initState();
    _initializePreferences();
  }

  Future<void> _initializePreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      loginEmail = prefs?.getString('loginEmail');
    });
    fetchUserId();
  }

  Future<void> fetchUserId() async {
    String? id = await ApiService.getUserId(loginEmail);
    setState(() {
      userId = id;
    });
    getWalletBalance();
    getEarningBalance();
  }

  Future<void> getWalletBalance() async {
    double? balance = await ApiService.getBrandWalletBalance(userId);
    setState(() {
      walletBalance = balance ?? 0;
    });
  }

  Future<void> getEarningBalance() async {
    double? balance = await ApiService.getEarningsBal(userId, "brand");
    setState(() {
      earningBalance = balance ?? 0;
    });
  }

  void _purchasePackage(String mode) async {
    Map<String, dynamic> postData = {
      'userId': userId,
      'amount': widget.influencer['price'],
      'c_Name': widget.influencer['name'],
      'c_id': widget.influencer['id'],
      'userType': 'brand',
      'status': 'debit',
      'comment': '${widget.influencer['name']} Influncer Booking Charge',
      'datetime': DateTime.now().toIso8601String(),
      'payment_id': '',
      'mode': mode,
      'requirement':widget.requirement,
    };

    try {
      final response = await http.post(
        Uri.parse('${Config.apiDomain}${Config.storeBooking}'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(postData),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true) {
          ToastUtils.showSuccess('Payment Successful!');
          _showPaymentSuccessDialog();
         /* ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Payment Successful!")),
          );*/
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: ${jsonResponse['message']}")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Server Error: ${response.statusCode}")),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to process payment: $error")),
      );
    }
  }

 /* void proceedToPayment() {
    double packagePrice = widget.influencer['price'];
    if (selectedPaymentMethod == 'Wallet') {
      if (walletBalance! >= packagePrice) {
        _purchasePackage("Wallet");
      } else {
        ToastUtils.showError('Insufficient Wallet Balance!');

       /* ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Insufficient Wallet Balance!")),
        );*/
      }
    } else if (selectedPaymentMethod == 'Earning') {
      if (earningBalance! >= packagePrice) {
        _purchasePackage("Earnings");
      } else{
        ToastUtils.showError('Insufficient Earning Balance!');
/*
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Insufficient Earning Balance!")),
        );*/
      }
    } else {
      ToastUtils.showError('Please select a payment method!');
/*
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select a payment method!")),
      );*/
    }
  }*/
  void proceedToPayment() {
    try {
      if (selectedPaymentMethod.isEmpty) {
        ToastUtils.showError('Please select a payment method!');
        return;
      }

      // Convert price from string to double
      double packagePrice;
      try {
        packagePrice = double.parse(widget.influencer['price'].toString());
      } catch (e) {
        ToastUtils.showError('Invalid price format!');
        return;
      }

      if (selectedPaymentMethod == 'Wallet') {
        if (walletBalance! >= packagePrice) {
          _purchasePackage("Wallet");
        } else {
          ToastUtils.showError('Insufficient Wallet Balance!');
        }
      } else if (selectedPaymentMethod == 'Earning') {
        if (earningBalance! >= packagePrice) {
          _purchasePackage("Earnings");
        } else {
          ToastUtils.showError('Insufficient Earning Balance!');
        }
      }
    } catch (error) {
      print('Error in proceedToPayment: $error'); // Log the error
      ToastUtils.showError('An error occurred. Please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Payment", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          _buildGradientBackground(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 80),
                _buildInfluencerCard(),
                SizedBox(height: 20),
                _buildPaymentOptions(),
                SizedBox(height: 20),
                _buildProceedButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradientBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade800, Colors.cyan.shade400],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  Widget _buildInfluencerCard() {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: widget.influencer['image'] != null && widget.influencer['image'].isNotEmpty
                  ? NetworkImage("${Config.apiDomain}/${widget.influencer['image']}")
                  : AssetImage('assets/default_profile.png') as ImageProvider,
            ),
            SizedBox(height: 10),
            Text(
              widget.influencer['name'] ?? 'Unknown',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            SizedBox(height: 5),
            Text(
              "₹${widget.influencer['price'] ?? 'N/A'}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            SizedBox(height: 10),
            Text(
              "Requirement: ${widget.requirement.isEmpty ? 'No details provided' : widget.requirement}",
              style: TextStyle(fontSize: 16, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Select Payment Method:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        SizedBox(height: 10),
        _buildPaymentButton("Wallet", Icons.account_balance_wallet, walletBalance),
        SizedBox(height: 10),
        _buildPaymentButton("Earning", Icons.monetization_on, earningBalance),
      ],
    );
  }

  Widget _buildPaymentButton(String method, IconData icon, double? balance) {
    return Card(
      color: selectedPaymentMethod == method ? Colors.white : Colors.white.withOpacity(0.8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text("$method Balance: ₹${balance?.toStringAsFixed(2) ?? '0.00'}"),
        trailing: selectedPaymentMethod == method ? Icon(Icons.check_circle, color: Colors.green) : null,
        onTap: () {
          setState(() {
            selectedPaymentMethod = method;
          });
        },
      ),
    );
  }

  Widget _buildProceedButton() {
    return Center(
      child: ElevatedButton(
        onPressed: proceedToPayment,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Text(
            "Proceed to Pay ₹${widget.influencer['price'] ?? 'N/A'}",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 5,
        ),
      ),
    );
  }

  void _showPaymentSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Payment Successful"),
        content: Text("Your payment for ${widget.influencer['name']} has been completed successfully."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Go back to the previous screen
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }
}