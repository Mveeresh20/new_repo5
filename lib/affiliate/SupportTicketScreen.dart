/*import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tngtong/api_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tngtong/config.dart';

class SupportTicketScreen extends StatefulWidget {
  const SupportTicketScreen({Key? key}) : super(key: key);

  @override
  _SupportTicketScreenState createState() => _SupportTicketScreenState();
}

class _SupportTicketScreenState extends State<SupportTicketScreen> {
  SharedPreferences? prefs;
  String? loginEmail;
  String? userId;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _problemController = TextEditingController();

  String? _selectedQueryType;
  final List<String> _queryTypes = [
    'Account Issue',
    'Payment Problem',
    'Technical Issue',
    'General Inquiry',
    'Other'
  ];
  final String _apiUrl = '${Config.apiDomain}${Config.create_support_ticket}';

  //final String _apiUrl = "https://demo.infoskaters.com/api/create_support_ticket.php";

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
  }

  Future<void> fetchUserId() async {
    String? id = await ApiService.getAffilaterId(loginEmail);
    setState(() {
      userId = id;
    });
    fetchUserData(userId!);
  }

  Future<void> fetchUserData(String u_id) async {
    final String getasicDetailsApi = "https://demo.infoskaters.com/api/get_affiliater_basic.php?u_id=$u_id";

    try {
      final response = await http.get(Uri.parse(getasicDetailsApi));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        print(data);
        if (data.containsKey("error")) {
          print("Error: ${data['error']}");
          return;
        }

        setState(() {
          _nameController.text = data['a_name'] ?? '';
          _emailController.text = data['a_email'] ?? '';
          _mobileController.text = data['a_mob'] ?? '';
        });
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching data: $error");
    }
  }

  Future<void> _submitTicket() async {
    if (_selectedQueryType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a query type')),
      );
      return;
    }

    if (_problemController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please describe your problem')),
      );
      return;
    }

    try {
      var response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'user_id': userId,
          'name': _nameController.text,
          'email': _emailController.text,
          'mobile': _mobileController.text,
          'query_type': _selectedQueryType,
          'problem': _problemController.text,
          'userType':"affilater"
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['success'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Success: ${responseData['message']}')),
          );
          // Clear form after successful submission
          _problemController.clear();
          setState(() {
            _selectedQueryType = null;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${responseData['message']}')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to submit ticket!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade500,
        title: const Text('Support Ticket'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              _buildSection(
                title: "Contact Information",
                child: Column(
                  children: [
                    _buildTextField(_nameController, "Name", Icons.person, enabled: false),
                    _buildTextField(_emailController, "Email", Icons.email, enabled: false),
                    _buildTextField(_mobileController, "Mobile Number", Icons.phone, enabled: false),
                  ],
                ),
              ),
              _buildSection(
                title: "Ticket Details",
                child: Column(
                  children: [
                    _buildDropdown<String>(
                      "Query Type",
                      _queryTypes,
                      _selectedQueryType,
                          (value) {
                        setState(() => _selectedQueryType = value);
                      },
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _problemController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: 'Describe your problem',
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitTicket,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple.shade500,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Submit Ticket',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller,
      String label,
      IconData icon, {
        bool enabled = true,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: controller,
        enabled: enabled,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown<T>(
      String label,
      List<T> items,
      T? selectedItem,
      ValueChanged<T?> onChanged,
      ) {
    return DropdownButtonFormField<T>(
      value: selectedItem,
      items: items.map((T item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(item.toString()),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) => value == null ? 'Please select a query type' : null,
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tngtong/api_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tngtong/config.dart';
import 'package:intl/intl.dart';

class SupportTicketScreen extends StatefulWidget {
  const SupportTicketScreen({Key? key}) : super(key: key);

  @override
  _SupportTicketScreenState createState() => _SupportTicketScreenState();
}

class _SupportTicketScreenState extends State<SupportTicketScreen> {
  SharedPreferences? prefs;
  String? loginEmail;
  String? userId;
  bool hasPendingTicket = false;
  List<Map<String, dynamic>> tickets = [];
  bool isLoading = true;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _problemController = TextEditingController();

  String? _selectedQueryType;
  final List<String> _queryTypes = [
    'Account Issue',
    'Payment Problem',
    'Technical Issue',
    'General Inquiry',
    'Other'
  ];
  final String _createTicketUrl = '${Config.apiDomain}${Config.create_support_ticket}';
  final String _fetchTicketsUrl = '${Config.apiDomain}${Config.fetch_support_tickets}';

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
    await fetchTickets();
  }

  Future<void> fetchUserId() async {
    String? id = await ApiService.getAffilaterId(loginEmail);
    setState(() {
      userId = id;
    });
    await fetchUserData(userId!);
  }

  Future<void> fetchUserData(String u_id) async {
    final String getasicDetailsApi = "https://demo.infoskaters.com/api/get_affiliater_basic.php?u_id=$u_id";

    try {
      final response = await http.get(Uri.parse(getasicDetailsApi));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data.containsKey("error")) {
          print("Error: ${data['error']}");
          return;
        }

        setState(() {
          _nameController.text = data['a_name'] ?? '';
          _emailController.text = data['a_email'] ?? '';
          _mobileController.text = data['a_mob'] ?? '';
        });
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching data: $error");
    }
  }

  Future<void> fetchTickets() async {
    if (userId == null) return;

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(_fetchTicketsUrl),
        body: {
          'user_id': userId,
          'user_type': 'affilater',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['success'] == true) {
          List<dynamic> ticketList = responseData['tickets'];
          setState(() {
            tickets = ticketList.map((t) => Map<String, dynamic>.from(t)).toList();
            hasPendingTicket = tickets.any((ticket) => ticket['status'] == 'pending');
          });
        }
      }
    } catch (e) {
      print("Error fetching tickets: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _submitTicket() async {
    if (hasPendingTicket) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You already have a pending ticket. Please wait for resolution.')),
      );
      return;
    }

    if (_selectedQueryType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a query type')),
      );
      return;
    }

    if (_problemController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please describe your problem')),
      );
      return;
    }

    try {
      var response = await http.post(
        Uri.parse(_createTicketUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'user_id': userId,
          'name': _nameController.text,
          'email': _emailController.text,
          'mobile': _mobileController.text,
          'query_type': _selectedQueryType,
          'problem': _problemController.text,
          'userType': "affilater"
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['success'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Success: ${responseData['message']}')),
          );
          _problemController.clear();
          setState(() {
            _selectedQueryType = null;
          });
          await fetchTickets(); // Refresh ticket list
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${responseData['message']}')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to submit ticket!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Widget _buildTicketList() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (tickets.isEmpty) {
      return const Center(
        child: Text('No tickets found', style: TextStyle(fontSize: 16)),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tickets.length,
      itemBuilder: (context, index) {
        final ticket = tickets[index];
        return _buildTicketCard(ticket);
      },
    );
  }

  Widget _buildTicketCard(Map<String, dynamic> ticket) {
    Color statusColor = ticket['status'] == 'pending' ? Colors.orange : Colors.green;
    String formattedDate = DateFormat('dd MMM yyyy - hh:mm a').format(
      DateTime.parse(ticket['created_at']),
    );

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ticket['query_type'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    ticket['status'].toString().toUpperCase(),
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              ticket['problem'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              formattedDate,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade500,
        title: const Text('Support',style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (hasPendingTicket)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.orange.shade700),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'You have a pending ticket. Please wait for resolution before creating a new one.',
                          style: TextStyle(
                            color: Colors.orange.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 20),
              const Text(
                'Previous Tickets',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              _buildTicketList(),
              const SizedBox(height: 20),
              const Text(
                'Create New Ticket',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
             /* _buildSection(
                title: "Contact Information",
                child: Column(
                  children: [
                    _buildTextField(_nameController, "Name", Icons.person, enabled: false),
                    _buildTextField(_emailController, "Email", Icons.email, enabled: false),
                    _buildTextField(_mobileController, "Mobile Number", Icons.phone, enabled: false),
                  ],
                ),
              ),*/
              _buildSection(
                title: "Ticket Details",
                child: Column(
                  children: [
                    _buildDropdown<String>(
                      "Query Type",
                      _queryTypes,
                      _selectedQueryType,
                          (value) {
                        setState(() => _selectedQueryType = value);
                      },
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _problemController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: 'Describe your problem',
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: hasPendingTicket ? null : _submitTicket,
                style: ElevatedButton.styleFrom(
                  backgroundColor: hasPendingTicket ? Colors.grey : Colors.purple.shade500,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Submit Ticket',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller,
      String label,
      IconData icon, {
        bool enabled = true,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: controller,
        enabled: enabled,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown<T>(
      String label,
      List<T> items,
      T? selectedItem,
      ValueChanged<T?> onChanged,
      ) {
    return DropdownButtonFormField<T>(
      value: selectedItem,
      items: items.map((T item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(item.toString()),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) => value == null ? 'Please select a query type' : null,
    );
  }
}