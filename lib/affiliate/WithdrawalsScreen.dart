/*import 'package:flutter/material.dart';

class WithdrawalsScreen extends StatefulWidget {
  const WithdrawalsScreen({Key? key}) : super(key: key);

  @override
  _WithdrawalsScreenState createState() => _WithdrawalsScreenState();
}

class _WithdrawalsScreenState extends State<WithdrawalsScreen> {
  double walletBalance = 500.00;

  List<Map<String, dynamic>> withdrawals = [
    {'id': 1, 'amount': '\$100', 'status': 'pending', 'date': '2024-01-15'},
    {'id': 2, 'amount': '\$150', 'status': 'rejected', 'date': '2024-01-20'},
    {'id': 3, 'amount': '\$200', 'status': 'completed', 'date': '2024-02-05'},
    {'id': 4, 'amount': '\$50', 'status': 'pending', 'date': '2024-02-10'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Withdrawals'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffB81736),
                Color(0xff281537),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Wallet Balance:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xffE76F51), Color(0xff2A9D8F)],
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  '\₹${walletBalance.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Withdrawal Requests:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: withdrawals.length,
                itemBuilder: (context, index) {
                  final withdrawal = withdrawals[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Text('Amount: ${withdrawal['amount']}'),
                      subtitle: Text('Date: ${withdrawal['date']}'),
                      trailing: Text(
                        withdrawal['status'].toUpperCase(),
                        style: TextStyle(
                          color: withdrawal['status'] == 'completed'
                              ? Colors.green
                              : withdrawal['status'] == 'pending'
                              ? Colors.orange
                              : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'WithdrawRequestScreen.dart';

import 'package:tngtong/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:tngtong/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*class WithdrawalsScreen extends StatefulWidget {
  const WithdrawalsScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawalsScreen> createState() => _WithdrawalsScreenState();
}*/

class WithdrawalsScreen extends StatefulWidget {
  const WithdrawalsScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawalsScreen> createState() => _WithdrawalsScreenState();
}

class _WithdrawalsScreenState extends State<WithdrawalsScreen> {
  SharedPreferences? prefs; // SharedPreferences instance
  String? loginEmail; // To store the retrieved email
  String? userId;
  double? walletBalance;
  late Razorpay _razorpay;
  List<Map<String, dynamic>> transactions = [];

  @override
  void initState() {
    super.initState();
    _initializePreferences();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }
  Future<void> fetchUserId() async {
    String? id = await ApiService.getAffilaterId(loginEmail);
    setState(() {
      userId = id;
    });
    getWallteBalance();
    getTransactionHistory();
  }
  Future<void> _initializePreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      loginEmail = prefs?.getString('loginEmail');
    });
    print('Login Email: $loginEmail');
    fetchUserId();

  }
  Future<void> getWallteBalance() async {
    double? balance = await ApiService.getEarningsBal(userId,"affiliater");
    setState(() {
      walletBalance = balance ?? 0;

    });

  }

  Future<void> getTransactionHistory() async {
    try {
      final response = await http.get(
        Uri.parse('${Config.getEarningsTransactions}$userId&userType=affiliater'),
        //Uri.parse('https://demo.infoskaters.com/api/getEarningsTransactions.php?userId=$userId&userType=celebrity'),

        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        setState(() {
          transactions = jsonResponse.map((data) {
            return {
              'type': data['status'],
              'description': data['comment'],
              'amount': data['amount'],
              'date': data['datetime']
            };
          }).toList();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${response.statusCode}")),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load transactions: $error")),
      );
    }
  }

  /* void _handlePaymentSuccess(PaymentSuccessResponse response) {
    setState(() {
      walletBalance += 500; // Assuming ₹500 was added
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Payment Successful: ${response.paymentId}")),
    );
  }*/
  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Define the API endpoint celebrityUpdateWalletBal
    //String apiUrl = Config.celebrityUpdateWalletBal; // Change this to your API URL

    // Data to send
    Map<String, dynamic> postData = {
      'a_id': userId, // Pass the actual c_id dynamically
      'amount': '500', // Assuming ₹500 was added
      'status': 'credit',
      'comment': 'Wallet Recharge',
      'datetime': DateTime.now().toIso8601String(),
      'payment_id': response.paymentId,
      'mode': 'Razorpay',
    };

    try {
      final response = await http.post(
        Uri.parse('${Config.apiDomain}${Config.celebrityUpdateWalletBal}'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(postData),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true) {
          getWallteBalance();
          getTransactionHistory();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Payment Successful: ")),
          );
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

  void _startPayment() {
    var options = {
      'key': 'rzp_test_Inr1Lu5WMZuWiy',
      'amount': 50000, // Amount in paise (₹500)
      'currency': 'INR',
      'name': 'Influencer Setter',
      'description': 'Wallet Recharge',
      'prefill': {'contact': '9876543210', 'email': 'test@example.com'},
      'theme': {'color': '#B81736'},
    };
    _razorpay.open(options);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Earnings'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xffB81736), Color(0xff281537)],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xffB81736), Color(0xff281537)],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Earnings Balance',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '₹$walletBalance',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        /* Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              _startPayment();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffF4A261),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Recharge Wallet'),
                          ),
                        ),
                        const SizedBox(width: 10),*/
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              _showWithdrawDialog(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffE76F51),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Withdraw Balance'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Transaction History',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  return ListTile(
                    leading: Icon(
                      (transaction['type'] == 'credit' || transaction['type'] == 'Credit')
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      color: (transaction['type'] == 'credit' || transaction['type'] == 'Credit')
                          ? Colors.green
                          : Colors.red,
                    ),
                    title: Text(transaction['description']),
                    subtitle: Text(transaction['date']),
                    trailing: Text(
                      '₹${transaction['amount']}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: (transaction['type'] == 'credit' || transaction['type'] == 'Credit')
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showWithdrawDialog(BuildContext context) {
    TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text('Enter Withdrawal Amount'),
          content: TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Enter amount',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                String amount = amountController.text;
                if (amount.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Withdrawal request sent for ₹$amount')),
                  );
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Send Request'),
            ),
          ],
        );
      },
    );
  }
}
