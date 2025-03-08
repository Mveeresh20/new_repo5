import 'package:flutter/material.dart';
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
}
