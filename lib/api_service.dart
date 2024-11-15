import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://localhost:5000/api'; // Update with your server's URL if needed

  Future<String> getMessage() async {
    final response = await http.get(Uri.parse('$baseUrl/message'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['message'];
    } else {
      throw Exception('Failed to load message');
    }
  }
}
