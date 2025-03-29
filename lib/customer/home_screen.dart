/*import 'package:flutter/material.dart';
import 'package:tngtong/config.dart';
import 'nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isNavBarOpen = false; // To track NavBar state
  SharedPreferences? prefs; // SharedPreferences instance
  String? loginEmail; // To store the retrieved email

  // Dummy Data for cards
  final List<Map<String, String>> dummyData = [
    {
      'image': 'https://via.placeholder.com/150',
      'actor': 'Actor 1',
      'price': '\$100',
    },
    {
      'image': 'https://via.placeholder.com/150',
      'actor': 'Actor 2',
      'price': '\$120',
    },
    {
      'image': 'https://via.placeholder.com/150',
      'actor': 'Actor 3',
      'price': '\$90',
    },
    {
      'image': 'https://via.placeholder.com/150',
      'actor': 'Actor 4',
      'price': '\$110',
    },
    {
      'image': 'https://via.placeholder.com/150',
      'actor': 'Actor 5',
      'price': '\$80',
    },
  ];

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
                        const SizedBox(width: 10),

                        // App Name
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
                              itemCount: dummyData.length,
                              itemBuilder: (context, index) {
                                final item = dummyData[index];
                                return Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    elevation: 3,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.4, // 40% of screen width
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xffFF04AB),
                                            Color(0xffAE26CD),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          // Image at the top of the card
                                          Container(
                                            height: 120,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  item['image']!,
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(15),
                                              ),
                                            ),
                                          ),
                                          // Actor name at the bottom of the image
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              item['actor']!,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          // Second row containing price and book button
                                          Padding(
                                            padding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                // Price Text
                                                Text(
                                                  item['price']!,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                // Book Button
                                                ElevatedButton(
                                                  onPressed: () {
                                                    // Handle booking action
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.green, // Button color
                                                  ),
                                                  child: const Text(
                                                    'Book',
                                                    style: TextStyle(fontSize: 10),
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                        ],
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
}*/

/*
//------------------------------------------veeresh code-------------------------------------
import 'package:flutter/material.dart';
import 'package:social_media_buttons/social_media_button.dart';
import 'package:tngtong/config.dart';
import 'package:url_launcher/url_launcher.dart';
import 'nav_bar.dart';
import 'dashboard._json.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _BrandLoginDashboardState();
}

class _BrandLoginDashboardState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> allInfluencers = [
    "Influencer 1",
    "Influencer 2",
    "Influencer 3",
    "Influencer 4",
    "Influencer 5",
    "InfluencerX",
  ];
  bool _isNavBarOpen = false; // To track NavBar state
  List<String> filteredInfluencers = [];
  List<dynamic> trendingAds = [];
  List<dynamic> topInfluencers = [];

  @override
  void initState() {
    super.initState();
    filteredInfluencers = allInfluencers;
    loadData();
  }

  void _filterSearch(String query) {
    setState(() {
      filteredInfluencers = query.isEmpty
          ? allInfluencers
          : allInfluencers
          .where((influencer) =>
          influencer.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void loadData() {
    setState(() {
      trendingAds = jsonData["trending"];
      topInfluencers = jsonData["top_influencers"];
    });
  }

  Future<bool> _onWillPop() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Exit App"),
        content: const Text("Do you really want to exit?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("Yes"),
          ),
        ],
      ),
    ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop, // Handle back button press
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAppBar(),
                    _buildSearchBar(),
                    _buildSectionTitle("Trending Ads"),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _buildHorizontalList(trendingAds, adCard),
                    ),
                    _buildSectionTitle("Top Influencers"),
                    _buildHorizontalList(topInfluencers, influencerCard),
                  ],
                ),
              ),

              // Background overlay when NavBar is open
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

              // Animated NavBar inside a Positioned widget
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                left: _isNavBarOpen ? 0 : -250, // NavBar slides in/out
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

  Widget _buildAppBar() {
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade500, Colors.purple.shade500],
          begin: Alignment.centerLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              setState(() {
                _isNavBarOpen = true;
              });
            },
          ),
          const Text(
            "Influencer Setter",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 5,
                spreadRadius: 1,
                offset: const Offset(0, 3))
          ],
        ),
        child: TextField(
          controller: _searchController,
          onChanged: _filterSearch,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            suffixIcon: const Icon(Icons.mic, color: Colors.grey),
            hintText: "Search influencer",
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildHorizontalList(
      List<dynamic> data, Widget Function(dynamic) cardBuilder) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index) => cardBuilder(data[index]),
      ),
    );
  }

  Widget adCard(dynamic ad) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: 130,
        child: Column(
          children: [
            Expanded(
                child: Image.network(ad['image'],
                    width: 130, height: 50, fit: BoxFit.cover)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(ad['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(ad['price'], style: const TextStyle(color: Colors.red)),
                  _buildSocialIcons(ad['facebook'], ad['instagram'])
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildSocialIcons(String fbUrl, String instaUrl) {
    return Row(
      children: [
        IconButton(
            icon: const Icon(
              Icons.facebook,
              color: Colors.blue,
              size: 40,
            ),
            onPressed: () => launchUrl(Uri.parse(fbUrl))),
        SocialMediaButton.instagram(
          onTap: () => launchUrl(Uri.parse(instaUrl)),
          size: 35,
          color: Colors.purple,
        ),
      ],
    );
  }
  Widget influencerCard(dynamic influencer) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: 130,
        child: Column(
          children: [
            Expanded(
                child: Image.network(influencer['image'],
                    width: 130, fit: BoxFit.cover)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(influencer['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text("Followers: ${influencer['followers']}",
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
*/



/*
import 'package:flutter/material.dart';
import 'package:social_media_buttons/social_media_button.dart';
import 'package:tngtong/config.dart';
import 'package:url_launcher/url_launcher.dart';
import 'nav_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tngtong/customer/HireInfluencerScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isNavBarOpen = false;
  List<dynamic> trendingAds = [];
  List<dynamic> topInfluencers = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final String apiUrl = "https://demo.infoskaters.com/api/get_top_trending_cel.php";
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        setState(() {
          trendingAds = jsonData["trending"];
          topInfluencers = jsonData["top_influencers"];
        });
      } else {
        print("Error: Failed to load data. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAppBar(),
                  _buildSearchBar(),
                  _buildSectionTitle("Trending Ads"),
                  _buildHorizontalList(trendingAds),
                  _buildSectionTitle("Top Influencers"),
                  _buildHorizontalList(topInfluencers),
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
              child: NavBar(
                onClose: () => setState(() => _isNavBarOpen = false),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.purple.shade500, Colors.purple.shade500])),
      child: Row(
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
          IconButton(icon: const Icon(Icons.menu, color: Colors.white), onPressed: () => setState(() => _isNavBarOpen = true)),
          const Text("Influencer Setter", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const Spacer(),
          IconButton(icon: const Icon(Icons.notifications, color: Colors.white), onPressed: () {}),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: "Search influencer",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }

  Widget _buildHorizontalList(List<dynamic> data) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index) => _buildCard(context, data[index]),
      ),
    );
  }

  Widget _buildCard(BuildContext context, dynamic influencer) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HireInfluencerScreen(influencer: influencer),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: 150,
          child: Column(
            children: [
              Container(
                width: 150,
                height: 120,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      influencer['image'] != null && influencer['image'].toString().isNotEmpty
                          ? "${Config.apiDomain}/${influencer['image']}"
                          : "https://demo.infoskaters.com/api/uploads/default_profile.png",
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),

              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(influencer['name'] ?? "Unknown", style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text("Price: ₹.${influencer['price'] ?? 0}", style: const TextStyle(color: Colors.grey)),
                    _buildSocialIcons(influencer['facebook'], influencer['instagram']),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIcons(String? fbUrl, String? instaUrl) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (fbUrl != null && fbUrl.isNotEmpty)
          IconButton(icon: const Icon(Icons.facebook, color: Colors.blue, size: 30), onPressed: () => launchUrl(Uri.parse(fbUrl))),
        if (instaUrl != null && instaUrl.isNotEmpty)
          SocialMediaButton.instagram(onTap: () => launchUrl(Uri.parse(instaUrl)), size: 30, color: Colors.purple),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:social_media_buttons/social_media_button.dart';
import 'package:tngtong/config.dart';
import 'package:url_launcher/url_launcher.dart';
import 'nav_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tngtong/customer/HireInfluencerScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ProfileScreen.dart';
import 'package:tngtong/config.dart'; // Replace with your config file
import 'package:tngtong/api_service.dart';
import 'walletScreen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isNavBarOpen = false;
  List<dynamic> trendingAds = [];
  List<dynamic> topInfluencers = [];
  List<dynamic> filteredTrendingAds = [];
  List<dynamic> filteredTopInfluencers = [];
  String? kycStatus;
  SharedPreferences? prefs; // SharedPreferences instance
  String? loginEmail; // To store the retrieved email
  String? userId;
  double? walletBalance = 0;

  @override
  void initState() {
    super.initState();
    _initializePreferences();
    //loadData();
  }
  Future<void> _initializePreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      loginEmail = prefs?.getString('loginEmail');
    });
    // Now that we have loginEmail, fetch the user ID
    await fetchUserId();
    // Then load other data
    await loadData();
  }

  Future<void> fetchUserId() async {
    String? id = await ApiService.getUserId(loginEmail);
    setState(() {
      userId = id;
    });
    checkKycStatus();
    getWallteBalance();

  }
  Future<void> getWallteBalance() async {
    double? balance = await ApiService.getBrandWalletBalance(userId);
    setState(() {
      walletBalance = balance ?? 0;
    });
  }
  Future<void> loadData() async {
    final String apiUrl = "https://demo.infoskaters.com/api/get_top_trending_cel.php";
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        setState(() {
          trendingAds = jsonData["trending"];
          topInfluencers = jsonData["top_influencers"];
          filteredTrendingAds = trendingAds; // Initialize filtered lists
          filteredTopInfluencers = topInfluencers;
        });
      } else {
        print("Error: Failed to load data. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
  Future<void> checkKycStatus() async {
    try {
      String? status = await ApiService.getKycStatus(userId,"user");
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

  void _searchInfluencers(String query) {
    setState(() {
      filteredTrendingAds = trendingAds
          .where((influencer) =>
      influencer['name'].toLowerCase().contains(query.toLowerCase()) ||
          influencer['price'].toString().contains(query))
          .toList();
      filteredTopInfluencers = topInfluencers
          .where((influencer) =>
      influencer['name'].toLowerCase().contains(query.toLowerCase()) ||
          influencer['price'].toString().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Main Content
            Column(
              children: [
                // Static App Bar
                _buildAppBar(),
                // Static Search Bar
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
                            height: 60,
                            width: 60,
                            child: Image.asset(
                              'assets/images/pas.png',
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
                                "PAY AFTER SALE!",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Stop Wasting Money & Boost Your Sales 10X with Pay-After-Sale Influencer Marketing!",
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

                _buildSearchBar(),
                // Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle("Trending Ads"),
                        _buildHorizontalList(filteredTrendingAds),
                        _buildSectionTitle("Top Influencers"),
                        _buildInfluencerGrid(filteredTopInfluencers),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Nav Bar Overlay
            if (_isNavBarOpen)
              GestureDetector(
                onTap: () => setState(() => _isNavBarOpen = false),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            // Nav Bar
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              left: _isNavBarOpen ? 0 : -250,
              top: 0,
              bottom: 0,
              child: NavBar(
                onClose: () => setState(() => _isNavBarOpen = false),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.purple.shade500, Colors.purple.shade500])),
      child: Row(
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
          IconButton(icon: const Icon(Icons.menu, color: Colors.white), onPressed: () => setState(() => _isNavBarOpen = true)),
          const Text("Influencer Setter", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
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
       //   IconButton(icon: const Icon(Icons.notifications, color: Colors.white), onPressed: () {}),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: "Search influencer by name or price",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          prefixIcon: const Icon(Icons.search),
        ),
        onChanged: (value) {
          _searchInfluencers(value); // Trigger search on text change
        },
        onSubmitted: (value) {
          _searchInfluencers(value); // Trigger search on submit
        },
      ),
    );
  }

  Widget _buildHorizontalList(List<dynamic> data) {
    return SizedBox(
      height: 325,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index) => _buildCard(context, data[index]),
      ),
    );
  }

  Widget _buildInfluencerGrid(List<dynamic> data) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(), // Disable GridView scrolling
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columns
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.6, // Adjust card aspect ratio
        ),
        itemCount: data.length,
        itemBuilder: (context, index) => _buildCard(context, data[index]),
      ),
    );
  }

  /*Widget _buildCard(BuildContext context, dynamic influencer) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HireInfluencerScreen(influencer: influencer),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: 150,
          child: Column(
            children: [
              Container(
                width: 150,
                height: 120,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      influencer['image'] != null && influencer['image'].toString().isNotEmpty
                          ? "${Config.apiDomain}/${influencer['image']}"
                          : "https://demo.infoskaters.com/api/uploads/default_profile.png",
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(influencer['name'] ?? "Unknown", style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text("Price: ₹.${influencer['price'] ?? 0}", style: const TextStyle(color: Colors.grey)),
                    _buildSocialIcons(influencer['facebook'], influencer['instagram']),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }*/
  Widget _buildCard(BuildContext context, dynamic influencer) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HireInfluencerScreen(influencer: influencer),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        elevation: 5, // Add shadow
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Rounded corners
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.45, // Responsive width
          padding: const EdgeInsets.all(8), // Padding inside the card
          child: Column(
            mainAxisSize: MainAxisSize.min, // Adjust height dynamically
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Image
              AspectRatio(
                aspectRatio: 1, // Maintain a square aspect ratio
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(
                        influencer['image'] != null && influencer['image'].toString().isNotEmpty
                            ? "${Config.apiDomain}/${influencer['image']}"
                            : "https://demo.infoskaters.com/api/uploads/default_profile.png",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8), // Spacing
              // Name
              Text(
                influencer['name'] ?? "Unknown",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis, // Handle long names
              ),
              const SizedBox(height: 4), // Spacing
              // Price
              Text(
                "Price: ₹.${influencer['price'] ?? 0}",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8), // Spacing
              // Social Media Icons with Flexible height
              Flexible(child: _buildSocialIcons(influencer)),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildSocialIcons(dynamic influencer) {
    // List of social media icons to display
    List<Widget> icons = [];

    // Add Facebook Icon
    if (influencer['facebook_link'] != null &&
        influencer['facebook_link'].toString().isNotEmpty &&
        influencer['facebook_followers'] != null &&
        influencer['facebook_followers'] != "N/A" &&
        int.tryParse(influencer['facebook_followers'])! > 0) {
      icons.add(
        SocialMediaButton.facebook(
          onTap: () => launchUrl(Uri.parse(influencer['facebook_link'])),
          size: 16, // Smaller size for better fit
          color: Colors.blue,
        ),
      );
    }

    // Add Instagram Icon
    if (influencer['instagram_link'] != null &&
        influencer['instagram_link'].toString().isNotEmpty &&
        influencer['instagram_followers'] != null &&
        influencer['instagram_followers'] != "N/A" &&
        int.tryParse(influencer['instagram_followers'])! > 0) {
      icons.add(
        SocialMediaButton.instagram(
          onTap: () => launchUrl(Uri.parse(influencer['instagram_link'])),
          size: 16,
          color: Colors.purple,
        ),
      );
    }

    // Add LinkedIn Icon
    if (influencer['linkedin_link'] != null &&
        influencer['linkedin_link'].toString().isNotEmpty &&
        influencer['linkedin_followers'] != null &&
        influencer['linkedin_followers'] != "N/A" &&
        int.tryParse(influencer['linkedin_followers'])! > 0) {
      icons.add(
        SocialMediaButton.linkedin(
          onTap: () => launchUrl(Uri.parse(influencer['linkedin_link'])),
          size: 16,
          color: Colors.blue,
        ),
      );
    }

    // Add YouTube Icon
    if (influencer['youtube_link'] != null &&
        influencer['youtube_link'].toString().isNotEmpty &&
        influencer['youtube_followers'] != null &&
        influencer['youtube_followers'] != "N/A" &&
        int.tryParse(influencer['youtube_followers'])! > 0) {
      icons.add(
        SocialMediaButton.youtube(
          onTap: () => launchUrl(Uri.parse(influencer['youtube_link'])),
          size: 16,
          color: Colors.red,
        ),
      );
    }

    // Add Twitter Icon
    if (influencer['twitter_link'] != null &&
        influencer['twitter_link'].toString().isNotEmpty &&
        influencer['twitter_followers'] != null &&
        influencer['twitter_followers'] != "N/A" &&
        int.tryParse(influencer['twitter_followers'])! > 0) {
      icons.add(
        SocialMediaButton.twitter(
          onTap: () => launchUrl(Uri.parse(influencer['twitter_link'])),
          size: 16,
          color: Colors.blue,
        ),
      );
    }

    // Ensure at least 5 icons (2 rows)
    if (icons.length < 5) {
      icons.addAll(List.filled(5 - icons.length, const SizedBox.shrink()));
    }

    // Display icons in a row with proper spacing
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4), // Reduced vertical padding
      child: Wrap(
        spacing: 4, // Reduced horizontal spacing between icons
        runSpacing: 4, // Reduced vertical spacing between rows
        alignment: WrapAlignment.center,
        children: icons,
      ),
    );
  }
  /*
  Widget _buildSocialIcons(dynamic influencer) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Facebook Icon
        if (influencer['facebook_link'] != null &&
            influencer['facebook_link'].toString().isNotEmpty &&
            influencer['facebook_followers'] != null &&
            influencer['facebook_followers'] != "N/A" &&
            int.tryParse(influencer['facebook_followers'])! > 0)
          SocialMediaButton.facebook(
            onTap: () => launchUrl(Uri.parse(influencer['facebook_link'])),
            size: 30,
            color: Colors.blue,
          ),

        // Instagram Icon
        if (influencer['instagram_link'] != null &&
            influencer['instagram_link'].toString().isNotEmpty &&
            influencer['instagram_followers'] != null &&
            influencer['instagram_followers'] != "N/A" &&
            int.tryParse(influencer['instagram_followers'])! > 0)
          SocialMediaButton.instagram(
            onTap: () => launchUrl(Uri.parse(influencer['instagram_link'])),
            size: 30,
            color: Colors.purple,
          ),

        // LinkedIn Icon
        if (influencer['linkedin_link'] != null &&
            influencer['linkedin_link'].toString().isNotEmpty &&
            influencer['linkedin_followers'] != null &&
            influencer['linkedin_followers'] != "N/A" &&
            int.tryParse(influencer['linkedin_followers'])! > 0)
          SocialMediaButton.linkedin(
            onTap: () => launchUrl(Uri.parse(influencer['linkedin_link'])),
            size: 30,
            color: Colors.blue,
          ),

        // YouTube Icon
        if (influencer['youtube_link'] != null &&
            influencer['youtube_link'].toString().isNotEmpty &&
            influencer['youtube_followers'] != null &&
            influencer['youtube_followers'] != "N/A" &&
            int.tryParse(influencer['youtube_followers'])! > 0)
          SocialMediaButton.youtube(
            onTap: () => launchUrl(Uri.parse(influencer['youtube_link'])),
            size: 30,
            color: Colors.red,
          ),

        // Twitter Icon
        if (influencer['twitter_link'] != null &&
            influencer['twitter_link'].toString().isNotEmpty &&
            influencer['twitter_followers'] != null &&
            influencer['twitter_followers'] != "N/A" &&
            int.tryParse(influencer['twitter_followers'])! > 0)
          SocialMediaButton.twitter(
            onTap: () => launchUrl(Uri.parse(influencer['twitter_link'])),
            size: 30,
            color: Colors.blue,
          ),
      ],
    );
  }*/
 /* Widget _buildSocialIcons(String? fbUrl, String? instaUrl) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (fbUrl != null && fbUrl.isNotEmpty)
          IconButton(icon: const Icon(Icons.facebook, color: Colors.blue, size: 30), onPressed: () => launchUrl(Uri.parse(fbUrl))),
        if (instaUrl != null && instaUrl.isNotEmpty)
          SocialMediaButton.instagram(onTap: () => launchUrl(Uri.parse(instaUrl)), size: 30, color: Colors.purple),
      ],
    );
  }*/

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }
}