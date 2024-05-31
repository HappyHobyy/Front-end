import 'dart:convert';
import 'package:hobbyhobby/Auth/user_model.dart';
import 'package:http/http.dart' as http;
import 'jwt_token_model.dart';

class AuthRemoteApi {
  late http.Client httpClient;

  AuthRemoteApi() {
    httpClient = http.Client();
  }

  Future<JwtToken> postSocialLogin(User user) async {
    var uri = Uri.http('52.79.143.36:8000', 'user-service/api/auth/login/oAuth');

    String jsonData = jsonEncode(user.toSocialLoginJson());
    final http.Response response = await httpClient.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonData,
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return JwtToken.fromJson(data);
    } else {
      //로그인 실패 -> 회원 가입 창으로 이동
      Map<String, dynamic> data = jsonDecode(response.body);
      throw data['error'];
    }
  }

  Future<JwtToken> postDefaultLogin(User user) async {
    var uri = Uri.http('52.79.143.36:8000', 'user-service/api/auth/login/default');
    String jsonData = jsonEncode(user.toDefaultLoginJson());
    final http.Response response = await httpClient.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonData,
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return JwtToken.fromJson(data);
    } else {
      //로그인 실패 -> 로그인 정보 없음 or 비밀번호 오류
      Map<String, dynamic> data = jsonDecode(response.body);
      throw data['error'];
    }
  }

  Future<bool> postDefaultRegister(User user) async {
    var uri = Uri.http('52.79.143.36:8000', 'user-service/api/auth/register/default');
    String jsonData = jsonEncode(user.toDefaultRegisterJson());
    final http.Response response = await httpClient.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonData,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      Map<String, dynamic> data = jsonDecode(response.body);
      throw data['error'];
    }
    //회원가입 실패
  }

  Future<bool> postSocialRegister(User user) async {
    var uri = Uri.http('52.79.143.36:8000', 'user-service/api/auth/register/oAuth');
    String jsonData = jsonEncode(user.toSocialRegisterJson());
    final http.Response response = await httpClient.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonData,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      Map<String, dynamic> data = jsonDecode(response.body);
      throw data['error'];
    }
  }
  Future<JwtToken> getAccessToken(JwtToken jwtToken) async {
    var uri = Uri.http('52.79.143.36:8000', 'user-service/api/auth/register/oAuth');
    final http.Response response = await httpClient.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': '${jwtToken.refreshToken}'
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return JwtToken.fromJson(data);
    } else {
      throw Exception();
    }
  }
}
