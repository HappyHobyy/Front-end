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
      print("Failed to create single meeting with initial access token: $error");
      try {
        final JwtToken accessToken = await _authManager.authorizeRefreshToken();
        await _unionRepository.createSingleMeeting(meeting, accessToken);
      } catch (error) {
        print("Failed to create single meeting with refreshed access token: $error");
        throw error;
      }
    }
  }

  Future<UnionMeeting> getUnionMeetingDetail(int articleId) async {
    try {
      // Access Token을 불러옵니다.
      final JwtToken accessToken = await _authManager.loadAccessToken();
      return await _unionRepository.getUnionMeetingsDetail(accessToken, articleId);
    } catch (error) {
      try {
        final JwtToken accessToken = await _authManager.authorizeRefreshToken();
        return await _unionRepository.getUnionMeetingsDetail(accessToken, articleId);
      } catch (error) {
        throw error;
      }
    }
  }

  Future<SingleMeeting> getSingleMeetingDetail(int articleId) async {
    try {
      // Access Token을 불러옵니다.
      final JwtToken accessToken = await _authManager.loadAccessToken();
      return await _unionRepository.getSingleMeetingsDetail(accessToken, articleId);
    } catch (error) {
      try {
        final JwtToken accessToken = await _authManager.authorizeRefreshToken();
        return await _unionRepository.getSingleMeetingsDetail(accessToken, articleId);
      } catch (error) {
        throw error;
      }
    }
  }

  Future<void> deleteUnionMeeting(int articleId) async {
    try {
      final JwtToken accessToken = await _authManager.loadAccessToken();
      await _unionRepository.deleteUnionMeeting(accessToken, articleId);
    } catch (error) {
      try {
        final JwtToken accessToken = await _authManager.authorizeRefreshToken();
        await _unionRepository.deleteUnionMeeting(accessToken, articleId);
      } catch (error) {
        throw error;
      }
    }
  }

  Future<void> deleteSingleMeeting(int articleId) async {
    try {
      final JwtToken accessToken = await _authManager.loadAccessToken();
      await _unionRepository.deleteSingleMeeting(accessToken, articleId);
    } catch (error) {
      try {
        final JwtToken accessToken = await _authManager.authorizeRefreshToken();
        await _unionRepository.deleteSingleMeeting(accessToken, articleId);
      } catch (error) {
        throw error;
      }
    }
  }
  Future<void> memberUnionMeeting(int articleId) async {
    try {
      final JwtToken accessToken = await _authManager.loadAccessToken();
      await _unionRepository.memberUnionMeeting(accessToken, articleId);
    } catch (error) {
      try {
        final JwtToken accessToken = await _authManager.authorizeRefreshToken();
        await _unionRepository.memberUnionMeeting(accessToken, articleId);
      } catch (error) {
        throw error;
      }
    }
  }

  Future<void> memberSingleMeeting(int articleId) async {
    try {
      final JwtToken accessToken = await _authManager.loadAccessToken();
      await _unionRepository.memberSingleMeeting(accessToken, articleId);
    } catch (error) {
      try {
        final JwtToken accessToken = await _authManager.authorizeRefreshToken();
        await _unionRepository.memberSingleMeeting(accessToken, articleId);
      } catch (error) {
        throw error;
      }
    }
  }

  Future<void> deleteMemberUnionMeeting(int articleId) async {
    try {
      final JwtToken accessToken = await _authManager.loadAccessToken();
      await _unionRepository.deleteMemberUnionMeeting(accessToken, articleId);
    } catch (error) {
      try {
        final JwtToken accessToken = await _authManager.authorizeRefreshToken();
        await _unionRepository.deleteMemberUnionMeeting(accessToken, articleId);
      } catch (error) {
        throw error;
      }
    }
  }

  Future<void> deleteMemberSingleMeeting(int articleId) async {
    try {
      final JwtToken accessToken = await _authManager.loadAccessToken();
      await _unionRepository.deleteMemberSingleMeeting(accessToken, articleId);
    } catch (error) {
      try {
        final JwtToken accessToken = await _authManager.authorizeRefreshToken();
        await _unionRepository.deleteMemberSingleMeeting(accessToken, articleId);
      } catch (error) {
        throw error;
      }
    }
  }

  Future<List<SingleMeeting>> getSingleMeetingsSearch(int communityId) async {
    try {
      final JwtToken accessToken = await _authManager.loadAccessToken();
      return await _unionRepository.getSingleMeetingsSearch(accessToken,communityId);
    } catch (error) {
      try {
        final JwtToken accessToken = await _authManager.authorizeRefreshToken();
        return await _unionRepository.getSingleMeetingsSearch(accessToken,communityId);
      } catch (error) {
        throw error;
      }
    }
  }
  Future<List<UnionMeeting>> getUnionMeetingsSearch(List<int> communityIds) async {
    if (communityIds.length == 1){
      try {
        final JwtToken accessToken = await _authManager.loadAccessToken();
        return await _unionRepository.getUnionMeetingsSearchOne(accessToken,communityIds.first);
      } catch (error) {
        try {
          final JwtToken accessToken = await _authManager.authorizeRefreshToken();
          return await _unionRepository.getUnionMeetingsSearchOne(accessToken,communityIds.first);
        } catch (error) {
          throw error;
        }
      }
    }
    if (communityIds.length == 2){
      try {
        final JwtToken accessToken = await _authManager.loadAccessToken();
        return await _unionRepository.getUnionMeetingsSearchTwo(accessToken,communityIds.first,communityIds.last);
      } catch (error) {
        try {
          final JwtToken accessToken = await _authManager.authorizeRefreshToken();
          return await _unionRepository.getUnionMeetingsSearchTwo(accessToken,communityIds.first,communityIds.last);
        } catch (error) {
          throw error;
        }
      }
    }
    else{
      throw Exception();
    }
  }
}
