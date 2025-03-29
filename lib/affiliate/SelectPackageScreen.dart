/*import 'package:flutter/material.dart';

class SelectPackageScreen extends StatefulWidget {
  const SelectPackageScreen({Key? key}) : super(key: key);

  @override
  _SelectPackageScreenState createState() => _SelectPackageScreenState();
}

class _SelectPackageScreenState extends State<SelectPackageScreen> {
  int selectedPackageId = 0;
  String currentPackage = 'Standard Package';
  String expiryDate = '2025-12-31';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Package'),
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
              elevation: 5,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xffE76F51), Color(0xff2A9D8F)],
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Package: $currentPackage',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Expires on: $expiryDate',
                      style: const TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: packages.length,
                itemBuilder: (context, index) {
                  final package = packages[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            selectedPackageId == package['id']
                                ? Colors.orangeAccent
                                : const Color(0xffB81736),
                            const Color(0xff281537),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            package['name'],
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Price: ${package['price']}',
                            style: const TextStyle(fontSize: 16, color: Colors.white70),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Features:',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          ...package['features'].map<Widget>((feature) {
                            return Text(
                              '• $feature',
                              style: const TextStyle(color: Colors.white70),
                            );
                          }).toList(),
                          const SizedBox(height: 10),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() => selectedPackageId = package['id']);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orangeAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text('Buy Package'),
                            ),
                          ),
                        ],
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

// Demo JSON data for packages
List<Map<String, dynamic>> packages = [
  {
    'id': 1,
    'name': 'Basic Package',
    'price': '\$99',
    'features': [
      'Feature 1',
      'Feature 2',
      'Feature 3',
    ]
  },
  {
    'id': 2,
    'name': 'Standard Package',
    'price': '\$199',
    'features': [
      'Feature 1',
      'Feature 2',
      'Feature 3',
      'Feature 4',
    ]
  },
  {
    'id': 3,
    'name': 'Premium Package',
    'price': '\$299',
    'features': [
      'Feature 1',
      'Feature 2',
      'Feature 3',
      'Feature 4',
      'Feature 5',
    ]
  }
];
*/
/*
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tngtong/config.dart';

class SelectPackageScreen extends StatefulWidget {
  final String userType="affilater";

  //const SelectPackageScreen({Key? key, required this.userType}) : super(key: key);

  @override
  _SelectPackageScreenState createState() => _SelectPackageScreenState();
}

class _SelectPackageScreenState extends State<SelectPackageScreen> {
  int selectedPackageId = 0;
  List<Map<String, dynamic>> packages = [];

  @override
  void initState() {
    super.initState();
    fetchPackages();
  }

  Future<void> fetchPackages() async {
    final response = await http.get(
        Uri.parse('${Config.get_packages}affilater'),
    );

    if (response.statusCode == 200) {
      setState(() {
        packages = List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    } else {
      print("Failed to fetch packages");
    }
  }

  void navigateToPaymentScreen(Map<String, dynamic> package) {
    /*Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentScreen(package: package),
      ),
    );*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Package'),
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
        child: packages.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: packages.length,
          itemBuilder: (context, index) {
            final package = packages[index];

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: selectedPackageId == package['id']
                        ? [Colors.orangeAccent, Colors.deepOrange]
                        : [const Color(0xffB81736), const Color(0xff281537)],
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      package['name'],
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Price: ₹${package['price']}',
                      style: const TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Features:',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    ...package['features'].map<Widget>((feature) {
                      return Text(
                        '• $feature',
                        style: const TextStyle(color: Colors.white70),
                      );
                    }).toList(),
                    const SizedBox(height: 10),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() => selectedPackageId = package['id']);
                          navigateToPaymentScreen(package);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orangeAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Buy Package'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
*/


/*
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tngtong/config.dart';
import 'PackagePaymentScreen.dart';

class SelectPackageScreen extends StatefulWidget {
 /* final String userType;

  const SelectPackageScreen({Key? key, required this.userType}) : super(key: key);*/

  @override
  _SelectPackageScreenState createState() => _SelectPackageScreenState();
}

class _SelectPackageScreenState extends State<SelectPackageScreen> {
  int selectedPackageId = 0;
  List<Map<String, dynamic>> packages = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPackages();
  }

  Future<void> fetchPackages() async {
    try {
      final response = await http.get(
        Uri.parse('${Config.get_packages}affilater'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse.isNotEmpty) {
          setState(() {
            packages = jsonResponse.map((pkg) {
              return {
                "id": pkg["id"],
                "name": pkg["name"] ?? "No Name",
                "price": pkg["price"] ?? "0",
                "features": (pkg["features"] as List<dynamic>?)?.whereType<String>().toList() ?? [],
              };
            }).toList();
          });
        } else {
          print("Empty package list received");
        }
      } else {
        print("Error fetching data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void navigateToPaymentScreen(Map<String, dynamic> package) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentScreen(packageDetails: package),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Package'),
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
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : packages.isEmpty
            ? const Center(child: Text("No packages available"))
            : ListView.builder(
          itemCount: packages.length,
          itemBuilder: (context, index) {
            final package = packages[index];

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: selectedPackageId == package['id']
                        ? [Colors.orangeAccent, Colors.deepOrange]
                        : [const Color(0xffFF04AB), const Color(0xffAE26CD)],
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      package['name'],
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Price: ₹${package['price']}',
                      style: const TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Features:',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    ...package['features'].map<Widget>((feature) {
                      return Text(
                        '• $feature',
                        style: const TextStyle(color: Colors.white70),
                      );
                    }).toList(),
                    const SizedBox(height: 10),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentScreen(packageDetails: package),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orangeAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Buy Package'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
*/

//update by veeresh
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tngtong/config.dart';
import 'PackagePaymentScreen.dart';

class SelectPackageScreen extends StatefulWidget {
  /* final String userType;

  const SelectPackageScreen({Key? key, required this.userType}) : super(key: key);*/

  @override
  _SelectPackageScreenState createState() => _SelectPackageScreenState();
}

class _SelectPackageScreenState extends State<SelectPackageScreen> {
  int selectedPackageId = 0;
  List<Map<String, dynamic>> packages = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPackages();
  }
  final Map<String, Color> labelColors = {
    'Free': Colors.green,
    'Gold': Colors.amber,
    // Add more colors if needed for other package types
  };
  final Map<String, String> labelTexts = {
    'Free': 'FREE',
    'Gold': 'BEST VALUE',
    // Add more labels if needed
  };
  final Map<int, String> specificLabels = {
    0: 'FREE', // Index 0 for the first card
    1: 'VALUE', // Index 1 for the second card
    2: 'BEST VALUE', // Index 2 for the third card
    3: 'BEST OFFER', // Index 3 for the fourth card
    4: 'CUSTOM PLAN', // Index 4 for the fifth card
  };
  final Map<int, Color> specificLabelColors = {
    0: Colors.green,
    1: Colors.blue,
    2: Colors.amber,
    3: Colors.orange,
    4: Colors.green, // Color for Custom Plan
  };
  final List<List<Color>> cardGradients = [
    [Colors.green.shade100, Colors.green.shade300], // Example gradient for Free
    [Colors.grey.shade200, Colors.grey.shade500], // Example gradient for Silver
    [Colors.cyan.shade200, Colors.cyan.shade400], // Example gradient for Gold
    [Colors.orange.shade100, Colors.orange.shade400], // Example gradient for Platinum
    [Colors.lightBlue.shade100, Colors.lightBlue.shade300], // Example gradient for Custom Plan
    // Add more gradients for other potential packages
  ];

  Color _getCardBackgroundColor(int index) {
    if (index < cardGradients.length) {
      return cardGradients[index][0]; // Default to the start color of the gradient
    }
    return Colors.grey.shade200; // Default if no specific gradient is defined
  }

  LinearGradient _getCardGradient(int index) {
    if (index < cardGradients.length) {
      return LinearGradient(
        colors: cardGradients[index],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
    return const LinearGradient(
      colors: [Colors.grey, Colors.grey], // Default grey gradient
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  Future<void> fetchPackages() async {
    try {
      final response = await http.get(
        Uri.parse('${Config.get_packages}affilater'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse.isNotEmpty) {
          setState(() {
            packages = jsonResponse.map((pkg) {
              return {
                "id": pkg["id"],
                "name": pkg["name"] ?? "No Name",
                "price": pkg["price"] ?? "0",
                "features": (pkg["features"] as List<dynamic>?)?.whereType<String>().toList() ?? [],
              };
            }).toList();
          });
        } else {
          print("Empty package list received");
        }
      } else {
        print("Error fetching data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void navigateToPaymentScreen(Map<String, dynamic> package) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentScreen(packageDetails: package),
      ),
    );
  }

  Widget _buildLabel(String packageName, int index) {
    String? labelText;
    Color? labelColor;

    if (specificLabels.containsKey(index)) {
      labelText = specificLabels[index];
      labelColor = specificLabelColors[index];
    } else {
      labelText = labelTexts[packageName];
      labelColor = labelColors[packageName];
    }

    if (labelText != null && labelColor != null) {
      return Positioned(
        top: 2,
        left: 2,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: labelColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            labelText,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildFeatureItem(String feature) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
          Expanded(
            child: Text(
              feature,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                wordSpacing: 0.2, // Experiment with this
              ),
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade500,
      appBar: AppBar(
        title: const Text('Plans', style: TextStyle(color: Colors.white)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.purple],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : packages.isEmpty
            ? const Center(child: Text("No packages available"))
            : ListView.builder(
          itemCount: packages.length,
          itemBuilder: (context, index) {
            final package = packages[index];
            final packageName = package['name'] as String? ?? '';

            return Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Stack(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: _getCardGradient(index),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              packageName,
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: Text(
                              'Price: ₹${package['price']}',
                              style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 10),
                          if (package['features'].isNotEmpty)
                            const Padding(
                              padding: EdgeInsets.only(bottom: 4.0), // Add some spacing before features
                              child: Text(
                                'Features:',
                                style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                            ),
                          if (package['features'].isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: package['features'].map<Widget>(_buildFeatureItem).toList(),
                            ),
                          const SizedBox(height: 10),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PaymentScreen(packageDetails: package),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF0A1172),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text('Buy Package', style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _buildLabel(packageName, index),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}