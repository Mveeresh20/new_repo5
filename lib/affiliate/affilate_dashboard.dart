/*import 'package:flutter/material.dart';
import 'package:tngtong/config.dart';
import 'nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tngtong/api_service.dart';
class CelebrityDashboardScreen extends StatefulWidget {
  const CelebrityDashboardScreen({Key? key}) : super(key: key);

  @override
  State<CelebrityDashboardScreen> createState() =>
      _CelebrityDashboardScreenState();
}

class _CelebrityDashboardScreenState extends State<CelebrityDashboardScreen> {
  bool _isNavBarOpen = false; // To track NavBar state
  SharedPreferences? prefs; // SharedPreferences instance
  String? loginEmail; // To store the retrieved email
  String? userId;

  @override
  void initState() {
    super.initState();
    _initializePreferences();
    //fetchUserId();
  }

  Future<void> _initializePreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      loginEmail = prefs?.getString('loginEmail');
    });
    print('Login Email: $loginEmail');
    fetchUserId();
  }

  Future<void> fetchUserId() async {
    String? id = await ApiService.getUserId(loginEmail);
    setState(() {
      userId = id;
    });
  }



  // Function to show the exit confirmation dialog
  Future<bool> _onWillPop() async {
    // Show a confirmation dialog
    return (await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Exit'),
        content: const Text('Do you really want to exit the app?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // Stay on the current page
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // Exit the app
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    )) ??
        false; // If null, return false (stay on the current page)
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop, // Assign the back press handler
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              // Main Content Area
              Column(
                children: [
                  // App Bar Section
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        // Menu Button
                        IconButton(
                          icon: const Icon(Icons.menu),
                          onPressed: () {
                            setState(() {
                              _isNavBarOpen = true;
                            });
                          },
                        ),
                        const SizedBox(width: 10), // App Name
                        const Text(
                          Config.appname,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),

                        // Notifications Icon
                        IconButton(
                          icon: const Icon(Icons.notifications),
                          onPressed: () {
                            // Handle notification click
                          },
                        ),
                      ],
                    ),
                  ),

                  // Search Bar Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16), // Spacing below the search bar

                  // Section: Dashboard Cards
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Wallet Balance Card
                        _buildDashboardCard(
                          Icons.account_balance_wallet,
                          'Wallet Balance',
                          '₹5000',
                          Colors.green,
                        ),
                        // New Orders Card
                        _buildDashboardCard(
                          Icons.shopping_cart,
                          'New Orders',
                          '15',
                          Colors.blue,
                        ),
                        // Total Orders Card
                        _buildDashboardCard(
                          Icons.history,
                          'Total Orders',
                          '120',
                          Colors.orange,
                        ),
                      ],
                    ),
                  ),

                  // Section: Trending
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Trending',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: 200,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 10, // Number of cards
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    elevation: 3,
                                    child: Container(
                                      width: 150,
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xffB81736),
                                            Color(0xff281537),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Card ${index + 1}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
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
                  ),
                ],
              ),

              // Tap Outside to Close
              if (_isNavBarOpen)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isNavBarOpen = false;
                    });
                  },
                  child: Container(
                    color: Colors.black.withOpacity(0.5), // Background overlay
                  ),
                ),

              // Animated NavBar
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                left: _isNavBarOpen ? 0 : -250, // Width of NavBar when closed
                top: 0,
                bottom: 0,
                child: NavBar(
                  onClose: () {
                    setState(() {
                      _isNavBarOpen = false;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for the responsive horizontal dashboard card
  Widget _buildDashboardCard(IconData icon, String title, String value, Color color) {
    return Expanded(
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: color,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
/*import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:tngtong/config.dart';
import 'package:tngtong/affiliate/nav_bar.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tngtong/api_service.dart';
//import 'project_details_screen.dart';

class AffilateDashboardScreen extends StatefulWidget {
  const AffilateDashboardScreen({Key? key}) : super(key: key);

  @override
  State<AffilateDashboardScreen> createState() =>
      _AffilateDashboardScreenState();
}

class _AffilateDashboardScreenState extends State<AffilateDashboardScreen> {
  bool _isNavBarOpen = false;
  SharedPreferences? prefs;
  String? loginEmail;
  String? userId;
  List<dynamic> projectRequests = [];

  @override
  void initState() {
    super.initState();
    _initializePreferences();
    _loadProjectRequests();
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
  }

  /*Future<void> _loadProjectRequests() async {
    String jsonString = await rootBundle.loadString('assets/project_requests.json');
    setState(() {
      projectRequests = json.decode(jsonString);
    });
  }*/
  Future<void> _loadProjectRequests() async {
    // Dummy JSON data
    String jsonString = '''
  [
    {
      "id": 1,
      "title": "Website Development",
      "request_date": "2024-02-11",
      "description": "Need a responsive website for a startup."
    },
    {
      "id": 2,
      "title": "Mobile App UI Design",
      "request_date": "2024-02-10",
      "description": "Design a modern UI for a healthcare app."
    },
    {
      "id": 3,
      "title": "Social Media Marketing",
      "request_date": "2024-02-09",
      "description": "Manage and optimize Facebook & Instagram ads."
    }
  ]
  ''';

    setState(() {
      projectRequests = json.decode(jsonString);
    });
  }


  Future<bool> _onWillPop() async {
    return (await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Exit'),
        content: const Text('Do you really want to exit the app?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  // App Bar Section
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        // Menu Button
                        IconButton(
                          icon: const Icon(Icons.menu),
                          onPressed: () {
                            setState(() {
                              _isNavBarOpen = true;
                            });
                          },
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          Config.appname,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.notifications),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),

                  // Card Row for Wallet Balance, New Projects, Completed Projects
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildCard("Wallet Balance", "₹10,000", Icons.account_balance_wallet),
                        _buildCard("New Projects", "5", Icons.work),
                        _buildCard("Completed Projects", "3", Icons.check_circle),
                      ],
                    ),
                  ),

                  // Project Requests List
                  Expanded(
                    child: projectRequests.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                      itemCount: projectRequests.length,
                      itemBuilder: (context, index) {
                        var project = projectRequests[index];
                        return Card(
                          margin: const EdgeInsets.all(16.0),
                          child: ListTile(
                            title: Text(project['title'] ?? 'Project Request'),
                            subtitle: Text('Request Date: ${project['request_date'] ?? 'N/A'}'),
                            /* trailing: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProjectDetailsScreen(
                                      projectDetails: project, // Pass the project details here
                                    ),
                                  ),
                                );
                              },
                              child: const Text('View Details'),
                            ),*/
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              // Backdrop Gesture
              if (_isNavBarOpen)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isNavBarOpen = false;
                    });
                  },
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              // Animated NavBar
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                left: _isNavBarOpen ? 0 : -250,
                top: 0,
                bottom: 0,
                child: NavBar(
                  onClose: () {
                    setState(() {
                      _isNavBarOpen = false;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Card Widget for Wallet Balance, New Projects, Completed Projects
  Widget _buildCard(String title, String value, IconData icon) {
    return Expanded(
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: Colors.blue),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              Text(
                value,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }

}*/
/*
import 'package:flutter/material.dart';
import 'package:tngtong/config.dart';
import 'package:tngtong/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'nav_bar.dart';

class AffiliateDashboardScreen extends StatefulWidget {
  const AffiliateDashboardScreen({Key? key}) : super(key: key);

  @override
  State<AffiliateDashboardScreen> createState() => _AffiliateDashboardScreenState();
}

class _AffiliateDashboardScreenState extends State<AffiliateDashboardScreen> {
  bool _isNavBarOpen = false;
  SharedPreferences? prefs;
  String? loginEmail;
  String? userId;
  Map<String, dynamic> dashboardData = {};

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
    fetchDashboardData();
  }

  Future<void> fetchUserId() async {
    String? id = await ApiService.getUserId(loginEmail);
    setState(() {
      userId = id;
    });
  }

  Future<void> fetchDashboardData() async {
    String dummyJson = '{"walletBalance": 5000, "referralIncome": 2500, "totalReferrals": 30, "lastReferrals": [;;
    {"type": "Brand", "commission": 50},
    {"type": "Influencer", "commission": 100},
    {"type": "Brand", "commission": 50},
    {"type": "Influencer", "commission": 100},
    {"type": "Brand", "commission": 50},
    {"type": "Influencer", "commission": 100},
    {"type": "Brand", "commission": 50},
    {"type": "Influencer", "commission": 100},
    {"type": "Brand", "commission": 50},
    {"type": "Influencer", "commission": 100}
    ]}';
  setState(() {
  dashboardData = json.decode(dummyJson);
  });
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: SafeArea(
      child: Stack(
        children: [
          Column(
            children: [
              _buildAppBar(),
              _buildDashboardCards(),
              _buildReferralList(),
            ],
          ),
          if (_isNavBarOpen)
            GestureDetector(
              onTap: () => setState(() => _isNavBarOpen = false),
              child: Container(color: Colors.black.withOpacity(0.5)),
            ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            left: _isNavBarOpen ? 0 : -250,
            top: 0,
            bottom: 0,
            child: NavBar(onClose: () => setState(() => _isNavBarOpen = false)),
          ),
        ],
      ),
    ),
  );
}

Widget _buildAppBar() {
  return AppBar(
    title: const Text('Affiliate Dashboard'),
    actions: [
      IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
    ],
  );
}

Widget _buildDashboardCards() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      children: [
        _buildDashboardCard(Icons.account_balance_wallet, 'Wallet Balance', '₹${dashboardData["walletBalance"] ?? 0}', Colors.green),
        _buildDashboardCard(Icons.monetization_on, 'Referral Income', '₹${dashboardData["referralIncome"] ?? 0}', Colors.blue),
        _buildDashboardCard(Icons.people, 'Total Referrals', '${dashboardData["totalReferrals"] ?? 0}', Colors.orange),
      ],
    ),
  );
}

Widget _buildReferralList() {
  return Expanded(
    child: Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Last 10 Referrals',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: dashboardData["lastReferrals"]?.length ?? 0,
            itemBuilder: (context, index) {
              var referral = dashboardData["lastReferrals"][index];
              return ListTile(
                leading: Icon(referral["type"] == "Brand" ? Icons.store : Icons.person),
                title: Text('${referral["type"]} Referral'),
                subtitle: Text('Commission: ₹${referral["commission"]}'),
                trailing: TextButton(
                  onPressed: () => _navigateToReferralDetails(context, referral),
                  child: const Text('View More'),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}

void _navigateToReferralDetails(BuildContext context, Map<String, dynamic> referral) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ReferralDetailsScreen(referral: referral)),
  );
}
}

class ReferralDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> referral;
  const ReferralDetailsScreen({Key? key, required this.referral}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Referral Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Referral Type: ${referral["type"]}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Commission Earned: ₹${referral["commission"]}', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
*//*
import 'package:flutter/material.dart';
import 'package:tngtong/config.dart';
import 'package:tngtong/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'nav_bar.dart';

class AffiliateDashboardScreen extends StatefulWidget {
  const AffiliateDashboardScreen({Key? key}) : super(key: key);

  @override
  State<AffiliateDashboardScreen> createState() => _AffiliateDashboardScreenState();
}

class _AffiliateDashboardScreenState extends State<AffiliateDashboardScreen> {
  bool _isNavBarOpen = false;
  SharedPreferences? prefs;
  String? loginEmail;
  String? userId;
  Map<String, dynamic> dashboardData = {};

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
    await fetchUserId();
    await fetchDashboardData();
  }

  Future<void> fetchUserId() async {
    String? id = await ApiService.getUserId(loginEmail);
    setState(() {
      userId = id;
    });
  }

  Future<void> fetchDashboardData() async {
    String dummyJson = '''
  {
    "walletBalance": 5000,
    "referralIncome": 2500,
    "totalReferrals": 30,
    "lastReferrals": [
      {"type": "Brand", "commission": 50},
      {"type": "Influencer", "commission": 100},
      {"type": "Brand", "commission": 50},
      {"type": "Influencer", "commission": 100},
      {"type": "Brand", "commission": 50},
      {"type": "Influencer", "commission": 100},
      {"type": "Brand", "commission": 50},
      {"type": "Influencer", "commission": 100},
      {"type": "Brand", "commission": 50},
      {"type": "Influencer", "commission": 100}
    ]
  }
  ''';

    setState(() {
      dashboardData = json.decode(dummyJson);
    });
  }


  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: _buildAppBar(),
    body: SafeArea(
      child: Stack(
        children: [
          Column(
            children: [
              _buildDashboardCards(),
              Expanded(child: _buildReferralList()),
            ],
          ),
          if (_isNavBarOpen)
            GestureDetector(
              onTap: () => setState(() => _isNavBarOpen = false),
              child: Container(color: Colors.black.withOpacity(0.5)),
            ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            left: _isNavBarOpen ? 0 : -250,
            top: 0,
            bottom: 0,
            child: NavBar(onClose: () => setState(() => _isNavBarOpen = false)),
          ),
        ],
      ),
    ),
  );
}

AppBar _buildAppBar() {
  return AppBar(
    title: const Text('Affiliate Dashboard'),
    actions: [
      IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
    ],
  );
}

Widget _buildDashboardCards() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      children: [
        _buildDashboardCard(Icons.account_balance_wallet, 'Wallet Balance', '₹${dashboardData["walletBalance"] ?? 0}', Colors.green),
        _buildDashboardCard(Icons.monetization_on, 'Referral Income', '₹${dashboardData["referralIncome"] ?? 0}', Colors.blue),
        _buildDashboardCard(Icons.people, 'Total Referrals', '${dashboardData["totalReferrals"] ?? 0}', Colors.orange),
      ],
    ),
  );
}

Widget _buildDashboardCard(IconData icon, String title, String value, Color color) {
  return Card(
    elevation: 4,
    margin: const EdgeInsets.symmetric(vertical: 8),
    child: ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      trailing: Text(value, style: TextStyle(fontSize: 16, color: color)),
    ),
  );
}

Widget _buildReferralList() {
  return Column(
    children: [
      const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Last 10 Referrals',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      Expanded(
        child: ListView.builder(
          itemCount: dashboardData["lastReferrals"]?.length ?? 0,
          itemBuilder: (context, index) {
            var referral = dashboardData["lastReferrals"][index];
            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                leading: Icon(referral["type"] == "Brand" ? Icons.store : Icons.person, color: Colors.purple),
                title: Text('${referral["type"]} Referral', style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Commission: ₹${referral["commission"]}'),
                trailing: ElevatedButton(
                  onPressed: () => _navigateToReferralDetails(context, referral),
                  child: const Text('View More'),
                ),
              ),
            );
          },
        ),
      ),
    ],
  );
}

void _navigateToReferralDetails(BuildContext context, Map<String, dynamic> referral) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ReferralDetailsScreen(referral: referral)),
  );
}
}

class ReferralDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> referral;
  const ReferralDetailsScreen({Key? key, required this.referral}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Referral Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Referral Type: ${referral["type"]}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text('Commission Earned: ₹${referral["commission"]}', style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}*//*
import 'package:flutter/material.dart';
import 'package:tngtong/config.dart';
import 'package:tngtong/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'nav_bar.dart';

class AffiliateDashboardScreen extends StatefulWidget {
  const AffiliateDashboardScreen({Key? key}) : super(key: key);

  @override
  State<AffiliateDashboardScreen> createState() => _AffiliateDashboardScreenState();
}

class _AffiliateDashboardScreenState extends State<AffiliateDashboardScreen> {
  bool _isNavBarOpen = false;
  SharedPreferences? prefs;
  String? loginEmail;
  String? userId;
  Map<String, dynamic> dashboardData = {};
  String searchQuery = "";

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
    await fetchUserId();
    await fetchDashboardData();
  }

  Future<void> fetchUserId() async {
    String? id = await ApiService.getUserId(loginEmail);
    setState(() {
      userId = id;
    });
  }

  Future<void> fetchDashboardData() async {
    String dummyJson = '''{"username": "John Doe", "registrationDate": "2024-01-01", "kycStatus": "Completed", "walletBalance": 5000, "referralIncome": 2500, "totalReferrals": 30, "lastReferrals": [''
    {"name": "Alice", "type": "Brand", "commission": 50, "kycStatus": "Pending"},
    {"name": "Bob", "type": "Influencer", "commission": 100, "kycStatus": "Completed"},
    {"name": "Charlie", "type": "Brand", "commission": 50, "kycStatus": "Pending"},
    {"name": "David", "type": "Influencer", "commission": 100, "kycStatus": "Completed"},
    {"name": "Eve", "type": "Brand", "commission": 50, "kycStatus": "Pending"},
    {"name": "Frank", "type": "Influencer", "commission": 100, "kycStatus": "Completed"},
    {"name": "Grace", "type": "Brand", "commission": 50, "kycStatus": "Pending"},
    {"name": "Hank", "type": "Influencer", "commission": 100, "kycStatus": "Completed"},
    {"name": "Ivy", "type": "Brand", "commission": 50, "kycStatus": "Pending"},
    {"name": "Jack", "type": "Influencer", "commission": 100, "kycStatus": "Completed"}
    ]}''';
    setState(() {
      dashboardData = json.decode(dummyJson);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                _buildDashboardCards(),
                _buildButtons(),
                _buildSearchBar(),
                Expanded(child: _buildReferralList()),
              ],
            ),
            if (_isNavBarOpen)
              GestureDetector(
                onTap: () => setState(() => _isNavBarOpen = false),
                child: Container(color: Colors.black.withOpacity(0.5)),
              ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              left: _isNavBarOpen ? 0 : -250,
              top: 0,
              bottom: 0,
              child: NavBar(onClose: () => setState(() => _isNavBarOpen = false)),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Affiliate Dashboard'),
      actions: [
        IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
      ],
    );
  }

  Widget _buildDashboardCards() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildDashboardCard(Icons.account_balance_wallet, 'Wallet Balance', '₹${dashboardData["walletBalance"] ?? 0}', Colors.green),
          _buildDashboardCard(Icons.monetization_on, 'Referral Income', '₹${dashboardData["referralIncome"] ?? 0}', Colors.blue),
          _buildDashboardCard(Icons.people, 'Total Referrals', '${dashboardData["totalReferrals"] ?? 0}', Colors.orange),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: const InputDecoration(
          labelText: 'Search Referrals',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          setState(() {
            searchQuery = value.toLowerCase();
          });
        },
      ),
    );
  }

  Widget _buildReferralList() {
    List filteredReferrals = dashboardData["lastReferrals"]?.where((referral) {
      return referral["name"].toLowerCase().contains(searchQuery);
    }).toList() ?? [];

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Last 10 Referrals',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredReferrals.length,
            itemBuilder: (context, index) {
              var referral = filteredReferrals[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: Icon(referral["type"] == "Brand" ? Icons.store : Icons.person, color: Colors.purple),
                  title: Text('${referral["name"]} - ${referral["type"]} Referral', style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Commission: ₹${referral["commission"]} | KYC: ${referral["kycStatus"]}'),
                  trailing: ElevatedButton(
                    onPressed: () {},
                    child: const Text('View More'),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: _buildAppBar(),
    body: SafeArea(
      child: Stack(
        children: [
          Column(
            children: [
              _buildDashboardCards(),
              _buildButtons(),
              Expanded(child: _buildReferralList()),
            ],
          ),
          if (_isNavBarOpen)
            GestureDetector(
              onTap: () => setState(() => _isNavBarOpen = false),
              child: Container(color: Colors.black.withOpacity(0.5)),
            ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            left: _isNavBarOpen ? 0 : -250,
            top: 0,
            bottom: 0,
            child: NavBar(onClose: () => setState(() => _isNavBarOpen = false)),
          ),
        ],
      ),
    ),
  );
}

AppBar _buildAppBar() {
  return AppBar(
    title: const Text('Affiliate Dashboard'),
    actions: [
      IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
    ],
  );
}

Widget _buildDashboardCards() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildDashboardCard(Icons.account_balance_wallet, 'Wallet Balance', '₹${dashboardData["walletBalance"] ?? 0}', Colors.green),
        _buildDashboardCard(Icons.monetization_on, 'Referral Income', '₹${dashboardData["referralIncome"] ?? 0}', Colors.blue),
        _buildDashboardCard(Icons.people, 'Total Referrals', '${dashboardData["totalReferrals"] ?? 0}', Colors.orange),
      ],
    ),
  );
}

Widget _buildButtons() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(onPressed: () {}, child: const Text('View Brand Users')),
        ElevatedButton(onPressed: () {}, child: const Text('View Influencers')),
        ElevatedButton(onPressed: () {}, child: const Text('Show All Referrals')),
      ],
    ),
  );
}

Widget _buildReferralList() {
  return Column(
    children: [
      const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Last 10 Referrals',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      Expanded(
        child: ListView.builder(
          itemCount: dashboardData["lastReferrals"]?.length ?? 0,
          itemBuilder: (context, index) {
            var referral = dashboardData["lastReferrals"][index];
            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                leading: Icon(referral["type"] == "Brand" ? Icons.store : Icons.person, color: Colors.purple),
                title: Text('${referral["name"]} - ${referral["type"]} Referral', style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Commission: ₹${referral["commission"]}'),
                trailing: ElevatedButton(
                  onPressed: () {},
                  child: const Text('View More'),
                ),
              ),
            );
          },
        ),
      ),
    ],
  );
  Widget _buildDashboardCard(IconData icon, String title, String value, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(value, style: TextStyle(fontSize: 18, color: color, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

}*/
import 'package:flutter/material.dart';
import 'package:tngtong/config.dart';
import 'package:tngtong/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'nav_bar.dart';

class AffiliateDashboardScreen extends StatefulWidget {
  const AffiliateDashboardScreen({Key? key}) : super(key: key);

  @override
  State<AffiliateDashboardScreen> createState() => _AffiliateDashboardScreenState();
}

class _AffiliateDashboardScreenState extends State<AffiliateDashboardScreen> {
  bool _isNavBarOpen = false;
  SharedPreferences? prefs;
  String? loginEmail;
  String? userId;
  Map<String, dynamic> dashboardData = {};
  String searchQuery = "";

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
    await fetchUserId();
    await fetchDashboardData();
  }

  Future<void> fetchUserId() async {
    String? id = await ApiService.getAffilaterId(loginEmail);
    setState(() {
      userId = id;
    });
  }

  Future<void> fetchDashboardData() async {
    String dummyJson = '''{"username": "John Doe", "registrationDate": "2024-01-01", "kycStatus": "Completed", "walletBalance": 5000, "referralIncome": 2500, "totalReferrals": 30, "lastReferrals": [
    {"name": "Alice", "type": "Brand", "commission": 50, "kycStatus": "Pending"},
    {"name": "Bob", "type": "Influencer", "commission": 100, "kycStatus": "Completed"}
    ]}''';
  setState(() {
  dashboardData = json.decode(dummyJson);
  });
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: _buildAppBar(),
    body: SafeArea(
      child: Stack(
        children: [
          Column(
            children: [
              _buildDashboardCards(),
              _buildButtons(),
              _buildSearchBar(),
              Expanded(child: _buildReferralList()),
            ],
          ),
          if (_isNavBarOpen)
            GestureDetector(
              onTap: () => setState(() => _isNavBarOpen = false),
              child: Container(color: Colors.black.withOpacity(0.5)),
            ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            left: _isNavBarOpen ? 0 : -250,
            top: 0,
            bottom: 0,
            child: NavBar(onClose: () => setState(() => _isNavBarOpen = false)),
          ),
        ],
      ),
    ),
  );
}

AppBar _buildAppBar() {
  return AppBar(
    title: const Text('Welcome Back!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    leading: IconButton(
      icon: Icon(Icons.menu),
      onPressed: () => setState(() => _isNavBarOpen = !_isNavBarOpen),
    ),
    actions: [
      IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
    ],
  );
}

Widget _buildDashboardCards() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildDashboardCard(Icons.account_balance_wallet, 'Wallet', '₹${dashboardData["walletBalance"] ?? 0}', Colors.green),
        _buildDashboardCard(Icons.monetization_on, 'Income', '₹${dashboardData["referralIncome"] ?? 0}', Colors.blue),
        _buildDashboardCard(Icons.people, 'Referrals', '${dashboardData["totalReferrals"] ?? 0}', Colors.orange),
      ],
    ),
  );
}

Widget _buildDashboardCard(IconData icon, String title, String value, Color color) {
  return Expanded(
    child: Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28, color: color),
            SizedBox(height: 6),
            Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    ),
  );
}

Widget _buildButtons() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(onPressed: () {}, child: Text('Withdraw')),
        ElevatedButton(onPressed: () {}, child: Text('Refer')),
      ],
    ),
  );
}

Widget _buildSearchBar() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextField(
      decoration: InputDecoration(
        hintText: 'Search referrals...',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        prefixIcon: Icon(Icons.search),
      ),
    ),
  );
}

Widget _buildReferralList() {
  return ListView.builder(
    itemCount: dashboardData["lastReferrals"]?.length ?? 0,
    itemBuilder: (context, index) {
      var referral = dashboardData["lastReferrals"][index];
      return Card(
        child: ListTile(
          title: Text(referral["name"] ?? ""),
          subtitle: Text('Type: ${referral["type"]} - KYC: ${referral["kycStatus"]}'),
          trailing: Text('₹${referral["commission"]}'),
        ),
      );
    },
  );
}
}
