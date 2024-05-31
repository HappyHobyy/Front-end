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
      popularPhotoArticles: (json['photoArticles']['popularPhotoArticle'] as List)
          .map((i) => PhotoArticle.fromJson(i))
          .toList(),
      nonePopularPhotoArticles: (json['photoArticles']['nonePopularPhotoArticle'] as List)
          .map((i) => PhotoArticle.fromJson(i))
          .toList(),
      popularGatheringArticles: (json['GatheringArticles']['popularGatheringArticle'] as List)
          .map((i) => GatheringArticle.fromJson(i))
          .toList(),
      nonePopularGatheringArticles: (json['GatheringArticles']['nonePopularGatheringArticle'] as List)
          .map((i) => GatheringArticle.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'photoArticles': {
        'popularPhotoArticle': popularPhotoArticles.map((i) => i.toJson()).toList(),
        'nonePopularPhotoArticle': nonePopularPhotoArticles.map((i) => i.toJson()).toList(),
      },
      'GatheringArticles': {
        'popularGatheringArticle': popularGatheringArticles.map((i) => i.toJson()).toList(),
        'nonePopularGatheringArticle': nonePopularGatheringArticles.map((i) => i.toJson()).toList(),
      },
    };
  }
}

class PhotoArticle {
  final int articleId;
  final DateTime date;
  final int userId;
  final String userNickName;
  final String userImagePath;
  final int likes;
  final int comments;
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
  });

  factory PhotoArticle.fromJson(Map<String, dynamic> json) {
    return PhotoArticle(
      articleId: json['articleId'],
      date: DateTime.parse(json['date']),
      userId: json['userId'],
      userNickName: json['userNickName'],
      userImagePath: json['userImagePath'],
      likes: json['likes'],
      comments: json['comments'],
      firstImageUrl: json['firstImageUrl'],
      communityId: json['communityId'],
      communityName: json['communityName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'articleId': articleId,
      'date': date.toIso8601String(),
      'userId': userId,
      'userNickName': userNickName,
      'userImagePath': userImagePath,
      'likes': likes,
      'comments': comments,
      'firstImageUrl': firstImageUrl,
      'communityId': communityId,
      'communityName': communityName,
    };
  }
}

class GatheringArticle {
  final int gatheringArticleId;
  final DateTime createdAt;
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
      createdAt: DateTime.parse(json['createdAt']),
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

  Map<String, dynamic> toJson() {
    return {
      'gatheringArticleId': gatheringArticleId,
      'createdAt': createdAt.toIso8601String(),
      'title': title,
      'userNickname': userNickname,
      'likes': likes,
      'joinMax': joinMax,
      'joinCount': joinCount,
      'communityId1': communityId1,
      'communityId2': communityId2,
      'imageUrl': imageUrl,
    };
  }
}