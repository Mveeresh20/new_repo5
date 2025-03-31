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



/*
import 'package:flutter/material.dart';
import 'package:tngtong/config.dart';
import 'package:tngtong/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'nav_bar.dart';
import 'package:share_plus/share_plus.dart';

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
  double? walletBalance;
double? EarningsBal;
  String? userType="affiliater";
  String? ReferralCode;
  late List<Map<String, dynamic>> referrals;
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
    _getMyRefCode();
    List<Map<String, dynamic>>  referrals1 = await ApiService.getReferralDetails(userId!, "affiliater");
    setState(() {
      referrals = referrals1;
    });
    getWallteBalance();
    getEarningsBal();
  }
  Future<void> _getMyRefCode() async {
    String? ReferralId = await ApiService.getMyReferralCode(userId,userType);
    setState(() {
      ReferralCode = ReferralId;
    });

  }
  Future<void> getWallteBalance() async {
    double? balance = await ApiService.getAffilaterWalletBalance(userId);
    setState(() {
      walletBalance = balance!;
    });
  }

  Future<void> getEarningsBal() async {
    double? balance = await ApiService.getEarningsBal(userId,"affiliater");
    setState(() {
      EarningsBal = balance ?? 0;

    });

  }
  void _shareReferralCode(String code) {
    Share.share('Join me and start earning! My referral code is: $code');
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
        _buildDashboardCard(Icons.account_balance_wallet, 'Wallet', '₹${walletBalance ?? 0}', Colors.green),
        _buildDashboardCard(Icons.monetization_on, 'Income', '₹${EarningsBal ?? 0}', Colors.blue),
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
        ElevatedButton(onPressed: () {_shareReferralCode(ReferralCode!);}, child: Text('Refer')),
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
*/


/*
import 'package:flutter/material.dart';
import 'package:tngtong/config.dart';
import 'package:tngtong/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'nav_bar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart'; // For Clipboard
import 'package:tngtong/affiliate/ReferralProgramScreen.dart';
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
  double? walletBalance;
  double? EarningsBal;
  String? userType = "affiliater";
  String? ReferralCode;
  late List<Map<String, dynamic>> referrals = [];
  List<Map<String, dynamic>> filteredReferrals = [];

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
    _getMyRefCode();
    List<Map<String, dynamic>> referrals1 = await ApiService.getReferralDetails(userId!, "affiliater");
    setState(() {
      referrals = referrals1;
      filteredReferrals = referrals1; // Initialize filtered list
    });
    getWallteBalance();
    getEarningsBal();
  }

  Future<void> _getMyRefCode() async {
    String? ReferralId = await ApiService.getMyReferralCode(userId, userType);
    setState(() {
      ReferralCode = ReferralId;
    });
  }

  Future<void> getWallteBalance() async {
    double? balance = await ApiService.getAffilaterWalletBalance(userId);
    setState(() {
      walletBalance = balance!;
    });
  }

  Future<void> getEarningsBal() async {
    double? balance = await ApiService.getEarningsBal(userId, "affiliater");
    setState(() {
      EarningsBal = balance ?? 0;
    });
  }

  void _shareReferralCode(String code) {
    Share.share('Join me and start earning! My referral code is: $code');
  }

  void _copyReferralCode(String code) {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Referral code copied to clipboard')),
    );
  }

  Future<void> fetchDashboardData() async {
    // Fetch data from API or use dummy data
    String dummyJson = '''{"username": "John Doe", "registrationDate": "2024-01-01", "kycStatus": "Completed", "walletBalance": 5000, "referralIncome": 2500, "totalReferrals": 30, "lastReferrals": [
    {"name": "Alice", "type": "Brand", "commission": 50, "kycStatus": "Pending", "referralDate": "2024-01-01", "userType": "Brand", "status": "Pending"},
    {"name": "Bob", "type": "Influencer", "commission": 100, "kycStatus": "Completed", "referralDate": "2024-01-02", "userType": "Influencer", "status": "Completed"}
    ]}''';
    setState(() {
      dashboardData = json.decode(dummyJson);
    });
  }

  void _filterReferrals(String query) {
    setState(() {
      filteredReferrals = referrals
          .where((referral) =>
          referral['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
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
          _buildDashboardCard(Icons.account_balance_wallet, 'Wallet', '₹${walletBalance ?? 0}', Colors.green),
          _buildDashboardCard(Icons.monetization_on, 'Income', '₹${EarningsBal ?? 0}', Colors.blue),
          _buildDashboardCard(Icons.people, 'Referrals', '${referrals.length}', Colors.orange),
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
          ElevatedButton(
            onPressed: () => _copyReferralCode(ReferralCode!),
            child: Text('Copy Referral Code'),
          ),
          ElevatedButton(
            onPressed: () => _shareReferralCode(ReferralCode!),
            child: Text('Refer'),
          ),
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
        onChanged: (value) {
          setState(() {
            searchQuery = value;
            _filterReferrals(value);
          });
        },
      ),
    );
  }

  Widget _buildReferralList() {
    return ListView.builder(
      itemCount: filteredReferrals.length,
      itemBuilder: (context, index) {
        var referral = filteredReferrals[index];
        return Card(
          child: ListTile(
            title: Text(referral['name'] ?? ""),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Referral Date: ${referral['referralDate']}'),
                Text('User Type: ${referral['userType']}'),
                Text('Status: ${referral['status']}'),
              ],
            ),
           // trailing: Text('₹${referral['commission']}'),
            onTap: () {
              // Navigate to referral program screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReferralProgramScreen(),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

// Placeholder for ReferralProgramScreen
/*class ReferralProgramScreen extends StatelessWidget {
  final Map<String, dynamic> referral;

  const ReferralProgramScreen({Key? key, required this.referral}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Referral Program'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${referral['name']}'),
            Text('Referral Date: ${referral['referralDate']}'),
            Text('User Type: ${referral['userType']}'),
            Text('Status: ${referral['status']}'),
            Text('Commission: ₹${referral['commission']}'),
          ],
        ),
      ),
    );
  }
}*/

*/

/*  before veeresh code or IS LOGO
import 'package:flutter/material.dart';
import 'package:tngtong/config.dart';
import 'package:tngtong/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'nav_bar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart'; // For Clipboard
import 'package:tngtong/affiliate/ReferralProgramScreen.dart';
import 'package:tngtong/affiliate/ProfileScreen.dart';
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
  double? walletBalance;
  double? EarningsBal;
  String? userType = "affiliater";
  String? ReferralCode;
  String? kycStatus;

  late List<Map<String, dynamic>> referrals = [];
  List<Map<String, dynamic>> filteredReferrals = [];

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
    }

    );
    _getMyRefCode();
    List<Map<String, dynamic>> referrals1 = await ApiService.getReferralDetails(userId!, "affiliater");
    setState(() {
      referrals = referrals1;
      filteredReferrals = referrals1; // Initialize filtered list
    });
    getWallteBalance();
    getEarningsBal();
    checkKycStatus(); // Check KYC status on initialization

  }
  Future<void> checkKycStatus() async {
    try {
      String? status = await ApiService.getKycStatus(userId,"affiliater");
      setState(() {
        kycStatus = status;
      });

      if (status != "verified" && status != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showKycPopup(context, status);
        });
      }
    } catch (e) {
      print("Error checking KYC status: $e");
    }
  }

  void _showKycPopup(BuildContext context, String status) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(status == "Pending" ? "KYC Approval Pending" : "KYC Not Completed"),
          content: Text(status == "Pending" ? "Your KYC approval is pending." : "Your KYC is not yet completed. Please complete your KYC."),
          actions: <Widget>[
            TextButton(
              child: Text("Complete KYC"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileUpdateScreen()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _getMyRefCode() async {
    String? ReferralId = await ApiService.getMyReferralCode(userId, userType);
    setState(() {
      ReferralCode = ReferralId;
    });
  }

  Future<void> getWallteBalance() async {
    double? balance = await ApiService.getAffilaterWalletBalance(userId);
    setState(() {
      walletBalance = balance!;
    });
  }

  Future<void> getEarningsBal() async {
    double? balance = await ApiService.getEarningsBal(userId, "affiliater");
    setState(() {
      EarningsBal = balance ?? 0;
    });
  }

  void _shareReferralCode(String code) {
    Share.share('Join me and start earning! My referral code is: $code');
  }

  void _copyReferralCode(String code) {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Referral code copied to clipboard')),
    );
  }

  Future<void> fetchDashboardData() async {
    // Fetch data from API or use dummy data
    String dummyJson = '''{"username": "John Doe", "registrationDate": "2024-01-01", "kycStatus": "Completed", "walletBalance": 5000, "referralIncome": 2500, "totalReferrals": 30, "lastReferrals": [
    {"name": "Alice", "type": "Brand", "commission": 50, "kycStatus": "Pending", "referralDate": "2024-01-01", "userType": "Brand", "status": "Pending"},
    {"name": "Bob", "type": "Influencer", "commission": 100, "kycStatus": "Completed", "referralDate": "2024-01-02", "userType": "Influencer", "status": "Completed"}
    ]}''';
    setState(() {
      dashboardData = json.decode(dummyJson);
    });
  }

  void _filterReferrals(String query) {
    setState(() {
      filteredReferrals = referrals
          .where((referral) =>
          referral['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
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
          _buildDashboardCard(Icons.account_balance_wallet, 'Wallet', '₹${walletBalance ?? 0}', Colors.green),
          _buildDashboardCard(Icons.monetization_on, 'Income', '₹${EarningsBal ?? 0}', Colors.blue),
          _buildDashboardCard(Icons.people, 'Referrals', '${referrals.length}', Colors.orange),
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
          ElevatedButton(
            onPressed: () => _copyReferralCode(ReferralCode!),
            child: Text('Copy Referral Code'),
          ),
          ElevatedButton(
            onPressed: () => _shareReferralCode(ReferralCode!),
            child: Text('Refer'),
          ),
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
        onChanged: (value) {
          setState(() {
            searchQuery = value;
            _filterReferrals(value);
          });
        },
      ),
    );
  }

  Widget _buildReferralList() {
    return ListView.builder(
      itemCount: filteredReferrals.length,
      itemBuilder: (context, index) {
        var referral = filteredReferrals[index];
        return Card(
          child: ListTile(
            title: Text(referral['name'] ?? ""),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Referral Date: ${referral['referralDate']}'),
                Text('User Type: ${referral['userType']}'),
                Text('Status: ${referral['status']}'),
              ],
            ),
            // trailing: Text('₹${referral['commission']}'),
            onTap: () {
              // Navigate to referral program screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReferralProgramScreen(),
                ),
              );
            },
          ),
        );
      },
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
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';
import 'package:tngtong/affiliate/ProfileScreen.dart';

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
  double? walletBalance;
  double? EarningsBal;
  String? userType = "affiliater";
  String? ReferralCode;
  String? kycStatus;
  String selectedFilter = 'all';
  final ScrollController _scrollController = ScrollController();
  bool _showBanner = true;

  late List<Map<String, dynamic>> referrals = [];

  @override
  void initState() {
    super.initState();
    _initializePreferences();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    if (_scrollController.offset > 100 && _showBanner) {
      setState(() => _showBanner = false);
    } else if (_scrollController.offset <= 100 && !_showBanner) {
      setState(() => _showBanner = true);
    }
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
    _getMyRefCode();
    List<Map<String, dynamic>> referrals1 = await ApiService.getReferralDetails(userId!, "affiliater");
    setState(() {
      referrals = referrals1;
    });
    getWallteBalance();
    getEarningsBal();
    checkKycStatus();
  }

  Future<void> checkKycStatus() async {
    try {
      String? status = await ApiService.getKycStatus(userId, "affiliater");
      setState(() {
        kycStatus = status;
      });

      if (status != "verified" && status != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showKycPopup(context, status);
        });
      }
    } catch (e) {
      print("Error checking KYC status: $e");
    }
  }

  void _showKycPopup(BuildContext context, String status) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(status == "Pending" ? "KYC Approval Pending" : "KYC Not Completed"),
          content: Text(status == "Pending" ? "Your KYC approval is pending." : "Your KYC is not yet completed. Please complete your KYC."),
          actions: <Widget>[
            TextButton(
              child: Text("Complete KYC"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileUpdateScreen()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _getMyRefCode() async {
    String? ReferralId = await ApiService.getMyReferralCode(userId, userType);
    setState(() {
      ReferralCode = ReferralId;
    });
  }

  Future<void> getWallteBalance() async {
    double? balance = await ApiService.getAffilaterWalletBalance(userId);
    setState(() {
      walletBalance = balance!;
    });
  }

  Future<void> getEarningsBal() async {
    double? balance = await ApiService.getEarningsBal(userId, "affiliater");
    setState(() {
      EarningsBal = balance ?? 0;
    });
  }

  Future<void> _copyReferralCode(String code) async {
    await Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Referral code copied to clipboard!')),
    );
  }

  void _shareReferralCode(String code) {
    Share.share('Join me and start earning! My referral code is: $code');
  }

  Future<void> fetchDashboardData() async {
    // Fetch data from API or use dummy data
    String dummyJson = '''{"username": "John Doe", "registrationDate": "2024-01-01", "kycStatus": "Completed", "walletBalance": 5000, "referralIncome": 2500, "totalReferrals": 30}''';
    setState(() {
      dashboardData = json.decode(dummyJson);
    });
  }

  Widget _buildFilterButton(String filter, String text, Color activeColor) {
    final bool isActive = selectedFilter == filter;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: ElevatedButton(
          onPressed: () => setState(() => selectedFilter = filter),
          style: ElevatedButton.styleFrom(
            backgroundColor: isActive ? activeColor : Colors.grey[300],
            foregroundColor: isActive ? Colors.white : Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  _buildDashboardCards(),
                  const SizedBox(height: 16),
                  // Banner Image with animated visibility
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: _showBanner ? 180 : 0,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/banner.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (_showBanner) ...[
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Earn Through Referrals:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xffFF04AB), Color(0xffAE26CD)],
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'Your Referral Code:',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      ReferralCode ?? 'Loading...',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    IconButton(
                                      icon: const Icon(Icons.copy),
                                      onPressed: ReferralCode != null
                                          ? () => _copyReferralCode(ReferralCode!)
                                          : null,
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.share),
                                      onPressed: ReferralCode != null
                                          ? () => _shareReferralCode(ReferralCode!)
                                          : null,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'My Referrals:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xffFF04AB), Color(0xffAE26CD)],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            _buildFilterButton('all', 'All', const Color(0xffF4A261)),
                            _buildFilterButton('pending kyc', 'Pending KYC', const Color(0xffE76F51)),
                            _buildFilterButton('verified', 'Verified', const Color(0xff2A9D8F)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: referrals.length,
                    itemBuilder: (context, index) {
                      final referral = referrals[index];
                      if (selectedFilter != 'all' && referral['status'] != selectedFilter) {
                        return const SizedBox.shrink();
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: Card(
                          margin: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: Icon(
                              referral['status'] == 'verified'
                                  ? Icons.check_circle
                                  : Icons.hourglass_empty,
                              color: referral['status'] == 'verified'
                                  ? Colors.green
                                  : Colors.orange,
                            ),
                            title: Text(
                              referral['name'],
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Referral Date: ${referral['referralDate']}'),
                                Text('User Type: ${referral['userType']}'),
                              ],
                            ),
                            trailing: Chip(
                              label: Text(
                                referral['status'],
                                style: const TextStyle(color: Colors.white),
                              ),
                              backgroundColor: referral['status'] == 'verified'
                                  ? Colors.green
                                  : Colors.orange,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
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

 /* Widget _buildDashboardCards() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildDashboardCard(Icons.account_balance_wallet, 'Wallet', '₹${walletBalance ?? 0}', Colors.green),
          _buildDashboardCard(Icons.monetization_on, 'Income', '₹${EarningsBal ?? 0}', Colors.blue),
          _buildDashboardCard(Icons.people, 'Referrals', '${referrals.length}', Colors.orange),
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
  }*/
  Widget _buildDashboardCards() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: _buildDashboardCard(
                Icons.account_balance_wallet,
                'Wallet',
                '₹${walletBalance ?? 0}',
                Colors.purple.shade500),
          ),
          _buildDashboardCard(
              Icons.monetization_on,
              'Income',
              '₹${EarningsBal ?? 0}',
              Colors.purple.shade500),
          _buildDashboardCard(
              Icons.people,
              'Referrals',
              '${referrals.length}',
              Colors.purple.shade500),
        ],
      ),
    );
  }

  Widget _buildDashboardCard(
      IconData icon, String title, String value, Color color) {
    return Expanded(
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: SizedBox(
                height: 20,
                child: Container(
                  width: 2,
                  decoration: BoxDecoration(
                    color: Colors.purple.shade500,
                    borderRadius: const BorderRadius.only(
                      topLeft:
                      Radius.circular(16), // Match card's border radius
                      bottomLeft:
                      Radius.circular(0), // Match card's border radius
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment:
                MainAxisAlignment.center, // Center content vertically
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(icon, size: 24, color: color),
                      const SizedBox(width: 11),
                      Text(
                        value,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
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
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';
import 'package:tngtong/affiliate/ProfileScreen.dart';
import 'package:tngtong/affiliate/walletScreen.dart';
class AffiliateDashboardScreen extends StatefulWidget {
  const AffiliateDashboardScreen({Key? key}) : super(key: key);

  @override
  State<AffiliateDashboardScreen> createState() => _AffiliateDashboardScreenState();
}

class _AffiliateDashboardScreenState extends State<AffiliateDashboardScreen> {
  bool _isNavBarOpen = false;
  bool _isLoading = true; // Added loading state
  SharedPreferences? prefs;
  String? loginEmail;
  String? userId;
  Map<String, dynamic> dashboardData = {};
  double? walletBalance;
  double? EarningsBal;
  String? userType = "affiliater";
  String? ReferralCode;
  String? kycStatus;
  String selectedFilter = 'all';
  final ScrollController _scrollController = ScrollController();
  bool _showBanner = true;

  late List<Map<String, dynamic>> referrals = [];

  @override
  void initState() {
    super.initState();
    _initializeData();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    if (_scrollController.offset > 100 && _showBanner) {
      setState(() => _showBanner = false);
    } else if (_scrollController.offset <= 100 && !_showBanner) {
      setState(() => _showBanner = true);
    }
  }

  Future<void> _initializeData() async {
    try {
      setState(() => _isLoading = true);

      // Initialize preferences and get login email
      prefs = await SharedPreferences.getInstance();
      loginEmail = prefs?.getString('loginEmail');

      // Fetch all required data in parallel where possible
      await Future.wait([
        fetchUserId(),
        fetchDashboardData(),
      ]);

    } catch (e) {
      print("Error initializing data: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> fetchUserId() async {
    String? id = await ApiService.getAffilaterId(loginEmail);
    setState(() => userId = id);

    // Fetch dependent data after getting userId
    await Future.wait([
      _getMyRefCode(),
      _fetchReferrals(),
      getWallteBalance(),
      getEarningsBal(),
      checkKycStatus(),
    ]);
  }

  Future<void> _fetchReferrals() async {
    if (userId == null) return;
    List<Map<String, dynamic>> referrals1 =
    await ApiService.getReferralDetails(userId!, "affiliater");
    setState(() => referrals = referrals1);
  }

  Future<void> _getMyRefCode() async {
    if (userId == null) return;
    String? ReferralId = await ApiService.getMyReferralCode(userId, userType);
    setState(() => ReferralCode = ReferralId);
  }

  Future<void> getWallteBalance() async {
    if (userId == null) return;
    double? balance = await ApiService.getAffilaterWalletBalance(userId);
    setState(() => walletBalance = balance ?? 0);
  }

  Future<void> getEarningsBal() async {
    if (userId == null) return;
    double? balance = await ApiService.getEarningsBal(userId, "affiliater");
    setState(() => EarningsBal = balance ?? 0);
  }

  Future<void> checkKycStatus() async {
    if (userId == null) return;
    try {
      String? status = await ApiService.getKycStatus(userId, "affiliater");
      setState(() => kycStatus = status);

      if (status != "verified" && status != null && mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showKycPopup(context, status);
        });
      }
    } catch (e) {
      print("Error checking KYC status: $e");
    }
  }

  void _showKycPopup(BuildContext context, String status) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(status == "Pending" ? "KYC Approval Pending" : "KYC Not Completed"),
          content: Text(status == "Pending" ? "Your KYC approval is pending." : "Your KYC is not yet completed. Please complete your KYC."),
          actions: <Widget>[
            TextButton(
              child: Text("Complete KYC"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileUpdateScreen()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _shareReferralCode(String code) {
    Share.share('Join me and start earning! My referral code is: $code');
  }

  void _copyReferralCode(String code) {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Referral code copied to clipboard')),
    );
  }

  Future<void> fetchDashboardData() async {
    // Fetch data from API or use dummy data
    String dummyJson = '''{"username": "John Doe", "registrationDate": "2024-01-01", "kycStatus": "Completed", "walletBalance": 5000, "referralIncome": 2500, "totalReferrals": 30}''';
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
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              )
            else
              SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    // Custom App Bar Section
                    Container(
                      width: double.infinity,
                      height: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.purple.shade500,
                            Colors.purple.shade500,
                            Colors.purple.shade500
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/new-logo.png',
                            width: 35,
                            height: 35,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            icon: const Icon(
                              Icons.menu,
                              size: 24,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() => _isNavBarOpen = true);
                            },
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            Config.appname,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          // Wallet Icon with Balance (clickable)
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WalletScreen(),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.purple.shade400,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '₹${walletBalance?.toStringAsFixed(2) ?? '0.00'}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(
                                    Icons.account_balance_wallet,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                         /* IconButton(
                            icon: const Icon(
                              Icons.notifications,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),*/
                        ],
                      ),
                    ),

                    _buildDashboardCards(),
                   const SizedBox(height: 16),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Transform.scale(
                              scale: 1.5, // Adjust this value to zoom in/out (1.0 = original size)
                              child: Container(
                               /* height: 150,
                                width: 140,*/
                                height: 100,
                                width: 90,
                                child: Image.asset(
                                  'assets/images/banner_icon.png',
                                  fit: BoxFit.contain, // Ensures the image fits within the container
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Refer & Earn!",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Refer business owners, influencers, and your loved ones to us—earn up to ₹300 per referral and help businesses and people grow together!",
                                    style: TextStyle(fontSize: 14),
                                    textAlign: TextAlign.start,
                                    softWrap: true,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

               /*     AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: _showBanner ? 180 : 0,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/banner.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
*/
                    if (_showBanner) ...[
                      const SizedBox(height: 20),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Earn Through Referrals:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.purple.shade500,
                                  Colors.purple.shade700,
                                ],
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  'Your Referral Code:',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        ReferralCode ?? '',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      IconButton(
                                        icon: const Icon(Icons.copy),
                                        onPressed: ReferralCode != null
                                            ? () => _copyReferralCode(ReferralCode!)
                                            : null,
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.share),
                                        onPressed: ReferralCode != null
                                            ? () => _shareReferralCode(ReferralCode!)
                                            : null,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'My Referrals:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.purple.shade500,
                                Colors.purple.shade700,
                              ],
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              _buildFilterButton('all', 'All', Colors.purple.shade800),
                              _buildFilterButton('pending kyc', 'Pending KYC', Colors.purple.shade700),
                              _buildFilterButton('verified', 'Verified', Colors.purple.shade600),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: referrals.length,
                      itemBuilder: (context, index) {
                        final referral = referrals[index];
                        if (selectedFilter != 'all' && referral['status'] != selectedFilter) {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          child: Card(
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              leading: Icon(
                                referral['status'] == 'verified'
                                    ? Icons.check_circle
                                    : Icons.hourglass_empty,
                                color: referral['status'] == 'verified'
                                    ? Colors.purple.shade500
                                    : Colors.orange,
                              ),
                              title: Text(
                                referral['name'],
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Referral Date: ${referral['referralDate']}'),
                                  Text('User Type: ${referral['userType']}'),
                                ],
                              ),
                              trailing: Chip(
                                label: Text(
                                  referral['status'],
                                  style: const TextStyle(color: Colors.white),
                                ),
                                backgroundColor: referral['status'] == 'verified'
                                    ? Colors.purple.shade500
                                    : Colors.orange,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
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

  Widget _buildDashboardCards() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildDashboardCard(
            Icons.account_balance_wallet,
            'Wallet',
            '₹${walletBalance?.toStringAsFixed(2) ?? '0.00'}',
            Colors.purple.shade500,
          ),
          _buildDashboardCard(
            Icons.monetization_on,
            'Income',
            '₹${EarningsBal?.toStringAsFixed(2) ?? '0.00'}',
            Colors.purple.shade500,
          ),
          _buildDashboardCard(
            Icons.people,
            'Referrals',
            referrals.length.toString(),
            Colors.purple.shade500,
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardCard(IconData icon, String title, String value, Color color) {
    return Expanded(
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 2,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(icon, size: 24, color: color),
                      const SizedBox(width: 11),
                      Text(
                        value,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(String filter, String text, Color activeColor) {
    final bool isActive = selectedFilter == filter;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: ElevatedButton(
          onPressed: () => setState(() => selectedFilter = filter),
          style: ElevatedButton.styleFrom(
            backgroundColor: isActive ? activeColor : Colors.grey[300],
            foregroundColor: isActive ? Colors.white : Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:tngtong/config.dart';
import 'package:tngtong/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';
import 'nav_bar.dart';
import 'package:tngtong/affiliate/ProfileScreen.dart';
import 'package:tngtong/affiliate/walletScreen.dart';

class AffiliateDashboardScreen extends StatefulWidget {
  const AffiliateDashboardScreen({Key? key}) : super(key: key);

  @override
  State<AffiliateDashboardScreen> createState() => _AffiliateDashboardScreenState();
}

class _AffiliateDashboardScreenState extends State<AffiliateDashboardScreen> {
  // UI State
  bool _isNavBarOpen = false;
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';
  bool _showBanner = true;
  String selectedFilter = 'all';

  // User Data
  String? loginEmail;
  String? userId;
  String userType = "affiliater";

  // Financial Data
  double walletBalance = 0.0;
  double earningsBalance = 0.0;
  String referralCode = 'Loading...';
  String? kycStatus;

  // Referral Data
  List<Map<String, dynamic>> referrals = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initializeData();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    if (_scrollController.offset > 100 && _showBanner) {
      setState(() => _showBanner = false);
    } else if (_scrollController.offset <= 100 && !_showBanner) {
      setState(() => _showBanner = true);
    }
  }
/*
  Future<void> _initializeData() async {
    try {
      setState(() {
        _isLoading = true;
        _hasError = false;
      });

      // Load shared preferences
      final prefs = await SharedPreferences.getInstance();
      loginEmail = prefs.getString('loginEmail');

      if (loginEmail == null) {
        throw Exception('User not logged in');
      }

      // Fetch user ID first (required for other calls)
      await _fetchUserId();

      // Fetch all other data in parallel
      await Future.wait([
        _fetchReferralCode(),
        _fetchWalletBalance(),
        _fetchEarningsBalance(),
        _fetchReferrals(),
        _fetchKycStatus(),
      ]);

      setState(() => _isLoading = false);
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
        _errorMessage = 'Failed to load data: ${e.toString()}';
      });
      debugPrint('Initialization error: $e');
    }
  }
*/
  Future<void> _initializeData() async {
    try {
      if (!mounted) return;
      setState(() => _isLoading = true);

      // Load shared preferences
      final prefs = await SharedPreferences.getInstance();
      loginEmail = prefs.getString('loginEmail');

      if (loginEmail == null) {
        throw Exception('User not logged in');
      }

      // Fetch user ID first (required for other calls)
      await _fetchUserId();

      // Fetch all other data in parallel
      await Future.wait([
        _fetchReferralCode(),
        _fetchWalletBalance(),
        _fetchEarningsBalance(),
        _fetchReferrals(),
        _fetchKycStatus(),
      ]);

      // Check if all essential data is loaded
      final isDataComplete = userId != null &&
          referralCode != 'Loading...' &&
          referrals.isNotEmpty;

      if (!isDataComplete) {
        throw Exception('Incomplete data loaded');
      }

      if (mounted) {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      debugPrint('Initialization error: $e');

      // Auto-retry after 3 seconds if data isn't complete
      if (mounted) {
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) _initializeData();
        });
      }
    }
  }
  Future<void> _fetchUserId() async {
    final id = await ApiService.getAffilaterId(loginEmail);
    if (id == null) {
      throw Exception('Failed to fetch user ID');
    }
    setState(() => userId = id);
  }

  Future<void> _fetchReferralCode() async {
    if (userId == null) return;
    final code = await ApiService.getMyReferralCode(userId, userType);
    setState(() => referralCode = code ?? 'Not available');
  }

  Future<void> _fetchWalletBalance() async {
    if (userId == null) return;
    final balance = await ApiService.getAffilaterWalletBalance(userId);
    setState(() => walletBalance = balance ?? 0.0);
  }

  Future<void> _fetchEarningsBalance() async {
    if (userId == null) return;
    final balance = await ApiService.getEarningsBal(userId, userType);
    setState(() => earningsBalance = balance ?? 0.0);
  }

  Future<void> _fetchReferrals() async {
    if (userId == null) return;
    final referralList = await ApiService.getReferralDetails(userId!, userType);
    setState(() => referrals = referralList);
  }

  Future<void> _fetchKycStatus() async {
    if (userId == null) return;
    final status = await ApiService.getKycStatus(userId, userType);
    setState(() => kycStatus = status);

    if (status != "verified" && status != null && mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showKycPopup(context, status);
      });
    }
  }

  void _showKycPopup(BuildContext context, String status) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(status == "Pending" ? "KYC Approval Pending" : "KYC Not Completed"),
          content: Text(status == "Pending"
              ? "Your KYC approval is pending."
              : "Your KYC is not yet completed. Please complete your KYC."),
          actions: <Widget>[
            TextButton(
              child: const Text("Complete KYC"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileUpdateScreen()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _shareReferralCode() {
    Share.share('Join me and start earning! My referral code is: $referralCode');
  }

  void _copyReferralCode() {
    Clipboard.setData(ClipboardData(text: referralCode));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Referral code copied to clipboard')),
    );
  }

  Widget _buildAppBar() {
    return Container(
      width: double.infinity,
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.purple.shade500,
            Colors.purple.shade500,
            Colors.purple.shade500
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/new-logo.png',
            width: 35,
            height: 35,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.menu, size: 24, color: Colors.white),
            onPressed: () => setState(() => _isNavBarOpen = true),
          ),
          const SizedBox(width: 10),
          const Text(
            Config.appname,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WalletScreen()),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.purple.shade400,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '₹${walletBalance.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.account_balance_wallet, color: Colors.white, size: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardCards() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildDashboardCard(
            Icons.account_balance_wallet,
            'Wallet',
            '₹${walletBalance.toStringAsFixed(2)}',
            Colors.purple.shade500,
          ),
          _buildDashboardCard(
            Icons.monetization_on,
            'Income',
            '₹${earningsBalance.toStringAsFixed(2)}',
            Colors.purple.shade500,
          ),
          _buildDashboardCard(
            Icons.people,
            'Referrals',
            referrals.length.toString(),
            Colors.purple.shade500,
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardCard(IconData icon, String title, String value, Color color) {
    return Expanded(
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 2,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(icon, size: 24, color: color),
                      const SizedBox(width: 11),
                      Text(
                        value,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReferralBanner() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Transform.scale(
              scale: 1.5,
              child: Container(
                height: 100,
                width: 90,
                child: Image.asset(
                  'assets/images/banner_icon.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(width: 30),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Refer & Earn!",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Refer business owners, influencers, and your loved ones to us—earn up to ₹300 per referral and help businesses and people grow together!",
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.start,
                    softWrap: true,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildReferralCodeCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple.shade500, Colors.purple.shade700],
            ),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          child: Column(
            children: [
              const Text(
                'Your Referral Code:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      referralCode,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: _copyReferralCode,
                    ),
                    IconButton(
                      icon: const Icon(Icons.share),
                      onPressed: _shareReferralCode,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButton(String filter, String text, Color activeColor) {
    final isActive = selectedFilter == filter;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: ElevatedButton(
          onPressed: () => setState(() => selectedFilter = filter),
          style: ElevatedButton.styleFrom(
            backgroundColor: isActive ? activeColor : Colors.grey[300],
            foregroundColor: isActive ? Colors.white : Colors.black,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReferralList() {
    final filteredReferrals = selectedFilter == 'all'
        ? referrals
        : referrals.where((r) => r['status'] == selectedFilter).toList();

    if (filteredReferrals.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('No referrals found', textAlign: TextAlign.center),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredReferrals.length,
      itemBuilder: (context, index) {
        final referral = filteredReferrals[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Card(
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              leading: Icon(
                referral['status'] == 'verified'
                    ? Icons.check_circle
                    : Icons.hourglass_empty,
                color: referral['status'] == 'verified'
                    ? Colors.purple.shade500
                    : Colors.orange,
              ),
              title: Text(
                referral['name'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Referral Date: ${referral['referralDate']}'),
                  Text('User Type: ${referral['userType']}'),
                ],
              ),
              trailing: Chip(
                label: Text(
                  referral['status'],
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: referral['status'] == 'verified'
                    ? Colors.purple.shade500
                    : Colors.orange,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else if (_hasError)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_errorMessage),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _initializeData,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              )
            else
              SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    _buildAppBar(),
                    _buildDashboardCards(),
                    _buildReferralBanner(),
                    if (_showBanner) ...[
                      const SizedBox(height: 20),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Earn Through Referrals:',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildReferralCodeCard(),
                      const SizedBox(height: 20),
                    ],
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'My Referrals:',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.purple.shade500, Colors.purple.shade700],
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              _buildFilterButton('all', 'All', Colors.purple.shade800),
                              _buildFilterButton('pending kyc', 'Pending KYC', Colors.purple.shade700),
                              _buildFilterButton('verified', 'Verified', Colors.purple.shade600),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildReferralList(),
                    const SizedBox(height: 20),
                  ],
                ),
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
}*/





import 'package:flutter/material.dart';
import 'package:tngtong/config.dart';
import 'package:tngtong/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'nav_bar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';
import 'package:tngtong/affiliate/ProfileScreen.dart';
import 'package:tngtong/affiliate/walletScreen.dart';
//import 'package:tngtong/auth/login_screen.dart'; // Import your fallback screen

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
  double? walletBalance;
  double? EarningsBal;
  String? userType = "affiliater";
  String? ReferralCode;
  String? kycStatus;
  String selectedFilter = 'all';
  final ScrollController _scrollController = ScrollController();
  bool _showBanner = true;

  late List<Map<String, dynamic>> referrals = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
    _initializeData();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    if (_scrollController.offset > 100 && _showBanner) {
      setState(() => _showBanner = false);
    } else if (_scrollController.offset <= 100 && !_showBanner) {
      setState(() => _showBanner = true);
    }
  }

  Future<void> _initializeData() async {
    try {
      // Initialize preferences and get login email
      prefs = await SharedPreferences.getInstance();
      loginEmail = prefs?.getString('loginEmail');

      if (loginEmail == null) {
        _navigateToFallbackScreen();
        return;
      }

      // Fetch all required data
      userId = await ApiService.getAffilaterId(loginEmail);

      if (userId == null) {
        _navigateToFallbackScreen();
        return;
      }

      // Fetch dependent data in parallel
      await Future.wait([
        _getMyRefCode(),
        _fetchReferrals(),
        getWallteBalance(),
        getEarningsBal(),
        checkKycStatus(),
        fetchDashboardData(),
      ]);
    } catch (e) {
      print("Error loading data: $e");
      _navigateToFallbackScreen();
    }
  }

  void _navigateToFallbackScreen() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const AffiliateDashboardScreen()), // Replace with your fallback screen
            (Route<dynamic> route) => false, // This removes all previous routes
      );
    });
  }

  Future<void> _fetchReferrals() async {
    if (userId == null) return;
    List<Map<String, dynamic>> referrals1 =
    await ApiService.getReferralDetails(userId!, "affiliater");
    setState(() => referrals = referrals1);
  }

  Future<void> _getMyRefCode() async {
    if (userId == null) return;
    String? ReferralId = await ApiService.getMyReferralCode(userId, userType);
    setState(() => ReferralCode = ReferralId);
  }

  Future<void> getWallteBalance() async {
    if (userId == null) return;
    double? balance = await ApiService.getAffilaterWalletBalance(userId);
    setState(() => walletBalance = balance ?? 0);
  }

  Future<void> getEarningsBal() async {
    if (userId == null) return;
    double? balance = await ApiService.getEarningsBal(userId, "affiliater");
    setState(() => EarningsBal = balance ?? 0);
  }

  Future<void> checkKycStatus() async {
    if (userId == null) return;
    try {
      String? status = await ApiService.getKycStatus(userId, "affiliater");
      setState(() => kycStatus = status);

      if (status != "verified" && status != null && mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showKycPopup(context, status);
        });
      }
    } catch (e) {
      print("Error checking KYC status: $e");
    }
  }

  void _showKycPopup(BuildContext context, String status) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(status == "Pending" ? "KYC Approval Pending" : "KYC Not Completed"),
          content: Text(status == "Pending" ? "Your KYC approval is pending." : "Your KYC is not yet completed. Please complete your KYC."),
          actions: <Widget>[
            TextButton(
              child: Text("Complete KYC"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileUpdateScreen()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _shareReferralCode(String code) {
    Share.share('Join me and start earning! My referral code is: $code');
  }

  void _copyReferralCode(String code) {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Referral code copied to clipboard')),
    );
  }

  Future<void> fetchDashboardData() async {
    // Fetch data from API or use dummy data
    String dummyJson = '''{"username": "John Doe", "registrationDate": "2024-01-01", "kycStatus": "Completed", "walletBalance": 5000, "referralIncome": 2500, "totalReferrals": 30}''';
    setState(() {
      dashboardData = json.decode(dummyJson);
    });
  }

  @override
  Widget build(BuildContext context) {
    // If we got here, data loading was successful
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  // Custom App Bar Section
                  Container(
                    width: double.infinity,
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.purple.shade500,
                          Colors.purple.shade500,
                          Colors.purple.shade500
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/new-logo.png',
                          width: 35,
                          height: 35,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          icon: const Icon(
                            Icons.menu,
                            size: 24,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() => _isNavBarOpen = true);
                          },
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          Config.appname,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        // Wallet Icon with Balance (clickable)
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WalletScreen(),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.purple.shade400,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '₹${walletBalance?.toStringAsFixed(2) ?? '0.00'}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(
                                  Icons.account_balance_wallet,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  _buildDashboardCards(),
                  const SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Transform.scale(
                            scale: 1.5,
                            child: Container(
                              height: 100,
                              width: 90,
                              child: Image.asset(
                                'assets/images/banner_icon.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(width: 30),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Refer & Earn!",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Refer business owners, influencers, and your loved ones to us—earn up to ₹300 per referral and help businesses and people grow together!",
                                  style: TextStyle(fontSize: 14),
                                  textAlign: TextAlign.start,
                                  softWrap: true,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  if (_showBanner) ...[
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Earn Through Referrals:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.purple.shade500,
                                Colors.purple.shade700,
                              ],
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'Your Referral Code:',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      ReferralCode ?? '',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    IconButton(
                                      icon: const Icon(Icons.copy),
                                      onPressed: ReferralCode != null
                                          ? () => _copyReferralCode(ReferralCode!)
                                          : null,
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.share),
                                      onPressed: ReferralCode != null
                                          ? () => _shareReferralCode(ReferralCode!)
                                          : null,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'My Referrals:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.purple.shade500,
                              Colors.purple.shade700,
                            ],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            _buildFilterButton('all', 'All', Colors.purple.shade800),
                            _buildFilterButton('pending kyc', 'Pending KYC', Colors.purple.shade700),
                            _buildFilterButton('verified', 'Verified', Colors.purple.shade600),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: referrals.length,
                    itemBuilder: (context, index) {
                      final referral = referrals[index];
                      if (selectedFilter != 'all' && referral['status'] != selectedFilter) {
                        return const SizedBox.shrink();
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: Card(
                          margin: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: Icon(
                              referral['status'] == 'verified'
                                  ? Icons.check_circle
                                  : Icons.hourglass_empty,
                              color: referral['status'] == 'verified'
                                  ? Colors.purple.shade500
                                  : Colors.orange,
                            ),
                            title: Text(
                              referral['name'],
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Referral Date: ${referral['referralDate']}'),
                                Text('User Type: ${referral['userType']}'),
                              ],
                            ),
                            trailing: Chip(
                              label: Text(
                                referral['status'],
                                style: const TextStyle(color: Colors.white),
                              ),
                              backgroundColor: referral['status'] == 'verified'
                                  ? Colors.purple.shade500
                                  : Colors.orange,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
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

  Widget _buildDashboardCards() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildDashboardCard(
            Icons.account_balance_wallet,
            'Wallet',
            '₹${walletBalance?.toStringAsFixed(2) ?? '0.00'}',
            Colors.purple.shade500,
          ),
          _buildDashboardCard(
            Icons.monetization_on,
            'Income',
            '₹${EarningsBal?.toStringAsFixed(2) ?? '0.00'}',
            Colors.purple.shade500,
          ),
          _buildDashboardCard(
            Icons.people,
            'Referrals',
            referrals.length.toString(),
            Colors.purple.shade500,
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardCard(IconData icon, String title, String value, Color color) {
    return Expanded(
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 2,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(icon, size: 24, color: color),
                      const SizedBox(width: 11),
                      Text(
                        value,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(String filter, String text, Color activeColor) {
    final bool isActive = selectedFilter == filter;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: ElevatedButton(
          onPressed: () => setState(() => selectedFilter = filter),
          style: ElevatedButton.styleFrom(
            backgroundColor: isActive ? activeColor : Colors.grey[300],
            foregroundColor: isActive ? Colors.white : Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}