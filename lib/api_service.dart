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
  /* 예시
  Future<void> likePost(int communityId) async {
    try {
      final jwtToken = await jwtTokenFuture;
      await ApiService().sendData(
        jwtToken,
        'community-service',
        'api/community/user',
        {'communityId': communityId},
      );
      print('Post liked successfully');
    } catch (e) {
      print("Error liking post: $e");
    }
  }
  * */
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
  /*
  * Future<void> deletePost(int communityId) async {
    try {
      final jwtToken = await jwtTokenFuture;
      await ApiService().deleteData(
        jwtToken,
        'community-service',
        'api/community/user',
        {'communityId': communityId},
      );
      print('Post deleted successfully');
    } catch (e) {
      print("Error deleting post: $e");
    }
  } */
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
  /* 예시
  late AuthManager _authManager;
  late Future<List<PopularCommunity>> popularCommunitiesFuture;
  late Future<JwtToken> jwtTokenFuture;

  @override
  void initState() {
    super.initState();
    _authManager = widget.authManager;
    jwtTokenFuture = _authManager.loadAccessToken();
    _loadData();
  }
  Future<void> _loadData() async {
    try {
      final jwtToken = await jwtTokenFuture;
      setState(() {
        popularCommunitiesFuture = ApiService().fetchData(
          jwtToken,
          'community-service',
          'api/community/popular',
          (json) => PopularCommunity.fromJson(json),
        );
      });
    } catch (e) {
      print("Error loading data: $e");
    }
  }
   * */
  // 인기 커뮤니티
  Future<List<PopularCommunity>> getPopularCommunities(
      JwtToken jwtToken) async {
    return fetchData(jwtToken, 'community-service', 'api/community/popular',
        (json) => PopularCommunity.fromJson(json));
  }

  // 즐겨찾기 커뮤니티
  Future<List<MyCommunity>> getMyCommunities(JwtToken jwtToken) async {
    return fetchData(jwtToken, 'community-service', 'api/community/user',
        (json) => MyCommunity.fromJson(json));
  }
}
