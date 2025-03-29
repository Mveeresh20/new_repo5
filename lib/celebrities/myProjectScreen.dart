/*import 'package:flutter/material.dart';

class MyProjectsScreen extends StatefulWidget {
  const MyProjectsScreen({Key? key}) : super(key: key);

  @override
  _MyProjectsScreenState createState() => _MyProjectsScreenState();
}

class _MyProjectsScreenState extends State<MyProjectsScreen> {
  String selectedFilter = 'all';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Projects'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffFF04AB),
                Color(0xffAE26CD),
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
                      Color(0xffFF04AB),
                      Color(0xffAE26CD),
                    ],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() => selectedFilter = 'completed');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffF4A261),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Completed'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() => selectedFilter = 'pending');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffE76F51),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Pending'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() => selectedFilter = 'ongoing');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff2A9D8F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Ongoing'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Project List',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  final project = projects[index];
                  if (selectedFilter != 'all' && project['status'] != selectedFilter) {
                    return const SizedBox.shrink();
                  }
                  return ListTile(
                    leading: Icon(
                      project['status'] == 'completed'
                          ? Icons.check_circle
                          : project['status'] == 'pending'
                          ? Icons.hourglass_empty
                          : Icons.loop,
                      color: project['status'] == 'completed'
                          ? Colors.green
                          : project['status'] == 'pending'
                          ? Colors.orange
                          : Colors.blue,
                    ),
                    title: Text(project['title']),
                    subtitle: Text(project['date']),
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

// Demo JSON data for projects
List<Map<String, dynamic>> projects = [
  {
    'title': 'E-commerce App',
    'status': 'completed',
    'date': '2025-02-01',
  },
  {
    'title': 'Social Media Platform',
    'status': 'ongoing',
    'date': '2025-01-25',
  },
  {
    'title': 'School Management System',
    'status': 'pending',
    'date': '2025-01-20',
  },
  {
    'title': 'Healthcare Portal',
    'status': 'completed',
    'date': '2025-01-15',
  },
];
*/



///////////////////////veeresh code///////////////////////////////////////
/*import 'package:flutter/material.dart';
import 'package:tngtong/celebrities/nav_bar.dart';
import 'package:tngtong/config.dart';

class MyProjectsScreen extends StatefulWidget {
  const MyProjectsScreen({Key? key}) : super(key: key);

  @override
  _MyProjectsScreenState createState() => _MyProjectsScreenState();
}

class _MyProjectsScreenState extends State<MyProjectsScreen> {
  bool _isNavBarOpen = false;
  String selectedFilter = 'all';

  // Keep the expandedState here
  Map<String, bool> expandedState = {
    'Pending': false,
    'Ongoing': false,
    'Completed': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: SafeArea(
                child: Stack(children: [
                  Column(children: [
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
                          gradient: LinearGradient(colors: [
                            Colors.purple.shade500,
                            // Light Rose Pink
                            Colors.purple.shade500, // Medium Rose Pink
                            Colors.purple.shade500
                          ], begin: Alignment.centerLeft, end: Alignment.bottomRight),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
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
                    SizedBox(height: 0),
                    Padding(
                      padding: EdgeInsets.only(left: 16, top: 0, right: 0, bottom: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: Text(
                              "My Projects",
                              style: TextStyle(fontSize: 25),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/task_managing.png',
                            height: 140,
                            width: 150,
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Manage your Projects",
                                    style: TextStyle(
                                        fontSize: 15, fontWeight: FontWeight.bold)),
                                SizedBox(height: 10),
                                Text(
                                  "Easily manage and organize all your projects. Track your project progress, and stay on top of your tasks",
                                  style: TextStyle(),
                                  textAlign: TextAlign.start,
                                  softWrap: true,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          buildProjectSection(
                              'Pending',
                              Icons.hourglass_empty,
                              Colors.purple,
                              projects.where((p) => p['status'] == 'pending').toList(),
                              expandedState),
                          buildProjectSection(
                              'Ongoing',
                              Icons.autorenew,
                              Colors.purple,
                              projects.where((p) => p['status'] == 'ongoing').toList(),
                              expandedState),
                          buildProjectSection(
                              'Completed',
                              Icons.check_circle,
                              Colors.purple,
                              projects.where((p) => p['status'] == 'completed').toList(),
                              expandedState),
                        ],
                      ),
                    ),
                  ]),
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
                ]))));
  }


  Widget buildProjectSection(
      String title,
      IconData icon,
      Color color,
      List<Map<String, dynamic>> filteredProjects,
      Map<String, bool> expandedState) {
    bool isExpanded = expandedState[title] ?? false;

    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon, color: color),
                    SizedBox(width: 10),
                    Text(title,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: color)),
                  ],
                ),
                IconButton(
                  icon: Icon(isExpanded ? Icons.expand_less : Icons.expand_more,
                      color: color),
                  onPressed: () {
                    setState(() {
                      expandedState[title] = !isExpanded;
                    });
                  },
                )
              ],
            ),
            Text("List of my projects completed",
                style: TextStyle(color: Colors.black54)),
            Divider(),
            if (isExpanded)
              Column(
                children: filteredProjects
                    .map((project) => ListTile(
                  leading: Icon(icon, color: color),
                  title: Text(project['title']),
                ))
                    .toList(),
              ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    expandedState[title] = !isExpanded;
                  });
                },
                style: ElevatedButton.styleFrom(backgroundColor: color),
                child: Text(
                  isExpanded ? 'View Less' : 'View More',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


List<Map<String, dynamic>> projects = [
  {'title': 'E-commerce App', 'status': 'completed', 'date': '2025-02-01'},
  {'title': 'Social Media Platform', 'status': 'ongoing', 'date': '2025-01-25'},
  {
    'title': 'School Management System',
    'status': 'pending',
    'date': '2025-01-20'
  },
  {'title': 'Healthcare Portal', 'status': 'completed', 'date': '2025-01-15'},
];
*/

import 'package:flutter/material.dart';
import 'package:tngtong/celebrities/nav_bar.dart';
import 'package:tngtong/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tngtong/api_service.dart';
import 'package:tngtong/celebrities/updateProjectStatus.dart';
class MyProjectsScreen extends StatefulWidget {
  const MyProjectsScreen({Key? key}) : super(key: key);

  @override
  _MyProjectsScreenState createState() => _MyProjectsScreenState();
}

class _MyProjectsScreenState extends State<MyProjectsScreen> {
  bool _isNavBarOpen = false;
  String selectedFilter = 'all';
  List<Map<String, dynamic>> projects = [];
  bool isLoading = true;
  SharedPreferences? prefs; // SharedPreferences instance
  String? loginEmail; // To store the retrieved email
  String? userId;
  // Keep the expandedState here
  Map<String, bool> expandedState = {
    'Pending': false,
    'Ongoing': false,
    'Completed': false,
  };

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
    print('Login Email: $loginEmail');
    fetchUserId();

  }
  Future<void> fetchUserId() async {
    String? id = await ApiService.getCelId(loginEmail);
    setState(() {
      userId = id;
    });
    fetchProjects();
    print('Login id------: $userId');

  }
  Future<void> fetchProjects() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Replace with the logged-in influencer's ID
     // final influencerId = 2; // Fetch this from SharedPreferences or API
      final response = await http.get(
        Uri.parse('${Config.apiDomain}${Config.get_influencer_projects}$userId'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          setState(() {
            projects = List<Map<String, dynamic>>.from(data['projects']);
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['message'])),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load projects')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  // App Bar Section
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
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
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
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
                  const SizedBox(height: 0),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 0, right: 0, bottom: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(0),
                          child: Text(
                            "My Projects",
                            style: TextStyle(fontSize: 25),

                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/task_managing.png',
                          height: 140,
                          width: 150,
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                "Manage your Projects",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "Easily manage and organize all your projects. Track your project progress, and stay on top of your tasks",
                                style: TextStyle(),
                                textAlign: TextAlign.start,
                                softWrap: true,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        buildProjectSection(
                          'Pending',
                          Icons.hourglass_empty,
                          Colors.purple,
                         // projects.where((p) => p['b_status'] == 'pending').toList(),
                          projects.where((p) => p['b_status']?.toLowerCase() == 'pending'.toLowerCase()).toList(),
                          expandedState,
                        ),
                        buildProjectSection(
                          'Ongoing',
                          Icons.autorenew,
                          Colors.purple,
                          projects.where((p) => p['b_status']?.toLowerCase() == 'ongoing'.toLowerCase()).toList(),
                          expandedState,
                        ),
                        buildProjectSection(
                          'Completed',
                          Icons.check_circle,
                          Colors.purple,
                         // projects.where((p) => p['b_status'] == 'completed').toList(),
                          projects.where((p) => p['b_status']?.toLowerCase() == 'completed'.toLowerCase()).toList(),
                          expandedState,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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


  Widget buildProjectSection(
      String title,
      IconData icon,
      Color color,
      List<Map<String, dynamic>> filteredProjects,
      Map<String, bool> expandedState,
      ) {
    bool isExpanded = expandedState[title] ?? false;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon, color: color),
                    const SizedBox(width: 10),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: color,
                  ),
                  onPressed: () {
                    setState(() {
                      expandedState[title] = !isExpanded;
                    });
                  },
                ),
              ],
            ),
            const Text(
              "List of my projects",
              style: TextStyle(color: Colors.black54),
            ),
            const Divider(),
            if (isExpanded)
              Column(
                children: filteredProjects
                    .map((project) => ListTile(
                  leading: Icon(icon, color: color),
                  title: Text(project['b_desc']),
                  subtitle: Text('User: ${project['user_name']}'),
                  onTap: () {
                    // Navigate to ProjectDetailsScreen with project data
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailProject(
                          projectData: project, // Use projectData instead of projectDetails
                        ),
                      ),
                    );
                  },
                ))
                    .toList(),
              ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    expandedState[title] = !isExpanded;
                  });
                },
                style: ElevatedButton.styleFrom(backgroundColor: color),
                child: Text(
                  isExpanded ? 'View Less' : 'View More',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  /*Widget buildProjectSection(
      String title,
      IconData icon,
      Color color,
      List<Map<String, dynamic>> filteredProjects,
      Map<String, bool> expandedState,
      ) {
    bool isExpanded = expandedState[title] ?? false;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon, color: color),
                    const SizedBox(width: 10),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: color,
                  ),
                  onPressed: () {
                    setState(() {
                      expandedState[title] = !isExpanded;
                    });
                  },
                ),
              ],
            ),
            const Text(
              "List of my projects",
              style: TextStyle(color: Colors.black54),
            ),
            const Divider(),
            if (isExpanded)
              Column(
                children: filteredProjects
                    .map((project) => ListTile(
                  leading: Icon(icon, color: color),
                  title: Text(project['b_desc']),
                  subtitle: Text('User: ${project['user_name']}'),
                ))
                    .toList(),
              ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    expandedState[title] = !isExpanded;
                  });
                },
                style: ElevatedButton.styleFrom(backgroundColor: color),
                child: Text(
                  isExpanded ? 'View Less' : 'View More',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }*/
}