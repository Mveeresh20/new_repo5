import 'package:http/http.dart' as http;
import 'dart:convert';
class Config {


  static const String appname = 'Influencer Setter';
  //api links
  static const String apiDomain = 'https://demo.infoskaters.com/api';
  static const String RazorPaypaymentApi = 'ggggggjjhbhhj';

  static const String registerEndpoint = '/customerregister.php';
  static const String CustomerEmailotpverify = '/validate_otp.php';
  static const String customerLogin = '/customerLogin.php';
  static const String celebrity_reg = '/celebrity_reg.php';
  static const String celebrity_login = '/celebrity_login.php';
  static const String CelEmailotpverify = '/celebrity_validate_otp.php';
  static const String CelUpdateProfilePhoto = '/upload.php';
  static const String CelUpadateprofile = '/celebrity_update_profile.php';
  static const String celebrityUpdateWalletBal= '/celebrityUpdateWalletBal.php';
  static const String userUpdateWalletBal= '/userUpdateWalletBal.php';
  static const String affilaterUpdateWalletBal= '/affilaterUpdateWalletBal.php';
  static const String get_top_trending_cel= '/get_top_trending_cel.php';
  static const String storeBooking= '/storeBooking.php';
  static const String get_bookings= '/get_bookings.php?userId=';  //for brands to see there bookings
  static const String get_influencer_projects= '/get_influencer_projects.php?influencerId=';


  static const String getCelebrityTransactionHistory= '/getCelebrityTransactionHistory.php';
  static const String getBrandTransactionHistory= '/getBrandTransactionHistory.php';
  static const String storePakageDetails= '/storePakageDetails.php';

  static const String getAffilaterTransactionHistory= '/getAffilaterTransactionHistory.php';
  static const String get_packages = '$apiDomain/get_packages.php?usertype=';
  static const String create_support_ticket = '/create_support_ticket.php';
  static const String fetch_support_tickets = '/fetch_support_tickets.php';

  //affilate
  static const String affiliater_login = '/affiliater_login.php';
  static const String affiliater_reg = '/affiliater_reg.php';
  static const String affiliaterEmailOtpVerify = '/affiliaterEmailOtpVerify.php';
  static const String resendOtpEndpoint = '/resendOtp.php';
  static const String forgot_password = '/forgot_password.php';

//function api
  static const String functionApi='$apiDomain/function/function.php';
  static const String getUseridFromMail = '$functionApi?action=getUserId&email=';
  static const String getCelidFromMail = '$functionApi?action=getCelId&email=';
  static const String getAffilaterId = '$functionApi?action=getAffilaterId&email=';

  static const String getCelebrityBasicProfile = '$functionApi?action=getCelebrityBasicProfile&c_id=';
  static const String getCelebrityWalletBalance = '$functionApi?action=getCelebrityWalletBalance&c_id=';
  static const String getBrandWalletBalance = '$functionApi?action=getBrandWalletBalance&u_id=';
  static const String getAffilaterWalletBalance = '$functionApi?action=getAffilaterWalletBalance&a_id=';

  static const String getMyReferralCode='$functionApi?action=getReferralCode&userId=';
  static const String getReferralDetails='$functionApi?action=getReferralDetails&userId=';
  static const String getKycStatus='$functionApi?action=getKycStatus&userId=';

  // https://demo.infoskaters.com/api/function/function.php?action=getEarningsBal&userId=2&userType=celebrity
  static const String getEarningsBal = '$functionApi?action=getEarningsBal&userId=';
//https://demo.infoskaters.com/api/function/function.php?action=getEarningsTransactions&userId=2&userType=celebrity
  //static const String getEarningsTransactions = '$functionApi?action=getEarningsTransactions&userId=';
 // https://demo.infoskaters.com/api/getEarningsTransactions.php?userId=2&userType=celebrity
  static const String getEarningsTransactions = '$apiDomain/getEarningsTransactions.php?userId=';

// You can add more configuration variables here as needed

  static String? _razorpayKey;

  static Future<void> loadKey() async {
    try {
      final response = await http.get(
          Uri.parse('$apiDomain /get_razorpay_key.php')
      );

      if (response.statusCode == 200) {
        _razorpayKey = jsonDecode(response.body)['key'];
      }
    } catch (e) {
      print('Error loading key: $e');
    }
  }

  static String get razorpayKey {
    return _razorpayKey ?? 'DEFAULT_KEY';
  }
}