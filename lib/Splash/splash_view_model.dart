import 'package:flutter/material.dart';
import 'package:hobbyhobby/Auth/auth_manager.dart';
import 'package:hobbyhobby/Auth/auth_repository.dart';
import 'package:hobbyhobby/Auth/jwt_token_model.dart';

import '../Community/community_repository.dart';

enum AuthState { uninitialized, authenticated, unauthenticated }

class SplashViewModel with ChangeNotifier {
  final AuthRepository _authRepository;
  final CommunityRepository _communityRepository;
  final AuthManager _authManager;
  AuthState _authState = AuthState.uninitialized;

  SplashViewModel(
      this._authRepository, this._authManager, this._communityRepository);

  AuthState get authState => _authState;

  Future<void> checkAuthentication() async {
    try {
      // 1. Access Token을 불러옵니다.
      final JwtToken accessToken = await _authRepository.loadAccessToken();
      await _communityRepository.getCommunityPopularContents(accessToken);
      _authState = AuthState.authenticated;
    } catch (error) {
      try {
        final JwtToken accessToken = await _authManager.authorizeRefreshToken();
        await _communityRepository.getCommunityPopularContents(accessToken);
        _authState = AuthState.authenticated;
      } catch (error) {
        _authState = AuthState.unauthenticated;
      }
    }
    notifyListeners();
  }
}
