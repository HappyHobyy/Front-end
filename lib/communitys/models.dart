abstract class Community {
  String get communityName;

  int get communityId;
}

class PopularCommunity implements Community {
  final int communityId;
  final String communityName;

  PopularCommunity({
    required this.communityId,
    required this.communityName,
  });

  factory PopularCommunity.fromJson(Map<String, dynamic> json) {
    return PopularCommunity(
      communityId: json['communityId'] ?? 0,
      communityName: json['communityName'] ?? '',
    );
  }
}

class MyCommunity implements Community {
  final int communityId;
  final String communityName;

  MyCommunity({
    required this.communityId,
    required this.communityName,
  });

  factory MyCommunity.fromJson(Map<String, dynamic> json) {
    return MyCommunity(
      communityId: json['communityId'] ?? 0,
      communityName: json['communityName'] ?? '',
    );
  }
}
