class Community {
  final int communityId;
  final String communityName;

  Community({
    required this.communityId,
    required this.communityName,
  });

  factory Community.fromJson(Map<String, dynamic> json) {
    return Community(
      communityId: json['communityId'] ?? 0,
      communityName: json['communityName'] ?? '',
    );
  }
}