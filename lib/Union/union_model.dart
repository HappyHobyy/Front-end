import 'dart:ffi';

import 'package:flutter/src/widgets/editable_text.dart';

class UnionMeeting {
  final int? articleId;
  final String? imageUrl;
  final String? userNickname;
  final int? tag1;
  final int? tag2;
  final String? title;
  final int? maxPeople;
  //dateTime으로 변경
  final DateTime? createDate;
  final DateTime? meetingDate;
  final String? openTalkLink;
  final String? location;
  final String? mainText;
  final bool isUserJoined;
  final bool isUserLiked;

  UnionMeeting({
    required this.articleId,
    required this.imageUrl,
    required this.userNickname,
    required this.tag1,
    required this.tag2,
    required this.title,
    required this.maxPeople,
    required this.createDate,
    required this.meetingDate,
    required this.openTalkLink,
    required this.location,
    required this.mainText,
    required this.isUserJoined,
    required this.isUserLiked,
  });

  factory UnionMeeting.fromJson(Map<String, dynamic> json) {
    return UnionMeeting(
      articleId: json['gatheringArticleId'],
      imageUrl: json['image']['path'],
      userNickname: json['userNickname'],
      tag1: json['communityId1'],
      tag2: json['communityId2'],
      title: json['title'],
      maxPeople: json['joinMax'],
      createDate: DateTime.parse(json['createdAt']),
      meetingDate: null,
      openTalkLink: json['openTalkLink'],
      location: json['location'],
      mainText: json['text'],
      isUserJoined: json['isUserJoined'] ?? false,
      isUserLiked: json['isUserLiked'] ?? false,
    );
  }

  factory UnionMeeting.fromDetailJson(Map<String, dynamic> json) {
    return UnionMeeting(
      articleId: null,
      imageUrl: null,
      userNickname: null,
      tag1: null,
      tag2: null,
      title: null,
      maxPeople: null,
      createDate: null,
      meetingDate: DateTime.parse(json['date']),
      openTalkLink: json['openTalkLink'],
      location: json['location'],
      mainText: json['text'],
      isUserJoined: json['isUserJoined'] ?? false,
      isUserLiked: json['isUserLiked'] ?? false,
    );
  }
  Map<String, dynamic> toUnionMeetingsJson() {
    return {
      'communityId1' : tag1,
      'communityId2' : tag2,
      'title' : title,
      'date' : meetingDate?.toIso8601String(),
      'joinMax' : maxPeople,
      'text' : mainText,
      'location' : location,
      'openTalkLink' : openTalkLink,
    };
  }
}

class SingleMeeting {
  final int? articleId;
  final String? imageUrl;
  final String? userNickname;
  final int? tag1;
  final String? title;
  final int? maxPeople;
  final DateTime? createDate;
  final DateTime? meetingDate;
  final String? openTalkLink;
  final String? location;
  final String? mainText;
  final bool isUserJoined;
  final bool isUserLiked;

  SingleMeeting({
    required this.articleId,
    required this.imageUrl,
    required this.userNickname,
    required this.tag1,
    required this.title,
    required this.maxPeople,
    required this.createDate,
    required this.meetingDate,
    required this.openTalkLink,
    required this.location,
    required this.mainText,
    required this.isUserJoined,
    required this.isUserLiked,
  });

  factory SingleMeeting.fromJson(Map<String, dynamic> json) {
    return SingleMeeting(
      articleId: json['gatheringArticleId'],
      imageUrl: json['image']['path'],
      userNickname: json['userNickname'],
      tag1: json['communityId'],
      title: json['title'],
      maxPeople: json['joinMax'],
      createDate: DateTime.parse(json['createdAt']),
      meetingDate: null,
      openTalkLink: json['openTalkLink'],
      location: json['location'],
      mainText: json['text'],
      isUserJoined: json['isUserJoined'] ?? false,
      isUserLiked: json['isUserLiked'] ?? false,
    );
  }

  factory SingleMeeting.fromDetailJson(Map<String, dynamic> json) {
    return SingleMeeting(
      articleId: null,
      imageUrl: null,
      userNickname: null,
      tag1: null,
      title: null,
      maxPeople: null,
      createDate: null,
      meetingDate: DateTime.parse(json['date']),
      openTalkLink: json['openTalkLink'],
      location: json['location'],
      mainText: json['text'],
      isUserJoined: json['isUserJoined'] ?? false,
      isUserLiked: json['isUserLiked'] ?? false,
    );
  }

  Map<String, dynamic> toSingleMeetingsJson() {
    return {
      'communityId' : tag1,
      'title' : title,
      'date' : meetingDate?.toIso8601String(),
      'joinMax' : maxPeople,
      'text' : mainText,
      'location' : location,
      'openTalkLink' : openTalkLink,
    };
  }
}
