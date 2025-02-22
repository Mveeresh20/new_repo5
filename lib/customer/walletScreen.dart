/*import 'package:flutter/material.dart';
import 'package:tngtong/config.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  double walletBalance = 5000.0;
  List<Map<String, String>> transactions = [
    {'type': 'Credit', 'amount': '₹1000', 'date': 'Jan 20, 2025'},
    {'type': 'Debit', 'amount': '₹500', 'date': 'Jan 18, 2025'},
    {'type': 'Credit', 'amount': '₹2000', 'date': 'Jan 15, 2025'},
    {'type': 'Debit', 'amount': '₹700', 'date': 'Jan 10, 2025'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Wallet Balance Display
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              color: Colors.deepPurpleAccent,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text(
                      'Wallet Balance',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '₹$walletBalance',
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_downward),
                  label: const Text('Withdraw'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add_circle),
                  label: const Text('Recharge'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Wallet Transactions History
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Transaction History',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      const Divider(),
                      Expanded(
                        child: ListView.builder(
                          itemCount: transactions.length,
                          itemBuilder: (context, index) {
                            final transaction = transactions[index];
                            return ListTile(
                              leading: Icon(
                                transaction['type'] == 'Credit'
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward,
                                color: transaction['type'] == 'Credit'
                                    ? Colors.green
                                    : Colors.red,
                              ),
                              title: Text(
                                transaction['amount']!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(transaction['date']!),
                              trailing: Text(
                                transaction['type']!,
                                style: TextStyle(
                                  color: transaction['type'] == 'Credit'
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
/*import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
        backgroundColor: const Color(0xffB81736),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              color: const Color(0xffB81736),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Wallet Balance',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '₹5000',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: const Text('Recharge Wallet'),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Text('Withdraw Balance'),
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
                itemCount: demoTransactions.length,
                itemBuilder: (context, index) {
                  final transaction = demoTransactions[index];
                  return ListTile(
                    leading: Icon(
                      transaction['type'] == 'credit'
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      color: transaction['type'] == 'credit'
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
                        color: transaction['type'] == 'credit'
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
}

// Demo JSON data for transaction history
List<Map<String, dynamic>> demoTransactions = [
  {
    'type': 'credit',
    'description': 'Payment received',
    'amount': 2000,
    'date': '2025-02-05',
  },
  {
    'type': 'debit',
    'description': 'Order purchase',
    'amount': 1500,
    'date': '2025-02-03',
  },
  {
    'type': 'credit',
    'description': 'Referral bonus',
    'amount': 500,
    'date': '2025-02-01',
  },
  {
    'type': 'debit',
    'description': 'Subscription fee',
    'amount': 300,
    'date': '2025-01-28',
  },
];*/
import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
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
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xffB81736),
                      Color(0xff281537),
                    ],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Wallet Balance',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '₹5000',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffF4A261),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Recharge Wallet'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
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
                itemCount: demoTransactions.length,
                itemBuilder: (context, index) {
                  final transaction = demoTransactions[index];
                  return ListTile(
                    leading: Icon(
                      transaction['type'] == 'credit'
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      color: transaction['type'] == 'credit'
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
                        color: transaction['type'] == 'credit'
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
}

// Demo JSON data for transaction history
List<Map<String, dynamic>> demoTransactions = [
  {
    'type': 'credit',
    'description': 'Payment received',
    'amount': 2000,
    'date': '2025-02-05',
  },
  {
    'type': 'debit',
    'description': 'Order purchase',
    'amount': 1500,
    'date': '2025-02-03',
  },
  {
    'type': 'credit',
    'description': 'Referral bonus',
    'amount': 500,
    'date': '2025-02-01',
  },
  {
    'type': 'debit',
    'description': 'Subscription fee',
    'amount': 300,
    'date': '2025-01-28',
  },
];
