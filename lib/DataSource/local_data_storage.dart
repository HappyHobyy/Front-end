import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hobbyhobby/Auth/jwt_token_model.dart';

class LocalDataStorage {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // 엑세스 토큰 저장
  Future<void> saveAccessToken(JwtToken token) async {
    await _secureStorage.write(key: 'accessToken', value: token.accessToken);
  }
  // 리프래시 토큰 저장
  Future<void> saveAllToken(JwtToken token) async {
    await _secureStorage.write(key: 'refreshToken', value: token.refreshToken);
    await _secureStorage.write(key: 'accessToken', value: token.accessToken);
  }

  // 저장된 엑세스 토큰 불러오기
  Future<JwtToken> loadAccessToken() async {
    String jwtToken = _secureStorage.read(key: 'accessToken').toString();
    return JwtToken(accessToken: jwtToken, refreshToken: null);
  }
  // 저장된 리프레쉬 톤큰 불러오기
  Future<JwtToken> loadRefreshToken() async {
    String jwtToken = _secureStorage.read(key: 'refreshToken').toString();
    return JwtToken(accessToken: null, refreshToken: jwtToken);
  }
  // 저장된 토큰 모두 삭제
  Future<void> deleteToken() async {
    await _secureStorage.delete(key: 'accessToken');
    await _secureStorage.delete(key: 'refreshToken');
  }
}
