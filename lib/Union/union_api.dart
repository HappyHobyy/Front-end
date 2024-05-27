import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hobbyhobby/Auth/jwt_token_model.dart';
import 'union_model.dart';

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
      Map<String, dynamic> data = jsonDecode(response.body);
      final res = data["data"];
      return List<UnionMeeting>.from(res.map((data) => UnionMeeting.fromJson(data)));
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
        'index' : '0'
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      final res = data["data"];
      return List<SingleMeeting>.from(res.map((data) => SingleMeeting.fromJson(data)));
    } else {
      Map<String, dynamic> data = jsonDecode(response.body);
      throw data['error'];
    }
  }

//연합 모임 게시글 저장
  Future<void> createUnionMeeting(UnionMeeting meeting,
      JwtToken jwtToken) async {
    var uri = Uri.http(
        '52.79.143.36:8000', 'photocontent-service/api/gathering/multi');
            /*{
              "request": {
                "communityId1": 0,
                "communityId2": 0,
                "title": "title",
                "date": "2024-05-27T03:29:44.045Z",
                "joinMax": 5,
                "text": "text",
                "location": "location",
                "openTalkLink": "http://"
              },
              "file": "string"
            }*/
    final response = await httpClient.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${jwtToken.accessToken}'
      },
      body: jsonEncode(meeting.toUnionMeetingsJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create union meeting');
    }
  }
//단일 모임 게시글 저장
  Future<void> createSingleMeeting(SingleMeeting meeting,
      JwtToken jwtToken) async {
    var uri = Uri.http('52.79.143.36:8000', 'photocontent-service/api/gathering/single');
              /*{
                "request": {
              "communityId": 123,
              "title": "title",
              "date": "2024-05-25T16:24:05.571Z",
              "text": "text",
              "location": "location",
              "gatheringUrl": "http://"
            },
              "file": "string"
            }*/
    final response = await httpClient.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${jwtToken.accessToken}'
      },
      body: jsonEncode(meeting.toSingleMeetingsJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create single meeting');
    }
  }
//연합 모임 게시글 내용 가져오기
  Future<List<UnionMeeting>> getUnionMeetingsDetail(JwtToken jwtToken) async {
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
        'Authorization': '${jwtToken.accessToken}'
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      final res = data["data"];
      return List<UnionMeeting>.from(res.map((data) => UnionMeeting.fromJson(data)));
    } else {
      Map<String, dynamic> data = jsonDecode(response.body);
      throw data['error'];
    }
  }
//단일 모임 게시글 내용 가져오기
  Future<List<SingleMeeting>> getSingleMeetingsDetail(JwtToken jwtToken) async {
    var uri = Uri.http(
        '52.79.143.36:8000', 'photocontent-service/api/gathering/single/detail');
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
      Map<String, dynamic> data = jsonDecode(response.body);
      final res = data["data"];
      return List<SingleMeeting>.from(res.map((data) => SingleMeeting.fromJson(data)));
    } else {
      Map<String, dynamic> data = jsonDecode(response.body);
      throw data['error'];
    }
  }
}

