import 'package:flutter/material.dart';
import 'package:hobbyhobby/Auth/auth_repository.dart';
import 'package:hobbyhobby/Auth/jwt_token_model.dart';

class AuthManager {
  final AuthRepository _authRepository;

  AuthManager(this._authRepository);

  //access token 오류시 refresh 토큰으로 retry 하는 함수
  Future<JwtToken> authorizeRefreshToken() async {
    try {
      final JwtToken refreshToken = await _authRepository.loadRefreshToken();
      final newAccessToken = await _authRepository.getAccessToken(refreshToken);
      _authRepository.saveAccessToken(newAccessToken);
      return newAccessToken;
    } catch (error) {
      throw error;
    }
  }
}
