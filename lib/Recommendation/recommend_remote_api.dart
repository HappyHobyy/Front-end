import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hobbyhobby/Recommendation/RecommendationModel.dart';

class RecommendationRemoteApi {
  late http.Client httpClient;

  RecommendationRemoteApi() : httpClient = http.Client();

  // MBTI 테스트 문항 Post
  Future<RecommendationModel?> mbtiTestPost(List<int?> answers) async {
    try {
      var uri =
      Uri.http('52.79.143.36:8090', 'ai-service/api/ai');

      final response = await httpClient.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'answer': answers}),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
        return RecommendationModel.fromJson(jsonResponse);
      } else {
        print('추천 취미를 불러오는 데 실패했습니다.');
      }
    } catch (e) {
      print('오류 발생: $e');
    }
  }
}