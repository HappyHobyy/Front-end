import 'dart:io';

class HLogPostRequest {
  final int communityId;
  final String text;
  final List<File>? files;

  HLogPostRequest({
    required this.communityId,
    required this.text,
    required this.files,
  });

  Map<String, dynamic> toJson() {
    return {
      'communityId': communityId,
      'text': text,
    };
  }
}


class HLogDeleteRequest {
  final int articleId;

  HLogDeleteRequest({required this.articleId});

  Map<String, dynamic> toJson() {
    return {
      'articleId': articleId,
    };
  }
}

class likeDeleteRequest {
  final int articleId;

  likeDeleteRequest({required this.articleId});

  Map<String, dynamic> toJson() {
    return {
      'articleId': articleId,
    };
  }
}

class HLogLikeRequest {
  final int articleId;

  HLogLikeRequest({required this.articleId});

  Map<String, dynamic> toJson() {
    return {
      'articleId': articleId,
    };
  }
}

class HLogArticle {
  final int photoArticleId;
  final String date;
  final String nickname;
  final int likes;
  final int comments;
  final String text;
  final List<HLogImage> images;
  final bool isUserArticleOwner;
  final bool isUserLiked;
  final String userImageUrl;

  HLogArticle({
    required this.photoArticleId,
    required this.date,
    required this.nickname,
    required this.likes,
    required this.comments,
    required this.text,
    required this.images,
    required this.isUserArticleOwner,
    required this.isUserLiked,
    required this.userImageUrl,
  });

  factory HLogArticle.fromJson(Map<String, dynamic> json) {
    return HLogArticle(
      photoArticleId: json['photoArticleId'],
      date: parseToCustomizeDate(DateTime.parse(json['date'])),
      nickname: json['nickname'],
      likes: json['likes'],
      comments: json['comments'],
      text: json['text'],
      images: (json['images'] as List<dynamic>)
          .map((item) => HLogImage.fromJson(item))
          .toList(),
      isUserArticleOwner: json['isUserArticleOwner'],
      isUserLiked: json['isUserLiked'],
      userImageUrl: json['userImageUrl']
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

class HLogImage {
  final int index;
  final String path;

  HLogImage({required this.index, required this.path});

  factory HLogImage.fromJson(Map<String, dynamic> json) {
    return HLogImage(
      index: json['index'],
      path: json['path'],
    );
  }
}
