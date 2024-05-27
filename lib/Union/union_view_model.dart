import 'package:flutter/material.dart';
import 'package:hobbyhobby/Auth/auth_manager.dart';
import 'package:hobbyhobby/Auth/jwt_token_model.dart';
import 'package:hobbyhobby/Union/union_model.dart';
import 'package:hobbyhobby/Union/union_repository.dart';

class UnionViewModel with ChangeNotifier {
  final UnionRepository _unionRepository;
  final AuthManager _authManager;

  UnionViewModel(
      this._unionRepository,
      this._authManager
      );

  Future<List<UnionMeeting>> getUnionMeeting() async {
    try {
      // Access Token을 불러옵니다.
      final JwtToken accessToken = await _authManager.loadAccessToken();
      return await _unionRepository.getUnionMeetings(accessToken);
    } catch (error) {
      print(error);
      try {
        final JwtToken accessToken = await _authManager.authorizeRefreshToken();
        return await _unionRepository.getUnionMeetings(accessToken);
      } catch (error) {
        print(error);
        throw error;
      }
    }
  }

  Future<List<SingleMeeting>> getSingleMeeting() async {
    try {
      // Access Token을 불러옵니다.
      final JwtToken accessToken = await _authManager.loadAccessToken();
      return await _unionRepository.getSingleMeetings(accessToken);
    } catch (error) {
      try {
        final JwtToken accessToken = await _authManager.authorizeRefreshToken();
        return await _unionRepository.getSingleMeetings(accessToken);
      } catch (error) {
        throw error;
      }
    }
  }

  Future<void> createUnionMeeting(UnionMeeting meeting) async {
    try {
      final JwtToken accessToken = await _authManager.loadAccessToken();
      await _unionRepository.createUnionMeeting(meeting, accessToken);
    } catch (error) {
      try {
        final JwtToken accessToken = await _authManager.authorizeRefreshToken();
        await _unionRepository.createUnionMeeting(meeting, accessToken);
      } catch (error) {
        throw error;
      }
    }
  }

  Future<void> createSingleMeeting(SingleMeeting meeting) async {
    try {
      final JwtToken accessToken = await _authManager.loadAccessToken();
      await _unionRepository.createSingleMeeting(meeting, accessToken);
    } catch (error) {
      try {
        final JwtToken accessToken = await _authManager.authorizeRefreshToken();
        await _unionRepository.createSingleMeeting(meeting, accessToken);
      } catch (error) {
        throw error;
      }
    }
  }

  Future<List<UnionMeeting>> getUnionMeetingDetail() async {
    try {
      // Access Token을 불러옵니다.
      final JwtToken accessToken = await _authManager.loadAccessToken();
      return await _unionRepository.getUnionMeetingsDetail(accessToken);
    } catch (error) {
      try {
        final JwtToken accessToken = await _authManager.authorizeRefreshToken();
        return await _unionRepository.getUnionMeetingsDetail(accessToken);
      } catch (error) {
        throw error;
      }
    }
  }

  Future<List<SingleMeeting>> getSingleMeetingDetail() async {
    try {
      // Access Token을 불러옵니다.
      final JwtToken accessToken = await _authManager.loadAccessToken();
      return await _unionRepository.getSingleMeetingsDetail(accessToken);
    } catch (error) {
      try {
        final JwtToken accessToken = await _authManager.authorizeRefreshToken();
        return await _unionRepository.getSingleMeetingsDetail(accessToken);
      } catch (error) {
        throw error;
      }
    }
  }
}
