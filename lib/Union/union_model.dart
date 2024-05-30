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

  UnionMeeting.getUnionMeetings(
      {
        required int gatheringArticleId,
        required DateTime createdAt,
        required String title,
        required String userNickname,
        required int joinMax,
        required int communityId1,
        required int communityId2,
        required String Image,})
      : this(articleId: gatheringArticleId, imageUrl: Image, userNickname: userNickname, tag1: communityId1, tag2: communityId2, title: title,
            maxPeople: joinMax, createDate: createdAt, meetingDate: null, openTalkLink: null, location: null, mainText: null,);

  UnionMeeting.getUnionMeetingsDetail(
      {
        required DateTime date,
        required String text,
        required String location,
        required String openTalkLink,})
      : this(articleId: null, imageUrl: null, userNickname: null, tag1: null, tag2: null, title: null,
    maxPeople: null, createDate: null, meetingDate: date, openTalkLink: openTalkLink, location: location, mainText: text,);

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
  });

  factory SingleMeeting.fromJson(Map<String, dynamic> json) {
    return SingleMeeting(
      articleId: json['gatheringArticleId'],
      imageUrl: json['image']['path'],
      userNickname: json['userNickname'],
      tag1: json['communityId1'],
      title: json['title'],
      maxPeople: json['joinMax'],
      createDate: DateTime.parse(json['createdAt']),
      meetingDate: null,
      openTalkLink: json['openTalkLink'],
      location: json['location'],
      mainText: json['text'],
    );
  }

  Map<String, dynamic> toSingleMeetingsJson() {
    return {
      'communityId1' : tag1,
      'title' : title,
      'date' : meetingDate?.toIso8601String(),
      'joinMax' : maxPeople,
      'text' : mainText,
      'location' : location,
      'openTalkLink' : openTalkLink,
    };
  }
  SingleMeeting.getSingleMeetings(
      {
        required int gatheringArticleId,
        required DateTime createdAt,
        required String title,
        required String userNickname,
        required int joinMax,
        required int communityId1,
        required String Image,})
    : this(articleId: gatheringArticleId, imageUrl: Image, userNickname: userNickname, tag1: communityId1, title: title,
          maxPeople: joinMax, createDate: createdAt, meetingDate: null, openTalkLink: null, location: null, mainText: null,);

  SingleMeeting.getSingleMeetingsDetail(
      {
        required DateTime date,
        required String text,
        required String location,
        required String openTalkLink,})
      : this(articleId: null, imageUrl: null, userNickname: null, tag1: null, title: null,
    maxPeople: null, createDate: null, meetingDate: date, openTalkLink: openTalkLink, location: location, mainText: text,);

}
