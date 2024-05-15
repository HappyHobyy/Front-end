import 'package:hobbyhobby/Auth/jwt_token_model.dart';
import 'package:hobbyhobby/Auth/user_model.dart';

import '../../DataSource/local_data_storage.dart';
import 'community_remote_api.dart';

class CommunityRepository {
  late final CommunityRemoteApi _communityRemoteApi;

  CommunityRepository(this._communityRemoteApi);

  Future<bool> getCommunityPopularContents(JwtToken jwtToken) async {
    return await _communityRemoteApi.getCommunityPopularContents(jwtToken);
  }
}
