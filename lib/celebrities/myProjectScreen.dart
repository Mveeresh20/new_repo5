import 'package:flutter/material.dart';

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
