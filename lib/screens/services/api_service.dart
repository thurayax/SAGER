import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  Future<String> getRecommendation(Map<String, dynamic> data) async {
final url = Uri.parse('http://192.168.1.100:5000/predict');
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        return result['recommendation'] ?? 'لا توجد توصية';
      } else {
        throw Exception('Failed to fetch recommendation: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error fetching recommendation');
    }
  }
}
