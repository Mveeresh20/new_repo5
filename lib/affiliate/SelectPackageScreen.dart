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
