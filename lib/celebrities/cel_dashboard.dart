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
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:tngtong/config.dart';
import 'nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tngtong/api_service.dart';
import 'project_details_screen.dart';

class CelebrityDashboardScreen extends StatefulWidget {
  const CelebrityDashboardScreen({Key? key}) : super(key: key);

  @override
  State<CelebrityDashboardScreen> createState() =>
      _CelebrityDashboardScreenState();
}

class _CelebrityDashboardScreenState extends State<CelebrityDashboardScreen> {
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
                            trailing: ElevatedButton(
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
                            ),
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

}
