/*import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:tngtong/config.dart';

class PaymentScreen extends StatefulWidget {
  final int packageId;
  final String userType;

  const PaymentScreen({
    Key? key,
    required this.packageId,
    required this.userType,
  }) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Map<String, dynamic>? package;
  double walletBalance = 0.0;
  double earningBalance = 0.0;
  String selectedPaymentMethod = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPackageDetails();
    fetchUserBalances();
  }

  Future<void> fetchPackageDetails() async {
    try {
      final response = await http.get(
        Uri.parse('${Config.get_package_details}${widget.packageId}/${widget.userType}'),
      );

      if (response.statusCode == 200) {
        setState(() {
          package = json.decode(response.body);
        });
      } else {
        print("Error fetching package details: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchUserBalances() async {
    try {
      final response = await http.get(
       // Uri.parse('${Config.get_user_balances}${widget.userType}'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          walletBalance = data['walletBalance'] ?? 0.0;
          earningBalance = data['earningBalance'] ?? 0.0;
        });
      } else {
        print("Error fetching balances: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  void proceedToPayment() {
    if (package == null) {
      Fluttertoast.showToast(msg: "Package details not loaded");
      return;
    }

    double packagePrice = double.parse(package!['price'].toString());

    if (selectedPaymentMethod == 'Wallet') {
      if (walletBalance >= packagePrice) {
        Fluttertoast.showToast(msg: "Payment Successful via Wallet");
      } else {
        Fluttertoast.showToast(msg: "Wallet balance is insufficient!");
      }
    } else if (selectedPaymentMethod == 'Earning') {
      if (earningBalance >= packagePrice) {
        Fluttertoast.showToast(msg: "Payment Successful via Earnings");
      } else {
        Fluttertoast.showToast(msg: "Earning balance is insufficient!");
      }
    } else if (selectedPaymentMethod == 'Razorpay') {
      Fluttertoast.showToast(msg: "Redirecting to Razorpay...");
    } else {
      Fluttertoast.showToast(msg: "Please select a payment method");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Options'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xffFF04AB), Color(0xffAE26CD)],
            ),
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : package == null
          ? const Center(child: Text("Failed to load package details"))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Package: ${package!['name']}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Price: ₹${package!['price']}",
              style: const TextStyle(fontSize: 18, color: Colors.blueAccent),
            ),
            const SizedBox(height: 20),

            // Wallet Balance
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: Icon(Icons.account_balance_wallet, color: Colors.green),
                title: Text("Wallet Balance: ₹${walletBalance.toStringAsFixed(2)}"),
                trailing: Radio(
                  value: 'Wallet',
                  groupValue: selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() => selectedPaymentMethod = value.toString());
                  },
                ),
              ),
            ),

            // Earning Balance
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: Icon(Icons.monetization_on, color: Colors.orange),
                title: Text("Earning Balance: ₹${earningBalance.toStringAsFixed(2)}"),
                trailing: Radio(
                  value: 'Earning',
                  groupValue: selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() => selectedPaymentMethod = value.toString());
                  },
                ),
              ),
            ),

            // Razorpay Option
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: Icon(Icons.payment, color: Colors.blue),
                title: Text("Pay via Razorpay"),
                trailing: Radio(
                  value: 'Razorpay',
                  groupValue: selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() => selectedPaymentMethod = value.toString());
                  },
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Proceed to Payment Button
            Center(
              child: ElevatedButton(
                onPressed: proceedToPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text("Proceed to Payment", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'WithdrawRequestScreen.dart';
import 'package:tngtong/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:tngtong/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class PaymentScreen extends StatefulWidget {
  final Map<String, dynamic> packageDetails; // Accept package details

  const PaymentScreen({
    Key? key,
    required this.packageDetails,
  }) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  SharedPreferences? prefs; // SharedPreferences instance
  String? loginEmail; // To store the retrieved email
  String? userId;
  double? walletBalance;
  late Razorpay _razorpay;
  double? packageAmount;
  double? earningBalance;
  String selectedPaymentMethod = '';
  String pkgName ='';
  String pkgId = '';

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    _initializePreferences(); // Fetch wallet & earning balances
  }
  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  Future<void> fetchUserId() async {
    String? id = await ApiService.getUserId(loginEmail);
    setState(() {
      userId = id;
    });
    getWallteBalance();
    getEarningBalance();
  }
  Future<void> _initializePreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      loginEmail = prefs?.getString('loginEmail');
    });
    print('Login Email: $loginEmail');
    fetchUserId();

  }

  Future<void> getEarningBalance() async {
    double? balance = await ApiService.getEarningsBal(userId,"brand");
    setState(() {
      earningBalance = balance ?? 0;
    });
  }
  Future<void> getWallteBalance() async {
    double? balance = await ApiService.getBrandWalletBalance(userId);
    setState(() {
      walletBalance = balance!;
    });
  }
  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Define the API endpoint celebrityUpdateWalletBal
    //String apiUrl = Config.celebrityUpdateWalletBal; // Change this to your API URL

    // Data to send
    Map<String, dynamic> postData = {
      'userId': userId, // Pass the actual c_id dynamically
      'amount':packageAmount, // Assuming ₹500 was added
      'pkgName':pkgName,
      'pkgId':pkgId,
      'userType':'brand',
      'status': 'success',
      'comment': '${pkgName} Package Recharge',
      'datetime': DateTime.now().toIso8601String(),
      'payment_id': response.paymentId,
      'mode': 'Razorpay',

    };

    try {
      final response = await http.post(
        Uri.parse('${Config.apiDomain}${Config.storePakageDetails}'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(postData),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true) {

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Payment Successful: ")),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Success: ${jsonResponse['message']}")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Server Error: ${response.statusCode}")),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update wallet: $error")),
      );
    }
  }


  void PurchagePackage(String mode) async {
    // Define the API endpoint celebrityUpdateWalletBal
    //String apiUrl = Config.celebrityUpdateWalletBal; // Change this to your API URL

    // Data to send
    Map<String, dynamic> postData = {
      'userId': userId, // Pass the actual c_id dynamically
      'amount':packageAmount, // Assuming ₹500 was added
      'pkgName':pkgName,
      'pkgId':pkgId,
      'userType':'brand',
      'status': 'debit',
      'comment': '${pkgName} Package Recharge',
      'datetime': DateTime.now().toIso8601String(),
      'payment_id': '',
      'mode': mode,

    };

    try {
      final response = await http.post(
        Uri.parse('${Config.apiDomain}${Config.storePakageDetails}'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(postData),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true) {

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Payment Successful: ")),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Success: ${jsonResponse['message']}")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Server Error: ${response.statusCode}")),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update wallet: $error")),
      );
    }
  }
  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Payment Failed: ${response.message}")),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("External Wallet Selected: ${response.walletName}")),
    );
  }

  void _startPayment( double amount) {
    var options = {
      'key': 'rzp_test_Inr1Lu5WMZuWiy',
      'amount': amount*100, // Amount in paise (₹500)
      'currency': 'INR',
      'name': 'Influencer Setter',
      'description': 'Package Recharge',
      'prefill': {'contact': '9876543210', 'email': 'test@example.com'},
      'theme': {'color': '#B81736'},
    };
    _razorpay.open(options);
  }
  void proceedToPayment() {
    double packagePrice = double.parse(widget.packageDetails['price'].toString());
    String packageName = widget.packageDetails['name'].toString();
    String packageId = widget.packageDetails['id'].toString();

    setState(() {
      packageAmount=packagePrice;
      pkgId=packageId;
      pkgName=packageName;


    });
    if (selectedPaymentMethod == 'Wallet') {
      if (walletBalance! >= packagePrice) {
        PurchagePackage("Wallet");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Wallet balance is insufficient!")),
        );
       // Fluttertoast.showToast(msg: "Wallet balance is insufficient!");
      }
    } else if (selectedPaymentMethod == 'Earning') {
      if (earningBalance! >= packagePrice) {
        PurchagePackage("Earnings");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Earning balance is insufficient!")),
        );
        //Fluttertoast.showToast(msg: "Earning balance is insufficient!");
      }
    } else if (selectedPaymentMethod == 'Razorpay') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Redirecting to Razorpay...")),
      );
      _startPayment(packagePrice);
     // Fluttertoast.showToast(msg: "Redirecting to Razorpay...");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select a payment method")),
      );
     // Fluttertoast.showToast(msg: "Please select a payment method");
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Options'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xffFF04AB), Color(0xffAE26CD)],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Package: ${widget.packageDetails['name']}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Price: ₹${widget.packageDetails['price']}",
              style: const TextStyle(fontSize: 18, color: Colors.blueAccent),
            ),
            const SizedBox(height: 20),

            // Wallet Balance Option
            InkWell(
              onTap: () => setState(() => selectedPaymentMethod = 'Wallet'),
              borderRadius: BorderRadius.circular(10),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading: const Icon(Icons.account_balance_wallet, color: Colors.green),
                  title: Text("Wallet Balance: ₹${walletBalance?.toStringAsFixed(2)}"),
                  trailing: Radio(
                    value: 'Wallet',
                    groupValue: selectedPaymentMethod,
                    onChanged: (value) => setState(() => selectedPaymentMethod = value.toString()),
                  ),
                ),
              ),
            ),

            // Earning Balance Option
            InkWell(
              onTap: () => setState(() => selectedPaymentMethod = 'Earning'),
              borderRadius: BorderRadius.circular(10),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading: const Icon(Icons.monetization_on, color: Colors.orange),
                  title: Text("Earning Balance: ₹${earningBalance?.toStringAsFixed(2)}"),
                  trailing: Radio(
                    value: 'Earning',
                    groupValue: selectedPaymentMethod,
                    onChanged: (value) => setState(() => selectedPaymentMethod = value.toString()),
                  ),
                ),
              ),
            ),

            // Razorpay Option
            InkWell(
              onTap: () => setState(() => selectedPaymentMethod = 'Razorpay'),
              borderRadius: BorderRadius.circular(10),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading: const Icon(Icons.payment, color: Colors.blue),
                  title: const Text("Pay via Razorpay"),
                  trailing: Radio(
                    value: 'Razorpay',
                    groupValue: selectedPaymentMethod,
                    onChanged: (value) => setState(() => selectedPaymentMethod = value.toString()),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Proceed to Payment Button
            Center(
              child: ElevatedButton(
                onPressed: proceedToPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text("Proceed to Payment", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
/*import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  final Map<String, dynamic> packageDetails;

  const PaymentScreen({Key? key, required this.packageDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment for ${packageDetails['name']}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Package: ${packageDetails['name']}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('Price: ₹${packageDetails['price']}', style: TextStyle(fontSize: 18)),
            Text('Features:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ...packageDetails['features'].map<Widget>((feature) {
              return Text('• $feature');
            }).toList(),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Implement payment process
                  print("Proceeding to payment for ${packageDetails['name']}");
                },
                child: Text('Proceed to Payment'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/


