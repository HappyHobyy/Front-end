abstract class Community {
  String get communityName;

  String get imageUrl;

  int get communityId;
}

class PopularCommunity implements Community {
  final int communityId;
  final String communityName;
  final String imageUrl;

  PopularCommunity({
    required this.communityId,
    required this.communityName,
    required this.imageUrl,
  });

  factory PopularCommunity.fromJson(Map<String, dynamic> json) {
    return PopularCommunity(
      communityId: json['communityId'],
      communityName: json['communityName'],
      imageUrl: json['imageUrl'],
    );
  }
}

class MyCommunity implements Community {
  final int communityId;
  final String communityName;
  final String imageUrl;
  final int userHistoryCount;

  MyCommunity({
    required this.communityId,
    required this.communityName,
    required this.imageUrl,
    required this.userHistoryCount,
  });

  factory MyCommunity.fromJson(Map<String, dynamic> json) {
    return MyCommunity(
      communityId: json['communityId'],
      communityName: json['communityName'],
      imageUrl: json['imageUrl'],
      userHistoryCount: json['userHistoryCount'],
    );
  }
}
