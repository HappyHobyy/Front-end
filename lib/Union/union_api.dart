import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hobbyhobby/Auth/jwt_token_model.dart';
import 'union_model.dart';
import 'package:http_parser/http_parser.dart';

class UnionApi {
  late http.Client httpClient;

  UnionApi() {
    httpClient = http.Client();
  }

//연합 모임 게시글 제목 가져오기
  Future<List<UnionMeeting>> getUnionMeetings(JwtToken jwtToken) async {
    var uri = Uri.http(
        '52.79.143.36:8000', 'photocontent-service/api/gathering/multi');
    /*{
                "code": 200,
                "message": "Success",
                "data": [
                  {
                    "gatheringArticleId": 123,
                    "createdAt": "2024-05-27T03:24:11.381Z",
                    "title": "hobbyhobby",
                    "userNickname": "hobbyhobby",
                    "likes": 12,
                    "joinMax": 12,
                    "joinCount": 12,
                    "communityId1": 1,
                    "communityId2": 2,
                    "image": {
                      "path": "http://...."
                    }
                  }
                ]
              }*/
    final response = await httpClient.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${jwtToken.accessToken}',
        'index': '0'
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      final res = data["data"];
      return List<UnionMeeting>.from(
          res.map((data) => UnionMeeting.fromJson(data)));
    } else {
      Map<String, dynamic> data = jsonDecode(response.body);
      throw data['error'];
    }
  }

//단일 모임 게시글 제목 가져오기
  Future<List<SingleMeeting>> getSingleMeetings(JwtToken jwtToken) async {
    var uri = Uri.http(
        '52.79.143.36:8000', 'photocontent-service/api/gathering/single');
    /* {
                "code": 200,
                "message": "Success",
                "data": [
                  {
                    "gatheringArticleId": 123,
                    "createdAt": "2024-05-27T03:29:16.442Z",
                    "title": "hobbyhobby",
                    "userNickname": "hobbyhobby",
                    "likes": 12,
                    "joinMax": 12,
                    "joinCount": 12,
                    "communityId": 12,
                    "image": {
                      "path": "http://...."
                    }
                  }
                ]
              }*/
    final response = await httpClient.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${jwtToken.accessToken}',
        'index': '0'
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      final res = data["data"];
      return List<SingleMeeting>.from(
          res.map((data) => SingleMeeting.fromJson(data)));
    } else {
      Map<String, dynamic> data = jsonDecode(response.body);
      throw data['error'];
    }
  }

  Future<void> createUnionMeeting(
      UnionMeeting meeting, JwtToken jwtToken) async {
    var uri = Uri.http(
        '52.79.143.36:8000', 'photocontent-service/api/gathering/multi');

    var request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = '${jwtToken.accessToken}';

    // JSON 데이터를 파일로 추가
    request.files.add(http.MultipartFile.fromString(
      'request',
      jsonEncode(meeting.toUnionMeetingsJson()),
      contentType: MediaType('application', 'json'),
    ));

    // 이미지 파일 추가
    request.files.add(await http.MultipartFile.fromPath(
      'file',
      meeting.imageUrl!,
      contentType: MediaType('multipart', 'form-data'),
    ));

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      throw data['error'];
    }
  }

  //단일 모임 게시글 저장
  Future<void> createSingleMeeting(
      SingleMeeting meeting, JwtToken jwtToken) async {
    var uri = Uri.http(
        '52.79.143.36:8000', 'photocontent-service/api/gathering/single');

    var request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = '${jwtToken.accessToken}';

    // JSON 데이터를 파일로 추가
    request.files.add(http.MultipartFile.fromString(
      'request',
      jsonEncode(meeting.toSingleMeetingsJson()),
      contentType: MediaType('application', 'json'),
    ));

    // 이미지 파일 추가
    request.files.add(await http.MultipartFile.fromPath(
      'file',
      meeting.imageUrl!,
      contentType: MediaType('multipart', 'form-data'),
    ));

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      throw data['error'];
    }
  }

//연합 모임 게시글 내용 가져오기
  Future<UnionMeeting> getUnionMeetingsDetail(JwtToken jwtToken,int articleId) async {
    var uri = Uri.http(
        '52.79.143.36:8000', 'photocontent-service/api/gathering/multi/detail');
    /*{
              "code": 200,
            "message": "Success",
            "data": {
            "date": "2024-05-25T16:24:30.791Z",
            "text": "text",
            "location": "location",
            "openTalkLink": "http;//",
            "isUserArticleOwner": true,
            "isUserLiked": true,
            "isUserJoined": true
          }
          }*/
    final response = await httpClient.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${jwtToken.accessToken}',
        'articleId': '${articleId}'
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      final res = data["data"];
      return UnionMeeting.fromDetailJson(res);
    } else {
      dynamic data = jsonDecode(response.body);
      throw data['error'];
    }
  }

//단일 모임 게시글 내용 가져오기
  Future<List<SingleMeeting>> getSingleMeetingsDetail(JwtToken jwtToken) async {
    var uri = Uri.http('52.79.143.36:8000',
        'photocontent-service/api/gathering/single/detail');
    /*{
              "code": 200,
            "message": "Success",
            "data": {
            "date": "2024-05-25T16:26:05.462Z",
            "text": "text",
            "location": "location",
            "openTalkLink": "http;//",
            "isUserArticleOwner": true,
            "isUserLiked": true,
            "isUserJoined": true
          }
          }*/
    final response = await httpClient.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${jwtToken.accessToken}'
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      final res = data["data"];
      return List<SingleMeeting>.from(
          res.map((data) => SingleMeeting.fromJson(data)));
    } else {
      Map<String, dynamic> data = jsonDecode(response.body);
      throw data['error'];
    }
  }
  Future<List<SingleMeeting>> getSingleMeetingsSearch(JwtToken jwtToken, int communityId) async {
    var uri = Uri.http('52.79.143.36:8000',
        'photocontent-service/api/gathering/single/search');
    final response = await httpClient.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${jwtToken.accessToken}',
        'index': '0',
        'communityId': '${communityId}'
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      final res = data["data"];
      return List<SingleMeeting>.from(
          res.map((data) => SingleMeeting.fromJson(data)));
    } else {
      Map<String, dynamic> data = jsonDecode(response.body);
      throw data['error'];
    }
  }

  Future<List<UnionMeeting>> getUnionMeetingsSearchOne(JwtToken jwtToken, int communityId) async {
    var uri = Uri.http('52.79.143.36:8000',
        'photocontent-service/api/gathering/multi/search1');
    final response = await httpClient.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${jwtToken.accessToken}',
        'index': '0',
        'communityId1': '$communityId',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      final res = data["data"];
      return List<UnionMeeting>.from(
          res.map((data) => UnionMeeting.fromJson(data)));
    } else {
      Map<String, dynamic> data = jsonDecode(response.body);
      throw data['error'];
    }
  }

  Future<List<UnionMeeting>> getUnionMeetingsSearchTwo(JwtToken jwtToken, int communityId1,int communityId2) async {
    var uri = Uri.http('52.79.143.36:8000',
        'photocontent-service/api/gathering/multi/search1');
    final response = await httpClient.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${jwtToken.accessToken}',
        'index': '0',
        'communityId1': '$communityId1',
        'communityId2': '$communityId2'
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      final res = data["data"];
      return List<UnionMeeting>.from(
          res.map((data) => UnionMeeting.fromJson(data)));
    } else {
      Map<String, dynamic> data = jsonDecode(response.body);
      throw data['error'];
    }
  }
}
