import 'package:flutter/material.dart';

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
                  '\$${walletBalance.toStringAsFixed(2)}',
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
}
