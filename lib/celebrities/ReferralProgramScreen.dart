/*import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tngtong/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:tngtong/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ReferralProgramScreen extends StatefulWidget {
  const ReferralProgramScreen({Key? key}) : super(key: key);

  @override
  _ReferralProgramScreenState createState() => _ReferralProgramScreenState();
}

class _ReferralProgramScreenState extends State<ReferralProgramScreen> {
  String selectedFilter = 'all'; // Default filter is "all"
  String? ReferralCode;
  SharedPreferences? prefs; // SharedPreferences instance
  String? loginEmail; // To store the retrieved email
  String? userId;
  String? userType="celebrity";
  late List<Map<String, dynamic>> referrals;

  // Example referral data
 /* List<Map<String, dynamic>> referrals = [
    {'id': 1, 'name': 'John Doe', 'status': 'verified', 'referralDate': '2024-01-15'},
    {'id': 2, 'name': 'Jane Smith', 'status': 'pending kyc', 'referralDate': '2024-01-20'},
    {'id': 3, 'name': 'Samuel Green', 'status': 'verified', 'referralDate': '2024-02-05'},
    {'id': 4, 'name': 'Emily Brown', 'status': 'pending kyc', 'referralDate': '2024-02-10'},
  ];*/
  @override
  void initState() {
    super.initState();
    _initializePreferences();
  }
  Future<void> fetchUserId() async {
    String? id = await ApiService.getCelId(loginEmail);
    setState(() {
      userId = id;
    });
    _getMyRefCode();
    List<Map<String, dynamic>>  referrals1 = await ApiService.getReferralDetails(userId!, "celebrity");
    setState(() {
      referrals = referrals1;
    });
    print(referrals);
  }
  Future<void> _getMyRefCode() async {
    String? ReferralId = await ApiService.getMyReferralCode(userId,userType);
    setState(() {
      ReferralCode = ReferralId;
    });

  }
  Future<void> _initializePreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      loginEmail = prefs?.getString('loginEmail');
    });
    print('Login Email: $loginEmail');
    fetchUserId();

  }
  // Method to copy referral code to clipboard
  Future<void> _copyReferralCode(String code) async {
    await Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Referral code copied to clipboard!')),
    );
  }

  // Method to share referral code via message
  void _shareReferralCode(String code) {
    Share.share('Join me and start earning! My referral code is: $code');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Referral Program'),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Image
            Container(
              width: double.infinity, // Full width
              height: 180, // Standard YouTube thumbnail height
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage('assets/images/banner.png'), // Replace with your asset path
                  fit: BoxFit.cover, // Adjust image scaling
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Earn Through Referrals:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xffFF04AB),
                      Color(0xffAE26CD),
                    ],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Your Referral Code:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text(
                            ReferralCode!, // Replace this with the user's actual referral code
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            icon: const Icon(Icons.copy),
                            onPressed: () => _copyReferralCode(ReferralCode!),
                          ),
                          IconButton(
                            icon: const Icon(Icons.share),
                            onPressed: () => _shareReferralCode(ReferralCode!),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'My Referrals:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
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
                          setState(() => selectedFilter = 'all');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffF4A261),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('All'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() => selectedFilter = 'pending kyc');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffE76F51),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Pending KYC'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() => selectedFilter = 'verified');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff2A9D8F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Verified'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: referrals.length,
                itemBuilder: (context, index) {
                  final referral = referrals[index];
                  if (selectedFilter != 'all' && referral['status'] != selectedFilter) {
                    return const SizedBox.shrink();
                  }
                  return ListTile(
                    leading: Icon(
                      referral['status'] == 'verified'
                          ? Icons.check_circle
                          : Icons.hourglass_empty,
                      color: referral['status'] == 'verified'
                          ? Colors.green
                          : Colors.orange,
                    ),
                    title: Text(referral['name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Referral Date: ${referral['referralDate']}'),
                        Text('User Type: ${referral['userType']}'), // Add userType here
                      ],
                    ),
                    trailing: Text(referral['status']),
                  );
                 /* return ListTile(
                    leading: Icon(
                      referral['status'] == 'verified'
                          ? Icons.check_circle
                          : Icons.hourglass_empty,
                      color: referral['status'] == 'verified'
                          ? Colors.green
                          : Colors.orange,
                    ),
                    title: Text(referral['name']),
                    subtitle: Text('Referral Date: ${referral['referralDate']}'),
                    trailing: Text(referral['status']),
                  );*/
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tngtong/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReferralProgramScreen extends StatefulWidget {
  const ReferralProgramScreen({Key? key}) : super(key: key);

  @override
  _ReferralProgramScreenState createState() => _ReferralProgramScreenState();
}

class _ReferralProgramScreenState extends State<ReferralProgramScreen> {
  String selectedFilter = 'all';
  String? ReferralCode;
  SharedPreferences? prefs;
  String? loginEmail;
  String? userId;
  String? userType = "celebrity";
  late List<Map<String, dynamic>> referrals=[];
  final ScrollController _scrollController = ScrollController();
  bool _showBanner = true;

  @override
  void initState() {
    super.initState();
    _initializePreferences();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    if (_scrollController.offset > 100 && _showBanner) {
      setState(() => _showBanner = false);
    } else if (_scrollController.offset <= 100 && !_showBanner) {
      setState(() => _showBanner = true);
    }
  }

  Future<void> fetchUserId() async {
    String? id = await ApiService.getCelId(loginEmail);
    setState(() {
      userId = id;
    });
    _getMyRefCode();
    List<Map<String, dynamic>> referrals1 =
    await ApiService.getReferralDetails(userId!, "celebrity");
    setState(() {
      referrals = referrals1;
    });
  }

  Future<void> _getMyRefCode() async {
    String? ReferralId = await ApiService.getMyReferralCode(userId, userType);
    setState(() {
      ReferralCode = ReferralId;
    });
  }

  Future<void> _initializePreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      loginEmail = prefs?.getString('loginEmail');
    });
    fetchUserId();
  }

  Future<void> _copyReferralCode(String code) async {
    await Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Referral code copied to clipboard!')),
    );
  }

  void _shareReferralCode(String code) {
    Share.share('Join me and start earning! My referral code is: $code');
  }

  Widget _buildFilterButton(String filter, String text, Color activeColor) {
    final bool isActive = selectedFilter == filter;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: ElevatedButton(
          onPressed: () => setState(() => selectedFilter = filter),
          style: ElevatedButton.styleFrom(
            backgroundColor: isActive ? activeColor : Colors.grey[300],
            foregroundColor: isActive ? Colors.white : Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text('My Referrals',style: TextStyle(color: Colors.white),),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Image with animated visibility
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
                        height: 100,
                        width: 90,
                        child: Image.asset(
                          'assets/images/banner_icon.png',
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
                            "Refer & Earn!",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Refer business owners, influencers, and your loved ones to us—earn up to ₹300 per referral and help businesses and people grow together!",
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

/*            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: _showBanner ? 180 : 0,
              width: double.infinity,
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: AssetImage('assets/images/banner.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
*/
            if (_showBanner) ...[
              const SizedBox(height: 20),
              const Text(
                'Earn Through Referrals:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 207, 9, 204),
                  Color(0xffAE26CD)
                ],
            ),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
                  child: Column(
                    children: [
                      const Text(
                        'Your Referral Code:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              ReferralCode ?? 'Loading...',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 10),
                            IconButton(
                              icon: const Icon(Icons.copy),
                              onPressed: ReferralCode != null
                                  ? () => _copyReferralCode(ReferralCode!)
                                  : null,
                            ),
                            IconButton(
                              icon: const Icon(Icons.share),
                              onPressed: ReferralCode != null
                                  ? () => _shareReferralCode(ReferralCode!)
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],

            const Text(
              'My Referrals:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 207, 9, 204),
                  Color(0xffAE26CD)
                ],
            ),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    _buildFilterButton('all', 'All', const Color(0xffF4A261)),
                    _buildFilterButton(
                        'pending kyc', 'Pending KYC', const Color(0xffE76F51)),
                    _buildFilterButton(
                        'verified', 'Verified', const Color(0xff2A9D8F)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: referrals.length,
                itemBuilder: (context, index) {
                  final referral = referrals[index];
                  if (selectedFilter != 'all' && referral['status'] != selectedFilter) {
                    return const SizedBox.shrink();
                  }
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Icon(
                        referral['status'] == 'verified'
                            ? Icons.check_circle
                            : Icons.hourglass_empty,
                        color: referral['status'] == 'verified'
                            ? Colors.green
                            : Colors.orange,
                      ),
                      title: Text(
                        referral['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Referral Date: ${referral['referralDate']}'),
                          Text('User Type: ${referral['userType']}'),
                        ],
                      ),
                      trailing: Chip(
                        label: Text(
                          referral['status'],
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: referral['status'] == 'verified'
                            ? Colors.green
                            : Colors.orange,
                      ),
                    ),
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