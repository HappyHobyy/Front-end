import 'package:flutter/cupertino.dart';

import '../Auth/auth_manager.dart';
import '../Auth/jwt_token_model.dart';
import '../Community/community_repository.dart';
import '../communitys/models.dart';

class TagViewModel with ChangeNotifier {
  final CommunityRepository _communityRepository;
  final AuthManager _authManager;

  TagViewModel(this._communityRepository, this._authManager);

  Future<List<Community>> getUserCommunityList() async {
    try {
      // Access Token을 불러옵니다.
      final JwtToken accessToken = await _authManager.loadAccessToken();
      return await _communityRepository.getUserCommunityList(accessToken);
    } catch (error) {
      print(error);
      try {
        final JwtToken accessToken = await _authManager.authorizeRefreshToken();
        return await _communityRepository.getUserCommunityList(accessToken);
      } catch (error) {
        print(error);
        throw error;
      }
    }
  }

  Future<List<Community>> getPopularCommunityList() async {
    try {
      // Access Token을 불러옵니다.
      final JwtToken accessToken = await _authManager.loadAccessToken();
      return await _communityRepository.getPopularCommunityList(accessToken);
    } catch (error) {
      print(error);
      try {
        final JwtToken accessToken = await _authManager.authorizeRefreshToken();
        return await _communityRepository.getPopularCommunityList(accessToken);
      } catch (error) {
        print(error);
        throw error;
      }
    }
  }
}
