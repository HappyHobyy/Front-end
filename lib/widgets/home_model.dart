class HomeModel {
  final List<PhotoArticle> popularPhotoArticles;
  final List<PhotoArticle> nonePopularPhotoArticles;
  final List<GatheringArticle> popularGatheringArticles;
  final List<GatheringArticle> nonePopularGatheringArticles;

  HomeModel({
    required this.popularPhotoArticles,
    required this.nonePopularPhotoArticles,
    required this.popularGatheringArticles,
    required this.nonePopularGatheringArticles,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      popularPhotoArticles: (json['data']['photoArticles']['popularPhotoArticle'] as List)
          .map((i) => PhotoArticle.fromJson(i))
          .toList(),
      nonePopularPhotoArticles: (json['data']['photoArticles']['nonePopularPhotoArticle'] as List)
          .map((i) => PhotoArticle.fromJson(i))
          .toList(),
      popularGatheringArticles: (json['data']['GatheringArticles']['popularGatheringArticle'] as List)
          .map((i) => GatheringArticle.fromJson(i))
          .toList(),
      nonePopularGatheringArticles: (json['data']['GatheringArticles']['nonePopularGatheringArticle'] as List)
          .map((i) => GatheringArticle.fromJson(i))
          .toList(),
    );
  }


}

class PhotoArticle {
  final int articleId;
  final String date;
  final int userId;
  final String userNickName;
  final String userImagePath;
  final int likes;
  final int comments;
  final String content;
  final String firstImageUrl;
  final int communityId;
  final String communityName;

  PhotoArticle({
    required this.articleId,
    required this.date,
    required this.userId,
    required this.userNickName,
    required this.userImagePath,
    required this.likes,
    required this.comments,
    required this.firstImageUrl,
    required this.communityId,
    required this.communityName,
    required this.content
  });

  factory PhotoArticle.fromJson(Map<String, dynamic> json) {
    return PhotoArticle(
        articleId: json['articleId'],
        date: parseToCustomizeDate(DateTime.parse(json['date'].split('.')[0])),
        userId: json['userId'],
        userNickName: json['userNickName'],
        userImagePath: json['userImagePath'],
        likes: json['likes'],
        comments: json['comments'],
        firstImageUrl: json['firstImageUrl'],
        communityId: json['communityId'],
        communityName: json['communityName'],
        content: json['content']
    );
  }

  static String parseToCustomizeDate(DateTime date) {
    DateTime now = DateTime.now();
    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      // 오늘 생성된 경우 시, 분 표시
      return '${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    } else {
      // 그 외의 경우 월, 일 표시
      return '${date.month}/${date.day}';
    }
  }
}

class GatheringArticle {
  final int gatheringArticleId;
  final String createdAt;
  final String title;
  final String userNickname;
  final int likes;
  final int joinMax;
  final int joinCount;
  final int communityId1;
  final int communityId2;
  final String imageUrl;

  GatheringArticle({
    required this.gatheringArticleId,
    required this.createdAt,
    required this.title,
    required this.userNickname,
    required this.likes,
    required this.joinMax,
    required this.joinCount,
    required this.communityId1,
    required this.communityId2,
    required this.imageUrl,
  });

  factory GatheringArticle.fromJson(Map<String, dynamic> json) {
    return GatheringArticle(
      gatheringArticleId: json['gatheringArticleId'],
      createdAt: parseToCustomizeDate(DateTime.parse(json['createdAt'].split('.')[0])),
      title: json['title'],
      userNickname: json['userNickname'],
      likes: json['likes'],
      joinMax: json['joinMax'],
      joinCount: json['joinCount'],
      communityId1: json['communityId1'],
      communityId2: json['communityId2'],
      imageUrl: json['imageUrl'],
    );
  }

  static String parseToCustomizeDate(DateTime date) {
    DateTime now = DateTime.now();
    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      // 오늘 생성된 경우 시, 분 표시
      return '${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    } else {
      // 그 외의 경우 월, 일 표시
      return '${date.month}/${date.day}';
    }
  }
}