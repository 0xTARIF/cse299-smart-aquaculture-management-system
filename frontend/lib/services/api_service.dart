import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://127.0.0.1:8000";

  /// SEND OTP
  static Future<bool> sendOtp(String email) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/send-otp?email=$email"),
    );

    return response.statusCode == 200;
  }

  /// VERIFY OTP
  static Future<bool> verifyOtp(String email, String otp) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/verify-otp?email=$email&otp=$otp"),
    );

    print("VERIFY RESPONSE: ${response.body}");

    return response.statusCode == 200;
  }

  // Create user
  static Future<bool> createUser({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/create-user"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"name": name, "email": email, "password": password}),
    );

    return response.statusCode == 200 &&
        jsonDecode(response.body)["message"] != null;
  }

  static Future<Map<String, dynamic>?> login(
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return data; // return full user object
    } else {
      return null;
    }
  }

  Future<List<dynamic>> getFarms(String userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/farms?user_id=$userId'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load farms');
    }
  }
}
