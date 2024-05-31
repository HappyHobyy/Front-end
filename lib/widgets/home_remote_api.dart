import 'dart:convert';
import 'package:hobbyhobby/widgets/home_model.dart';
import 'package:http/http.dart' as http;
import '../Auth/jwt_token_model.dart';

class HomeRemoteApi {
  late http.Client httpClient;

  HomeRemoteApi() {
    httpClient = http.Client();
  }

  // 인기 모임, H-log 40개 가져오기
  Future<HomeModel?> popularContentsArticles(JwtToken jwtToken) async {
    try {
      var uri =
      Uri.http('52.79.143.36:8000', 'photocontent-service/api/community/popular/contents');

      final http.Response response = await httpClient.get(
        uri,
        headers: <String, String>{
          'Authorization': '${jwtToken.accessToken}',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
        return HomeModel.fromJson(jsonResponse);
      } else {
        print('인기/비인기 게시물을 불러오는 데 실패했습니다.');
        return null;
      }
    } catch (e) {
      print('오류 발생: $e');
      return null;
    }
  }
}