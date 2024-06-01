import 'dart:io';
import 'dart:convert';
import 'package:hobbyhobby/communitys/hlog_model.dart';
import 'package:http/http.dart' as http;
import '../Auth/jwt_token_model.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class HlogRemoteApi {
  late http.Client httpClient;
  late List<HLogArticle> _articles = [];

  HlogRemoteApi() {
    httpClient = http.Client();
  }

  List<HLogArticle> get articles => _articles;

  // H-log 게시물 10개 가져오기
  Future<void> fetchRecentArticles(JwtToken jwtToken, int index, int communityId) async {
    try {
      var uri =
          Uri.http('52.79.143.36:8000', 'photocontent-service/api/hlog/latest');

      final http.Response response = await httpClient.get(
        uri,
        headers: <String, String>{
          'index': index.toString(),
          'communityId': communityId.toString(),
          'Authorization': '${jwtToken.accessToken}',
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
        print('Response data: $jsonResponse');
        _articles = (jsonResponse['data'] as List<dynamic>)
            .map((item) => HLogArticle.fromJson(item))
            .toList();
      } else {
        print('게시물을 불러오는 데 실패했습니다.');
      }
    } catch (e) {
      print('오류 발생: $e');
    }
  }

  // 게시물 저장
  Future<void> savePost(JwtToken jwtToken, HLogPostRequest postRequest, List<File>? images) async {
    try {
      var uri = Uri.http('52.79.143.36:8000', 'photocontent-service/api/hlog');

      var request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = '${jwtToken.accessToken}';

      // JSON 데이터를 파일로 추가
      request.files.add(http.MultipartFile.fromString(
        'request',
        json.encode(postRequest.toJson()),
        contentType: MediaType('application', 'json'),
      ));

      // 이미지 파일 리스트 생성
      if (images != null && images.isNotEmpty) {
        List<http.MultipartFile> imageFiles = [];
        for (var image in images) {
          var mimeType = lookupMimeType(image.path) ?? 'application/octet-stream';
          imageFiles.add(await http.MultipartFile.fromPath(
            'files',
            image.path,
            contentType: MediaType.parse(mimeType),
          ));
        }
        // 이미지 파일 리스트를 한 번에 추가
        request.files.addAll(imageFiles);
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode != 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        throw data['error'];
      }

      print('게시글이 업로드 되었습니다.');
    } catch (error) {
      print('오류 발생: $error');
    }
  }

  // 좋아요 추가
  Future<void> likePost(JwtToken jwtToken, HLogLikeRequest likeRequest) async {
    try {
      var uri = Uri.http(
          '52.79.143.36:8000', 'photocontent-service/api/hlog/like');

      final http.Response response = await httpClient.post(
        uri,
        headers: <String, String>{
          'Authorization': '${jwtToken.accessToken}',
          'Content-Type': 'application/json',
        },
        body: json.encode(likeRequest.toJson()),
      );
      if (response.statusCode == 200) {
        print('좋아요가 추가되었습니다.');
      } else {
        print('좋아요 추가에 실패했습니다.');
      }
    } catch (error) {
      print('오류 발생: $error');
    }
  }

  // 좋아요 취소
  Future<void> likeDelete(JwtToken jwtToken, likeDeleteRequest deleteRequest) async {
    try {
      var uri =
      Uri.http('52.79.143.36:8000', 'photocontent-service/api/hlog/like');

      final http.Response response = await httpClient.delete(
        uri,
        headers: <String, String>{
          'Authorization': '${jwtToken.accessToken}',
          'Content-Type': 'application/json',
        },
        body: json.encode(deleteRequest.toJson()),
      );
      if (response.statusCode == 200) {
        print('좋아요가 취소되었습니다.');
      } else {
        print('좋아요를 취소하는 데 실패했습니다.');
      }
    } catch (e) {
      print('오류 발생: $e');
    }
  }

  // 내 게시물 삭제
  Future<void> articleDelete(JwtToken jwtToken, HLogDeleteRequest deleteRequest) async {
    try {
      var uri =
      Uri.http('52.79.143.36:8000', 'photocontent-service/api/hlog');

      final http.Response response = await httpClient.delete(
        uri,
        headers: <String, String>{
          'Authorization': '${jwtToken.accessToken}',
          'Content-Type': 'application/json',
        },
        body: json.encode(deleteRequest.toJson()),
      );
      if (response.statusCode == 200) {
      } else {
        print('게시물을 삭제하는 데 실패했습니다.');
      }
    } catch (e) {
      print('오류 발생: $e');
    }
  }
}