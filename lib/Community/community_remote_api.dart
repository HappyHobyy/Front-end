import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Auth/jwt_token_model.dart';
import '../communitys/models.dart';

class CommunityRemoteApi {
  late http.Client httpClient;

  CommunityRemoteApi() {
    httpClient = http.Client();
  }

  //객체로 받아와야함 차우
  Future<bool> getCommunityPopularContents(JwtToken jwtToken) async {
    var uri = Uri.http('52.79.143.36:8000',
        'community-service/api/community/popular/contents');
    final http.Response response = await httpClient.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': '${jwtToken.accessToken}'
      },
    );
    //나중에 수정
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data);
      return true;
    } else {
      Map<String, dynamic> data = jsonDecode(response.body);
      throw data['error'];
    }
  }

  // 유저 좋아요 커뮤니티 가져 오기
  Future<List<Community>> getUserCommunityList(JwtToken jwtToken) async {
    var uri =
        Uri.http('52.79.143.36:8000', 'community-service/api/community/user');
    final http.Response response = await httpClient.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': '${jwtToken.accessToken}'
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      final res = data["data"];
      return List<Community>.from(res.map((data) => Community.fromJson(data)));
      ;
    } else {
      Map<String, dynamic> data = jsonDecode(response.body);
      throw data['error'];
    }
  }

  // 인기 커뮤니티 가져 오기
  Future<List<Community>> getPopularCommunityList(JwtToken jwtToken) async {
    var uri =
        Uri.http('52.79.143.36:8000', 'community-service/api/community/popular');
    final http.Response response = await httpClient.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': '${jwtToken.accessToken}'
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      final res = data["data"];
      return List<Community>.from(res.map((data) => Community.fromJson(data)));
      ;
    } else {
      Map<String, dynamic> data = jsonDecode(response.body);
      throw data['error'];
    }
  }
}
