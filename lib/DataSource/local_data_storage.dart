import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalDataSource {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  // 엑세스 토큰 저장
  Future<void> saveAccessToken(String token) async {
    await _secureStorage.write(key: 'access_token', value: token);
  }
  // 리프래시 토큰 저장
  Future<void> saveRefreshToken(String token) async {
    await _secureStorage.write(key: 'refresh_token', value: token);
  }

  // 저장된 엑세스 토큰 불러오기
  Future<String?> loadAccessToken() async {
    return await _secureStorage.read(key: 'access_token');
  }
  // 저장된 리프레쉬 톤큰 불러오기
  Future<String?> loadRefreshToken() async {
    return await _secureStorage.read(key: 'refresh_token');
  }
  // 저장된 토큰 모두 삭제
  Future<void> deleteToken() async {
    await _secureStorage.delete(key: 'access_token');
    await _secureStorage.delete(key: 'refresh_token');
  }
}
