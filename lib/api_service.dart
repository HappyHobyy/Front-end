import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Auth/jwt_token_model.dart';
import 'communitys/models.dart';

class ApiService {
  final String baseUrl = 'http://52.79.143.36:8000';

  ApiService();

  // GET
  Future<List<T>> fetchData<T>(
      JwtToken jwtToken,
      String basePath,
      String endpoint,
      T Function(Map<String, dynamic>) fromJson,
      ) async {
    String accessToken = jwtToken.accessToken!;

    final response = await http.get(
      Uri.parse('$baseUrl/$basePath/$endpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': accessToken,
      },
    );

    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> decodedJson = jsonDecode(responseBody);
      final List<dynamic> data = decodedJson['data'];
      return data.map((json) => fromJson(json)).toList();
    } else {
      print('Failed to load data: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load data');
    }
  }

  // POST
  Future<void> sendData(
      JwtToken jwtToken,
      String basePath,
      String endpoint,
      Map<String, dynamic> body,
      ) async {
    String accessToken = jwtToken.accessToken!;

    final response = await http.post(
      Uri.parse('$baseUrl/$basePath/$endpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': accessToken,
      },
      body: jsonEncode(body),
    );

    if (response.statusCode != 200) {
      print('Failed to send data: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to send data');
    }
  }

  // DELETE
  Future<void> deleteData(
      JwtToken jwtToken,
      String basePath,
      String endpoint,
      Map<String, dynamic> body,
      ) async {
    String accessToken = jwtToken.accessToken!;

    final response = await http.delete(
      Uri.parse('$baseUrl/$basePath/$endpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': accessToken,
      },
      body: jsonEncode(body),
    );

    if (response.statusCode != 200) {
      print('Failed to delete data: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to delete data');
    }
  }

  // GET
  // 인기 커뮤니티
  Future<List<Community>> getPopularCommunities(JwtToken jwtToken) async {
    return fetchData(jwtToken, 'community-service', 'api/community/popular',
            (json) => Community.fromJson(json));
  }

  // 즐겨찾기 커뮤니티
  Future<List<Community>> getMyCommunities(JwtToken jwtToken) async {
    return fetchData(jwtToken, 'community-service', 'api/community/user',
            (json) => Community.fromJson(json));
  }
}