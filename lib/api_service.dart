import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tngtong/config.dart';

class ApiService {
  static Future<String?> getUserId(String? loginEmail) async {
    String apiUrl=Config.getUseridFromMail;
    if (loginEmail == null || loginEmail.isEmpty) {
      print('Login email is null or empty');
      return null;
    }

    final String url = '$apiUrl$loginEmail';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData.containsKey('data') && responseData['data'] is Map<String, dynamic>) {
          final data = responseData['data'] as Map<String, dynamic>;
          if (data.containsKey('id')) {
           // return data['id'] as String;
            final userId = data['id'];
            return userId.toString();
          } else {
            print('User ID not found in data');
          }
        } else {
          print('Data field is missing or invalid');
        }
      } else {
        print('Failed to fetch user ID. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching user ID: $e');
      return null;
    }
  }


  static Future<String?> getCelId(String? loginEmail) async {
    String apiUrl=Config.getCelidFromMail;
    if (loginEmail == null || loginEmail.isEmpty) {
      print('Login email is null or empty');
      return null;
    }

    final String url = '$apiUrl$loginEmail';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData.containsKey('data') && responseData['data'] is Map<String, dynamic>) {
          final data = responseData['data'] as Map<String, dynamic>;
          if (data.containsKey('c_id')) {
            // return data['id'] as String;
            final userId = data['c_id'];
            return userId.toString();
          } else {
            print('User ID not found in data');
          }
        } else {
          print('Data field is missing or invalid');
        }
      } else {
        print('Failed to fetch user ID. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching user ID: $e');
      return null;
    }
  }

  static Future<String?> getAffilaterId(String? loginEmail) async {
    String apiUrl=Config.getAffilaterId;
    if (loginEmail == null || loginEmail.isEmpty) {
      print('Login email is null or empty');
      return null;
    }

    final String url = '$apiUrl$loginEmail';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData.containsKey('data') && responseData['data'] is Map<String, dynamic>) {
          final data = responseData['data'] as Map<String, dynamic>;
          if (data.containsKey('a_id')) {
            // return data['id'] as String;
            final userId = data['a_id'];
            return userId.toString();
          } else {
            print('User ID not found in data');
          }
        } else {
          print('Data field is missing or invalid');
        }
      } else {
        print('Failed to fetch user ID. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching user ID: $e');
      return null;
    }
  }

  //get wallete balance of celebrity
  static Future<double?> getCelebrityWalletBalance(String? cid) async {
    String apiUrl = Config.getCelebrityWalletBalance;
    if (cid == null || cid.isEmpty) {
      print('Login ID is null or empty');
      return null;
    }

    final String url = '$apiUrl$cid';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData.containsKey('wallet_balance')) {
          final dynamic walletBalance = responseData['wallet_balance'];

          if (walletBalance is num) {
            return walletBalance.toDouble(); // If it's already a number, return as double
          } else if (walletBalance is String) {
            return double.tryParse(walletBalance) ?? 0.0; // Convert string to double safely
          }
        } else {
          print('Wallet balance not found in response');
        }
      } else {
        print('Failed to fetch wallet balance. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching wallet balance: $e');
    }

    return null; // Return null if fetching or parsing fails
  }


  //get wallete balance of celebrity
  static Future<double?> getAffilaterWalletBalance(String? aid) async {
    String apiUrl = Config.getAffilaterWalletBalance;
    if (aid == null || aid.isEmpty) {
      print('Login ID is null or empty');
      return null;
    }

    final String url = '$apiUrl$aid';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData.containsKey('wallet_balance')) {
          final dynamic walletBalance = responseData['wallet_balance'];

          if (walletBalance is num) {
            return walletBalance.toDouble(); // If it's already a number, return as double
          } else if (walletBalance is String) {
            return double.tryParse(walletBalance) ?? 0.0; // Convert string to double safely
          }
        } else {
          print('Wallet balance not found in response');
        }
      } else {
        print('Failed to fetch wallet balance. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching wallet balance: $e');
    }

    return null; // Return null if fetching or parsing fails
  }



  //get wallete balance of celebrity
  static Future<double?> getBrandWalletBalance(String? uid) async {
    String apiUrl = Config.getBrandWalletBalance;
    if (uid == null || uid.isEmpty) {
      print('Login ID is null or empty');
      return null;
    }

    final String url = '$apiUrl$uid';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData.containsKey('wallet_balance')) {
          final dynamic walletBalance = responseData['wallet_balance'];

          if (walletBalance is num) {
            return walletBalance.toDouble(); // If it's already a number, return as double
          } else if (walletBalance is String) {
            return double.tryParse(walletBalance) ?? 0.0; // Convert string to double safely
          }
        } else {
          print('Wallet balance not found in response');
        }
      } else {
        print('Failed to fetch wallet balance. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching wallet balance: $e');
    }

    return null; // Return null if fetching or parsing fails
  }

  //get wallete balance of celebrity
  static Future<double?> getEarningsBal(String? cid,String? userType) async {
    String apiUrl = Config.getEarningsBal;
    if (cid == null || cid.isEmpty) {
      print('Login ID is null or empty');
      return null;
    }

    final String url = '$apiUrl$cid&userType=$userType';
    // https://demo.infoskaters.com/api/function/function.php?action=getEarningsBal&userId=2&userType=celebrity
   // final String url = 'https://demo.infoskaters.com/api/function/function.php?action=getEarningsBal&userId=2&userType=celebrity';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData.containsKey('earning_balance')) {
          final dynamic walletBalance = responseData['earning_balance'];

          if (walletBalance is num) {
            return walletBalance.toDouble(); // If it's already a number, return as double
          } else if (walletBalance is String) {
            return double.tryParse(walletBalance) ?? 0.0; // Convert string to double safely
          }
        } else {
          print('Wallet balance not found in response');
        }
      } else {
        print('Failed to fetch wallet balance. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching wallet balance: $e');
    }

    return 0.0; // Return null if fetching or parsing fails
  }

  //get my ref id from userid and usertype
  static Future<String?> getMyReferralCode(String? userId,String? userType) async {
    String apiUrl = Config.getMyReferralCode;
    final String url = '$apiUrl$userId&userType=$userType';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData.containsKey('referralId')) {
          final String referralId = responseData['referralId'];


            return referralId; // If it's already a number, return as double
          }
        } else {
          print('Wallet balance not found in response');
        }

    } catch (e) {
      print('Error fetching wallet balance: $e');
    }

    return null; // Return null if fetching or parsing fails
  }
//get referal deatials
  static Future<List<Map<String, dynamic>>> getReferralDetails(String userId, String userType) async {
   // String apiUrl = "https://demo.infoskaters.com/api/function/function.php?action=getReferralDetails&userId=$userId&userType=$userType";
    String apiUrl= Config.getReferralDetails;
    final String url = '$apiUrl$userId&userType=$userType';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData['status'] == 'success' && responseData.containsKey('data')) {
          List<Map<String, dynamic>> referrals = List<Map<String, dynamic>>.from(responseData['data']);
          return referrals;
        } else {
          print("Error: ${responseData['message']}");
          return [];
        }
      } else {
        print("Failed to fetch referrals. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching referral details: $e");
    }

    return [];
  }



}
