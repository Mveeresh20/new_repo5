import 'package:flutter/material.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({Key? key}) : super(key: key);

  @override
  _MyBookingsScreenState createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  String selectedStatus = 'all';

  final List<Map<String, dynamic>> bookings = [
    {'id': 1, 'name': 'Event 1', 'status': 'pending', 'date': '2024-02-10'},
    {'id': 2, 'name': 'Event 2', 'status': 'completed', 'date': '2024-01-25'},
    {'id': 3, 'name': 'Event 3', 'status': 'canceled', 'date': '2024-02-05'},
    {'id': 4, 'name': 'Event 4', 'status': 'pending', 'date': '2024-02-15'},
    {'id': 5, 'name': 'Event 5', 'status': 'completed', 'date': '2024-02-02'},
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredBookings = selectedStatus == 'all'
        ? bookings
        : bookings.where((b) => b['status'] == selectedStatus).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xffFF04AB), Color(0xffAE26CD)],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _statusButton('all', 'All'),
                _statusButton('pending', 'Pending'),
                _statusButton('canceled', 'Canceled'),
                _statusButton('completed', 'Completed'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredBookings.length,
              itemBuilder: (context, index) {
                final booking = filteredBookings[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(booking['name']),
                    subtitle: Text('Date: ${booking['date']}'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingDetailsScreen(booking: booking),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text('View Details'),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusButton(String status, String text) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedStatus = status;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: selectedStatus == status ? Colors.blue : Colors.grey,
      ),
      child: Text(text),
    );
  }
}

class BookingDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> booking;

  const BookingDetailsScreen({Key? key, required this.booking}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(booking['name']),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xffFF04AB), Color(0xffAE26CD)],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Event: ${booking['name']}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Date: ${booking['date']}'),
            const SizedBox(height: 10),
            Text('Status: ${booking['status'].toUpperCase()}'),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text('Back'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
