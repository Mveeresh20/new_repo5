import 'package:flutter/material.dart';
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
  String? userType="affiliater";
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
    String? id = await ApiService.getAffilaterId(loginEmail);
    setState(() {
      userId = id;
    });
    _getMyRefCode();
    List<Map<String, dynamic>>  referrals1 = await ApiService.getReferralDetails(userId!, "affiliater");
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
                Color(0xffB81736),
                Color(0xff281537),
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
                      Color(0xffB81736),
                      Color(0xff281537),
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
                      Color(0xffB81736),
                      Color(0xff281537),
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
