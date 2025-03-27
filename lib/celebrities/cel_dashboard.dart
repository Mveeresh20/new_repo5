/*import 'dart:convert';
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
*/
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:tngtong/config.dart';
import 'package:url_launcher/url_launcher.dart';
import 'nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tngtong/api_service.dart';
import 'project_details_screen.dart';
import 'package:http/http.dart' as http;
import 'myProjectScreen.dart';
import 'package:tngtong/celebrities/cel_profile.dart';
import 'package:tngtong/celebrities/walletScreen.dart';
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
  List<Map<String, String>> brandLogos = [];
  int displayCount = 8;
  double? walletBalance=0;
  double? EarningBalance=0;
  String? kycStatus;

  final String jsonData = '''
  [
    {"name": "Amazon", "logo": "https://logo.clearbit.com/amazon.com", "url": "https://www.amazon.com"},
    {"name": "Myntra", "logo": "https://logo.clearbit.com/myntra.com", "url": "https://www.myntra.com"},
    {"name": "Ajio", "logo": "https://logo.clearbit.com/ajio.com", "url": "https://www.ajio.com"},
    {"name": "Meesho", "logo": "https://logo.clearbit.com/meesho.com", "url": "https://www.meesho.com"},
    {"name": "Instagram", "logo": "https://logo.clearbit.com/instagram.com", "url": "https://www.instagram.com"},
    {"name": "Crocs", "logo": "https://logo.clearbit.com/crocs.com", "url": "https://www.crocs.com"},
    {"name": "Nykaa", "logo": "https://logo.clearbit.com/nykaa.com", "url": "https://www.nykaa.com"},
    {"name": "Nike", "logo": "https://logo.clearbit.com/nike.com", "url": "https://www.nike.com"},
    {"name": "Adidas", "logo": "https://logo.clearbit.com/adidas.com", "url": "https://www.adidas.com"},
    {"name": "Zara", "logo": "https://logo.clearbit.com/zara.com", "url": "https://www.zara.com"},
    {"name": "Zara", "logo":"https://logo.clearbit.com/coursera.com", "url": "https://www.coursera.com"}

  ]
  ''';

  @override
  void initState() {
    super.initState();
    _initializePreferences();
    List<dynamic> decodedJson = json.decode(jsonData);
    brandLogos = decodedJson.map((item) {
      return {
        'name': item['name'].toString(),
        'logo': item['logo'].toString(),
        'url': item['url'].toString(),
      };
    }).toList();
  }

  Future<void> _initializePreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      loginEmail = prefs?.getString('loginEmail');
    });
    fetchUserId();

  }

  IconData _getProjectIcon(String? title) {
    if (title == null) return Icons.work;

    switch (title.toLowerCase()) {
      case 'website development':
        return Icons.public;
      case 'mobile app ui design':
        return Icons.smartphone;
      case 'social media marketing':
        return Icons.campaign;
      default:
        return Icons.work; // Default icon
    }
  }

  /*Future<void> fetchUserId() async {
    String? id = await ApiService.getCelId(loginEmail);
    setState(() {
      userId = id;
    });
    _loadProjectRequests();
    getWallteBalance();
    getEarningBalance();
  }*/
  bool isLoading = false;

  Future<void> fetchUserId() async {
    setState(() {
      isLoading = true;
    });

    try {
      String? id = await ApiService.getCelId(loginEmail);
      if (id != null) {
        setState(() {
          userId = id;
        });
        checkKycStatus();
        await getWallteBalance();
        await getEarningBalance();
        await _loadProjectRequests();

      } else {
        print("User ID is null");
      }
    } catch (e) {
      print("Error fetching user ID: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> checkKycStatus() async {
    try {
      String? status = await ApiService.getKycStatus(userId,"celebrity");
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

/*
  Future<void> _loadProjectRequests() async {
    String jsonString = '''
    [
      {
        "id": 1,
        "title": "Website Development",
        "request_date": "11-02-2024",
        "description": "Need a responsive website for a startup."
      },
      {
        "id": 2,
        "title": "Mobile App UI Design",
        "request_date": "10-02-2024",
        "description": "Design a modern UI for a healthcare app."
      },
      {
        "id": 3,
        "title": "Social Media Marketing",
        "request_date": "09-02-2024",
        "description": "Manage and optimize Facebook & Instagram ads."
      }
    ]
    ''';

    setState(() {
      projectRequests = json.decode(jsonString);
    });
  }*/
  Future<void> getWallteBalance() async {
    double? balance = await ApiService.getCelebrityWalletBalance(userId);
    setState(() {
      walletBalance = balance?? 0;
    });
  }
  Future<void> getEarningBalance() async {
    double? balance = await ApiService.getEarningsBal(userId,"celebrity");
    setState(() {
      EarningBalance = balance ?? 0;

    });

  }
  Future<void> _loadProjectRequests() async {
    if (userId == null) {
      return; // Ensure userId is available
    }

    final response = await http.get(
      Uri.parse('${Config.apiDomain}${Config.get_influencer_projects}$userId'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['success'] == true) {
        setState(() {
          projectRequests = data['projects']; // Update projectRequests with the fetched projects
        });
      } else {
        throw Exception('Failed to load projects: ${data['message']}');
      }
    } else {
      throw Exception('Failed to load projects: ${response.statusCode}');
    }
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
              SingleChildScrollView(
                // Wrapping entire body in SingleChildScrollView
                child: Column(
                  children: [
                    // App Bar Section
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 16.0,
                        bottom: 16.0,
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 40,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.purple.shade500,
                                Colors.purple.shade500,
                                Colors.purple.shade500
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.bottomRight),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/new-logo.png',
                              width: 35,
                              height: 90,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            // Menu Button
                            IconButton(
                              icon: const Icon(
                                Icons.menu,
                                size: 24,
                                color: Colors.white,
                              ),
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
                            const SizedBox(width: 8),
                            IconButton(
                              icon: const Icon(
                                Icons.notifications,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Card Row for Wallet Balance, New Projects, Completed Projects
                   /* Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildCard("Wallet Balance", "₹10,000",
                              Icons.account_balance_wallet),
                          _buildCard("New Projects", "5", Icons.work),
                          _buildCard("Projects Done", "3", Icons.check_circle),
                        ],
                      ),
                    ),*/
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildCard("Wallet Balance", "₹ ${walletBalance}", Icons.account_balance_wallet),
                          _buildCard(" Projects", projectRequests.length.toString(), Icons.work), // Display project count
                          _buildCard("Earning Balance", "₹ ${EarningBalance}", Icons.check_circle), // You can update this dynamically as well
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/medias.png',
                              height: 150,
                              width: 140,
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
                                    "Hello John!",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Excited to have you on board! Our platform is designed to connect you with top brands...",
                                    style: TextStyle(fontSize: 11),
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

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            "My Projects",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),

                    // Project List
                   /* projectRequests.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        :// Project List*/
                    projectRequests.isEmpty
                        ? const Center(child: Text('No Projects', style: TextStyle(fontSize: 16, color: Colors.grey)))
                        : Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.all(0),
                          itemCount: projectRequests.length > 5 ? 5 : projectRequests.length, // Limit to 5 items
                          itemBuilder: (context, index) {
                            var project = projectRequests[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      _getProjectIcon(project['b_desc']), // Use b_desc for the icon
                                      size: 30,
                                      color: Colors.purple[500],
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            project['user_name'] ?? 'Customer Name', // Display customer name
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            'Description: ${project['b_desc'] ?? 'N/A'}', // Display project description
                                            style: TextStyle(fontSize: 12, color: Colors.grey),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            'Requested Date: ${project['b_date'] ?? 'N/A'}', // Display request date
                                            style: TextStyle(fontSize: 12, color: Colors.cyan),
                                          ),
                                          SizedBox(height: 5),
                                          const Divider(thickness: 1, color: Colors.grey),
                                          SizedBox(height: 5),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => MyProjectsScreen(),
                                                  ),
                                                );
                                              },
                                              child: const Text(
                                                'View Details',
                                                style: TextStyle(color: Colors.white),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                                minimumSize: Size(80, 30),
                                                backgroundColor: Colors.purple[500],
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        if (projectRequests.length > 5) // Show "View More" button if there are more than 5 projects
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyProjectsScreen(),
                                  ),
                                );
                              },
                              child: Text('View More'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple[500],
                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    /*Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.all(0),
                          itemCount: projectRequests.length > 5 ? 5 : projectRequests.length, // Limit to 5 items
                          itemBuilder: (context, index) {
                            var project = projectRequests[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      _getProjectIcon(project['b_desc']), // Use b_desc for the icon
                                      size: 30,
                                      color: Colors.purple[500],
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            project['user_name'] ?? 'Customer Name', // Display customer name
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            'Description: ${project['b_desc'] ?? 'N/A'}', // Display project description
                                            style: TextStyle(fontSize: 12, color: Colors.grey),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            'Requested Date: ${project['b_date'] ?? 'N/A'}', // Display request date
                                            style: TextStyle(fontSize: 12, color: Colors.cyan),
                                          ),
                                          SizedBox(height: 5),
                                          const Divider(thickness: 1, color: Colors.grey),
                                          SizedBox(height: 5),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => ProjectDetailsScreen(
                                                      projectDetails: project,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: const Text(
                                                'View Details',
                                                style: TextStyle(color: Colors.white),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                                minimumSize: Size(80, 30),
                                                backgroundColor: Colors.purple[500],
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        if (projectRequests.length > 0) // Show "View More" button if there are more than 5 projects
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                    builder: (context) => MyProjectsScreen(),
                                ));
                              },
                              child: Text('View More'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple[500],
                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),*/
                        /*: ListView.builder(
                      shrinkWrap:
                      true, // Makes the list shrink to fit content
                      physics:
                      NeverScrollableScrollPhysics(), // Disables scroll within list
                      padding: EdgeInsets.all(0),
                      itemCount: projectRequests.length,
                      itemBuilder: (context, index) {
                        var project = projectRequests[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  _getProjectIcon(project['title']),
                                  size: 30,
                                  color: Colors.purple[500],
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        project['title'] ??
                                            'Project Request',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Requested Date: ${project['request_date'] ?? 'N/A'}',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.cyan),
                                      ),
                                      SizedBox(height: 5),
                                      const Divider(
                                          thickness: 1,
                                          color: Colors.grey),
                                      SizedBox(height: 5),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProjectDetailsScreen(
                                                      projectDetails: project,
                                                    ),
                                              ),
                                            );
                                          },
                                          child: const Text(
                                            'View Details',
                                            style: TextStyle(
                                                color: Colors.white),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5,
                                                horizontal: 10),
                                            minimumSize: Size(80, 30),
                                            backgroundColor:
                                            Colors.purple[500],
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  10),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),*/
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Popular Brands",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          GridView.builder(
                            shrinkWrap:
                            true, // Makes the list shrink to fit content
                            physics: NeverScrollableScrollPhysics(),

                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4, // 4 logos per row
                              crossAxisSpacing: 18,
                              mainAxisSpacing: 19,
                              childAspectRatio: 1, // Keep aspect ratio square
                            ),
                            itemCount: displayCount,
                            itemBuilder: (context, index) {
                              if (index >= brandLogos.length) return SizedBox();
                              final brand = brandLogos[index];

                              return GestureDetector(
                                onTap: () => _openBrandUrl(brand["url"]!),
                                child: Column(
                                  children: [
                                    ClipOval(
                                      child: Image.network(
                                        brand["logo"]!,
                                        width: 45,
                                        height: 45,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      brand["name"]!,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          Align(

                              alignment: Alignment.centerRight,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  if (displayCount < brandLogos.length)
                                    ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            displayCount +=
                                            4; // Show 4 more logos on click
                                          });
                                        },
                                        child: Text("View More", style: TextStyle(color: Colors.white),),
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5,
                                              horizontal: 10),
                                          minimumSize: Size(80, 30),
                                          backgroundColor:
                                          Colors.purple[500],
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(
                                                10),
                                          ),
                                        )
                                    ),
                                  if (displayCount >
                                      8) // Conditionally show "View Less"
                                    ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            displayCount = 8;
                                          });
                                        },
                                        child: Text("View Less", style: TextStyle(color: Colors.white),),
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5,
                                              horizontal: 10),
                                          minimumSize: Size(80, 30),
                                          backgroundColor:
                                          Colors.purple[500],
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(
                                                10),
                                          ),
                                        )
                                    )],)
                          ) ],
                      ),
                    ),
                  ],
                ),
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

  Widget _buildCard(String title, String value, IconData icon) {
    return SizedBox(
      height: 90,
      width: 115,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 2,
                decoration: BoxDecoration(
                  color: Colors.purple.shade500,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(icon, size: 24, color: Colors.purple.shade500),
                      const SizedBox(width: 11),
                      Center(
                        child: Text(
                          value,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
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

  void _openBrandUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("Could not open $url");
    }
  }
}
