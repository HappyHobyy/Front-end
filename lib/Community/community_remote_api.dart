import 'dart:convert';

import 'package:hobbyhobby/Auth/user_model.dart';
import 'package:http/http.dart' as http;

import '../Auth/jwt_token_model.dart';

class CommunityRemoteApi {
  late http.Client httpClient;

  CommunityRemoteApi() {
    httpClient = http.Client();
  }

  //객체로 받아와야함 차우
  Future<bool> getCommunityPopularContents(JwtToken jwtToken) async {
    var uri = Uri.http(
        '52.79.143.36:8000', 'community-service/api/community/popular/contents');
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
      return true;
    } else {
      Map<String, dynamic> data = jsonDecode(response.body);
      throw data['error'];
    }
  }
}