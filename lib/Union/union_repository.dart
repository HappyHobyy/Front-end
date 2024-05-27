import 'package:hobbyhobby/Auth/jwt_token_model.dart';

import 'union_api.dart';
import 'union_model.dart';

class UnionRepository {
  final UnionApi _unionApi;

  UnionRepository(this._unionApi);

  Future<List<UnionMeeting>> getUnionMeetings(JwtToken jwtToken) async {
    return await _unionApi.getUnionMeetings(jwtToken);
  }

  Future<List<SingleMeeting>> getSingleMeetings(JwtToken jwtToken) async {
    return await _unionApi.getSingleMeetings(jwtToken);
  }

  Future<void> createUnionMeeting(UnionMeeting meeting, JwtToken jwtToken) async {
    await _unionApi.createUnionMeeting(meeting, jwtToken);
  }

  Future<void> createSingleMeeting(SingleMeeting meeting, JwtToken jwtToken) async {
    await _unionApi.createSingleMeeting(meeting, jwtToken);
  }

  Future<List<UnionMeeting>> getUnionMeetingsDetail(JwtToken jwtToken) async {
    return await _unionApi.getUnionMeetingsDetail(jwtToken);
  }

  Future<List<SingleMeeting>> getSingleMeetingsDetail(JwtToken jwtToken) async {
    return await _unionApi.getSingleMeetingsDetail(jwtToken);
  }
}
