/*import 'package:flutter/material.dart';

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
*/
/*
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tngtong/config.dart'; // Replace with your config file
import 'package:tngtong/api_service.dart'; // Replace with your config file

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({Key? key}) : super(key: key);

  @override
  _MyBookingsScreenState createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  String selectedStatus = 'all';
  List<Map<String, dynamic>> bookings = [];
  bool isLoading = true;
  SharedPreferences? prefs;
  String? loginEmail;
  String? userId;

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
    String? id = await ApiService.getUserId(loginEmail);
    setState(() {
      userId = id;
    });
    fetchBookings(); // Fetch bookings after getting userId
  }

  Future<void> fetchBookings() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse('${Config.apiDomain}${Config.get_bookings}$userId'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          setState(() {
            bookings = List<Map<String, dynamic>>.from(data['bookings']);
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['message'])),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load bookings')),
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
    List<Map<String, dynamic>> filteredBookings = selectedStatus == 'all'
        ? bookings
        : bookings.where((b) => b['b_status'] == selectedStatus).toList();

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
                _statusButton('ongoing', 'Ongoing'),
                _statusButton('canceled', 'Canceled'),
                _statusButton('completed', 'Completed'),
              ],
            ),
          ),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
            child: RefreshIndicator(
              onRefresh: fetchBookings,
              child: ListView.builder(
                itemCount: filteredBookings.length,
                itemBuilder: (context, index) {
                  final booking = filteredBookings[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Text(
                        booking['b_desc'],
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Date: ${booking['b_date']}'),
                          Text('Status: ${booking['b_status'].toUpperCase()}'),
                        ],
                      ),
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
        title: Text(booking['b_desc']),
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
              'Description: ${booking['b_desc']}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Date: ${booking['b_date']}'),
            const SizedBox(height: 10),
            Text('Status: ${booking['b_status'].toUpperCase()}'),
            const SizedBox(height: 10),
            Text('Price: ₹${booking['b_price']}'),
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
}*/
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tngtong/config.dart'; // Replace with your config file
import 'package:tngtong/api_service.dart'; // Replace with your config file
import 'package:video_player/video_player.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path; // Use an alias

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({Key? key}) : super(key: key);

  @override
  _MyBookingsScreenState createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  String selectedStatus = 'all';
  List<Map<String, dynamic>> bookings = [];
  bool isLoading = true;
  SharedPreferences? prefs;
  String? loginEmail;
  String? userId;

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
    String? id = await ApiService.getUserId(loginEmail);
    setState(() {
      userId = id;
    });
    fetchBookings(); // Fetch bookings after getting userId
  }

  Future<void> fetchBookings() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse('${Config.apiDomain}${Config.get_bookings}$userId'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          setState(() {
            bookings = List<Map<String, dynamic>>.from(data['bookings']);
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['message'])),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load bookings')),
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
    List<Map<String, dynamic>> filteredBookings = selectedStatus == 'all'
        ? bookings
        : bookings.where((b) => b['b_status'] == selectedStatus).toList();

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        title: const Text('My Bookings', style: TextStyle(color: Colors.white),),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 207, 9, 204),
                  Color(0xffAE26CD)
                ],
            ),
              
            ),
        ),
      ),
      body: Container(
         decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 207, 9, 204),
                  Color(0xffAE26CD)
                ],
            ),
              
            ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _statusButton('all', 'All', Icons.all_inclusive),
                    _statusButton('pending', 'Pending', Icons.pending),
                    _statusButton('ongoing', 'Ongoing', Icons.timelapse),
                    _statusButton('canceled', 'Canceled', Icons.cancel),
                    _statusButton('completed', 'Completed', Icons.check_circle),
                  ],
                ),
              ),
            ),
            isLoading
                ? const Center(child: CircularProgressIndicator(color: Colors.white))
                : Expanded(
              child: RefreshIndicator(
                onRefresh: fetchBookings,
                child: ListView.builder(
                  itemCount: filteredBookings.length,
                  itemBuilder: (context, index) {
                    final booking = filteredBookings[index];
                    return _buildBookingCard(booking);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusButton(String status, String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton.icon(
        onPressed: () {
          setState(() {
            selectedStatus = status;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: selectedStatus == status ? Colors.white : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        icon: Icon(icon, color: selectedStatus == status ? Colors.purple : Colors.white),
        label: Text(
          text,
          style: TextStyle(
            color: selectedStatus == status ? Colors.purple : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildBookingCard(Map<String, dynamic> booking) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookingDetailsScreen(booking: booking),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                booking['c_Name'], // Influencer Name
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(
                    'Date: ${booking['b_date']}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.attach_money, size: 16, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(
                    'Price: ₹${booking['b_price']}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.star, size: 16, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(
                    'Status: ${booking['b_status'].toUpperCase()}',
                    style: TextStyle(
                      fontSize: 14,
                      color: _getStatusColor(booking['b_status']),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'ongoing':
        return Colors.blue;
      case 'canceled':
        return Colors.red;
      case 'completed':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}

/*class BookingDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> booking;

  const BookingDetailsScreen({Key? key, required this.booking}) : super(key: key);

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  VideoPlayerController? _videoPlayerController;
  bool _isLoadingVideo = true;

  @override
  void initState() {
    super.initState();
    // Initialize video player if project_url is available
    if (widget.booking['project_url'] != null) {
      _initializeVideoPlayer("${Config.apiDomain}/${widget.booking['project_url']}");
    } else {
      _isLoadingVideo = false;
    }
  }

  void _initializeVideoPlayer(String videoUrl) {
    _videoPlayerController = VideoPlayerController.network(videoUrl)
      ..initialize().then((_) {
        setState(() {
          _isLoadingVideo = false;
        });
      });
  }

  // Download video function
  Future<void> _downloadVideo() async {
    if (widget.booking['project_url'] == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No video available to download')),
      );
      return;
    }

    // Request storage permission
    final status = await Permission.storage.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Storage permission denied')),
      );
      return;
    }

    final dio = Dio();

    // Get the Downloads directory
    final dir = await getDownloadsDirectory();
    if (dir == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not access Downloads directory')),
      );
      return;
    }

    // Define the save path
    final videoUrl = "${Config.apiDomain}/${widget.booking['project_url']}";
    final savePath = '${dir.path}/${path.basename(videoUrl)}'; // Use path.basename

    try {
      // Download the video
      await dio.download(videoUrl, savePath);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Video downloaded to $savePath')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to download video: $e')),
      );
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.booking['c_Name']), // Influencer Name
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xffFF04AB), Color(0xffAE26CD)],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project Details Card
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Project Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple[800],
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildDetailRow('Influencer', widget.booking['c_Name']),
                    _buildDetailRow('Requirement', widget.booking['b_desc']),
                    _buildDetailRow('Date', widget.booking['b_date']),
                    _buildDetailRow('Status', widget.booking['b_status'].toUpperCase()),
                    _buildDetailRow('Price', '₹${widget.booking['b_price']}'),
                    _buildDetailRow('Payment Mode', widget.booking['payment_mode']),
                    _buildDetailRow('Payment Status', widget.booking['payment_status']),
                    _buildDetailRow('Deadline Date', widget.booking['deadline_date']),
                    _buildDetailRow('Status Date', widget.booking['status_date']),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Video Section Card
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Project Video',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple[800],
                      ),
                    ),
                    const SizedBox(height: 10),
                    //if (_isLoadingVideo)
                     // const Center(child: CircularProgressIndicator())
                    //else
                    if (widget.booking['project_url'] != null)
                      Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 16 / 9,
                            child: VideoPlayer(_videoPlayerController!),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(
                                  _videoPlayerController!.value.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (_videoPlayerController!.value.isPlaying) {
                                      _videoPlayerController!.pause();
                                    } else {
                                      _videoPlayerController!.play();
                                    }
                                  });
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.download),
                                onPressed: _downloadVideo,
                              ),
                            ],
                          ),
                        ],
                      )
                    else
                      const Text(
                        'Submission Not Completed',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Back Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: const Text(
                  'Back',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              value ?? 'N/A',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}*/
class BookingDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> booking;

  const BookingDetailsScreen({Key? key, required this.booking}) : super(key: key);

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  VideoPlayerController? _videoPlayerController;
  bool _isLoadingVideo = true;

  @override
  void initState() {
    super.initState();
    // Initialize video player if project_url is available
    if (widget.booking['project_url'] != null) {
      _initializeVideoPlayer("${Config.apiDomain}/${widget.booking['project_url']}");
    } else {
      _isLoadingVideo = false;
    }
  }

  void _initializeVideoPlayer(String videoUrl) {
    _videoPlayerController = VideoPlayerController.network(videoUrl)
      ..initialize().then((_) {
        setState(() {
          _isLoadingVideo = false;
        });
      });
  }

  // Download video function
  Future<void> _downloadVideo() async {
    if (widget.booking['project_url'] == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No video available to download')),
      );
      return;
    }

    // Check and request storage permission
    final status = await Permission.storage.request();
    if (!status.isGranted) {
      // Show a dialog to explain why the permission is needed
      if (await Permission.storage.isPermanentlyDenied) {
        // Open app settings if permission is permanently denied
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Permission Required'),
            content: const Text(
              'Storage permission is required to download videos. '
                  'Please enable it in the app settings.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await openAppSettings(); // Open app settings
                },
                child: const Text('Open Settings'),
              ),
            ],
          ),
        );
      } else {
        // Request permission again
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Storage permission denied')),
        );
      }
      return;
    }

    final dio = Dio();

    // Get the Downloads directory
    final dir = await getDownloadsDirectory();
    if (dir == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not access Downloads directory')),
      );
      return;
    }

    // Define the save path
    final videoUrl = "${Config.apiDomain}/${widget.booking['project_url']}";
    final savePath = '${dir.path}/${path.basename(videoUrl)}';

    try {
      // Download the video
      await dio.download(videoUrl, savePath);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Video downloaded to $savePath')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to download video: $e')),
      );
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.booking['c_Name']), // Influencer Name
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xffFF04AB), Color(0xffAE26CD)],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project Details Card
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Project Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple[800],
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildDetailRow('Influencer', widget.booking['c_Name']),
                    _buildDetailRow('Requirement', widget.booking['b_desc']),
                    _buildDetailRow('Date', widget.booking['b_date']),
                    _buildDetailRow('Status', widget.booking['b_status'].toUpperCase()),
                    _buildDetailRow('Price', '₹${widget.booking['b_price']}'),
                    _buildDetailRow('Payment Mode', widget.booking['payment_mode']),
                    _buildDetailRow('Payment Status', widget.booking['payment_status']),
                    _buildDetailRow('Deadline Date', widget.booking['deadline_date']),
                    _buildDetailRow('Status Date', widget.booking['status_date']),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Video Section Card
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Project Video',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple[800],
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (_isLoadingVideo)
                      const Center(child: CircularProgressIndicator())
                    else if (widget.booking['project_url'] != null)
                      Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 16 / 9,
                            child: VideoPlayer(_videoPlayerController!),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(
                                  _videoPlayerController!.value.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (_videoPlayerController!.value.isPlaying) {
                                      _videoPlayerController!.pause();
                                    } else {
                                      _videoPlayerController!.play();
                                    }
                                  });
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.download),
                                onPressed: _downloadVideo,
                              ),
                            ],
                          ),
                        ],
                      )
                    else
                      const Text(
                        'Submission Not Completed',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Back Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: const Text(
                  'Back',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              value ?? 'N/A',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}