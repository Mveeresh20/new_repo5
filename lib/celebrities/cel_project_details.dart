/*import 'package:flutter/material.dart';
import 'package:tngtong/celebrities/myProjectScreen.dart';
import 'package:tngtong/celebrities/nav_bar.dart';
import 'package:tngtong/config.dart';

class CelProjectDetails extends StatefulWidget {
  const CelProjectDetails({super.key});

  @override
  State<CelProjectDetails> createState() => _CelProjectDetailsState();
}

class _CelProjectDetailsState extends State<CelProjectDetails> {

  final List<Map<String, dynamic>> projectDetails = [
    {
      'title': 'E-commerce App',
      'brand': 'Amazon',
      'postType': 'Website Development',
      'dueDate': '2025-02-10',
      'status': 'Completed',
      'engagement': 'High',
      'paymentStatus': 'Paid',
      'actionRequired': 'None'
    },
    {
      'title': 'Social Media Platform',
      'brand': 'Facebook',
      'postType': 'App Development',
      'dueDate': '2025-03-01',
      'status': 'Ongoing',
      'engagement': 'Medium',
      'paymentStatus': 'Pending',
      'actionRequired': 'Code Review'
    },
    {
      'title': 'School Management System',
      'brand': 'Google',
      'postType': 'ERP System',
      'dueDate': '2025-03-15',
      'status': 'Pending',
      'engagement': 'Low',
      'paymentStatus': 'Unpaid',
      'actionRequired': 'Client Approval'
    }
  ];
  bool _isNavBarOpen = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
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
                        Colors.purple.shade500,
                        Colors.purple.shade500
                      ], begin: Alignment.centerLeft, end: Alignment.bottomRight),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        
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
            
                Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: projects.map((project) {
            return _buildProjectCard(project);
          }).toList(),
        ),
      ),
              ],
            ),
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
      )),
    );
  }
  Widget _buildProjectCard(Map<String, dynamic> project) {
  String title = project['title'];
  String status = project['status'];
  String date = project['date'];

  
  Map<String, String>? details;
  for (var detailMap in projectDetails) {
    if (detailMap['title'] == title) {
      details = {
        'brand': detailMap['brand'],
        'postType': detailMap['postType'],
        'dueDate': detailMap['dueDate'],
        'engagement': detailMap['engagement'],
        'paymentStatus': detailMap['paymentStatus'],
        'actionRequired': detailMap['actionRequired'],
      };
      break; 
    }
  }

  if (details == null) return SizedBox(); // Skip if no details found

  return Card(
    elevation: 4,
    margin: EdgeInsets.only(bottom: 16.0),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              _getStatusIcon(status),
            ],
          ),
          SizedBox(height: 4),
          Text(
            "Requested Date: $date",
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 8),
          Text(
            "Status: ${status.toUpperCase()}",
            style: TextStyle(fontWeight: FontWeight.bold, color: _getStatusColor(status)),
          ),
          Divider(),

          // Detailed Information
          _buildDetailRow("Brand", details['brand']!),
          _buildDetailRow("Post Type", details['postType']!),
          _buildDetailRow("Due Date", details['dueDate']!),
          _buildDetailRow("Engagement", details['engagement']!),
          _buildDetailRow("Payment Status", details['paymentStatus']!),
          _buildDetailRow("Action Required", details['actionRequired']!),
        ],
      ),
    ),
  );
}
  
 
  Widget _getStatusIcon(String status) {
    IconData icon;
    Color color;

    switch (status.toLowerCase()) {
      case 'completed':
        icon = Icons.check_circle;
        color = Colors.green;
        break;
      case 'ongoing':
        icon = Icons.loop;
        color = Colors.orange;
        break;
      case 'pending':
        icon = Icons.hourglass_empty;
        color = Colors.red;
        break;
      default:
        icon = Icons.help_outline;
        color = Colors.grey;
    }

    return Icon(icon, color: color);
  }

  
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'ongoing':
        return Colors.orange;
      case 'pending':
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
          Text(value),
        ],
      ),
    );
  }
}*/

