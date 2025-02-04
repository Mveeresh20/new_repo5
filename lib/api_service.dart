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
}
