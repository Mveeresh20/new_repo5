class Config {
  static const String appname = 'TngTong';
  //api links
  static const String apiDomain = 'https://demo.infoskaters.com/api';
  static const String registerEndpoint = '/customerregister.php';
  static const String CustomerEmailotpverify = '/validate_otp.php';
  static const String customerLogin = '/customerLogin.php';
  static const String celebrity_reg = '/celebrity_reg.php';
  static const String celebrity_login = '/celebrity_login.php';
  static const String CelEmailotpverify = '/celebrity_validate_otp.php';
  static const String CelUpdateProfilePhoto = '/upload.php';
  static const String CelUpadateprofile = '/celebrity_update_profile.php';

//function api
  static const String functionApi='$apiDomain/function/function.php';
  static const String getUseridFromMail = '$functionApi?action=getUserId&email=';

// You can add more configuration variables here as needed
}