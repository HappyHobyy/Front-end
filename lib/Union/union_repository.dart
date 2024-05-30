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

  Future<UnionMeeting> getUnionMeetingsDetail(JwtToken jwtToken, int articleId) async {
    return await _unionApi.getUnionMeetingsDetail(jwtToken,articleId);
  }

  Future<SingleMeeting> getSingleMeetingsDetail(JwtToken jwtToken, int articleId) async {
    return await _unionApi.getSingleMeetingsDetail(jwtToken, articleId);
  }

  Future<void> deleteUnionMeeting(JwtToken jwtToken, int articleId) async {
    await _unionApi.deleteUnionMeeting(jwtToken, articleId);
  }

  Future<void> deleteSingleMeeting(JwtToken jwtToken, int articleId) async {
    await _unionApi.deleteSingleMeeting(jwtToken, articleId);
  }

  Future<void> memberUnionMeeting(JwtToken jwtToken, int articleId) async {
    await _unionApi.memberUnionMeeting(jwtToken, articleId);
  }

  Future<void> memberSingleMeeting(JwtToken jwtToken, int articleId) async {
    await _unionApi.memberSingleMeeting(jwtToken, articleId);
  }

  Future<void> deleteMemberUnionMeeting(JwtToken jwtToken, int articleId) async {
    await _unionApi.deleteMemberUnionMeeting(jwtToken, articleId);
  }

  Future<void> deleteMemberSingleMeeting(JwtToken jwtToken, int articleId) async {
    await _unionApi.deleteMemberSingleMeeting(jwtToken, articleId);
  }

  Future<void> likeUnionMeeting(JwtToken jwtToken, int articleId) async {
    await _unionApi.likeUnionMeeting(jwtToken, articleId);
  }

  Future<void> likeSingleMeeting(JwtToken jwtToken, int articleId) async {
    await _unionApi.likeSingleMeeting(jwtToken, articleId);
  }

  Future<void> deleteLikeUnionMeeting(JwtToken jwtToken, int articleId) async {
    await _unionApi.deleteLikeUnionMeeting(jwtToken, articleId);
  }

  Future<void> deleteLikeSingleMeeting(JwtToken jwtToken, int articleId) async {
    await _unionApi.deleteLikeSingleMeeting(jwtToken, articleId);
  }

  Future<List<SingleMeeting>> getSingleMeetingsSearch(JwtToken jwtToken,int communityId) async {
    return await _unionApi.getSingleMeetingsSearch(jwtToken,communityId);
  }
  Future<List<UnionMeeting>> getUnionMeetingsSearchOne(JwtToken jwtToken,int communityId ) async {
    return await _unionApi.getUnionMeetingsSearchOne(jwtToken,communityId);
  }
  Future<List<UnionMeeting>> getUnionMeetingsSearchTwo(JwtToken jwtToken,int communityId1,int communityId2 ) async {
    return await _unionApi.getUnionMeetingsSearchTwo(jwtToken,communityId1,communityId2);
  }

}
