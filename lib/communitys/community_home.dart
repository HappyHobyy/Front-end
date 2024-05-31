import 'package:flutter/material.dart';
import 'package:hobbyhobby/communitys/hlog.dart';
import 'package:hobbyhobby/communitys/hlog_write.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:hobbyhobby/communitys/hlog_model.dart';
import 'package:hobbyhobby/Auth/auth_manager.dart';
import 'package:hobbyhobby/Auth/jwt_token_model.dart';
import 'package:hobbyhobby/communitys/hlog_remote_api.dart';
import '../root_page.dart';


class CommunityHomePage extends StatefulWidget {
  final AuthManager authManager;
  final String communityName;
  final int communityID;

  const CommunityHomePage({super.key, required this.authManager, required this.communityName, required this.communityID});

  @override
  _CommunityHomePageState createState() => _CommunityHomePageState();
}

class _CommunityHomePageState extends State<CommunityHomePage> {
  late AuthManager _authManager;
  late Future<JwtToken> jwtTokenFuture;
  late HlogRemoteApi _hlogRemoteApi;

  List<HLogArticle> articles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _authManager = widget.authManager;
    jwtTokenFuture = _authManager.loadAccessToken();
    _hlogRemoteApi = HlogRemoteApi();
    _loadRecentArticles();
  }

  Future<void> _loadRecentArticles() async {
    try {
      // 현재 사용자의 액세스 토큰을 가져옵니다.
      JwtToken jwtToken = await jwtTokenFuture;

      // 최신 게시물 가져오기
      await _hlogRemoteApi.fetchRecentArticles(jwtToken, 0, widget.communityID);

      // 게시물을 가져오고 상태를 갱신하여 화면에 반영합니다.
      setState(() {
        isLoading = false;
        articles = _hlogRemoteApi.articles;
      });
    } catch (error) {
      print('오류 발생: $error');
      // 에러 처리
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage();

    if (pickedImages != null && pickedImages.isNotEmpty) {
      List<File> images = pickedImages.map((pickedFile) => File(pickedFile.path)).toList();


      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HlogWritePage(images: images, authManager: _authManager, communityName: widget.communityName, communityID: widget.communityID),
        ),
      );
    } else {
      print('이미지가 선택되지 않았습니다.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RootPage(authManager: _authManager, initialIndex: 1),
              ),
            );
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          widget.communityName,
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        scrolledUnderElevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 5),
            child: Row(
              children: [
                Image.asset(
                  'assets/logo.png',
                  width: 120,
                ),
                Spacer(),
                IconButton(
                  onPressed: _pickImage,
                  icon: Icon(Icons.edit),
                ),
              ],
            ),
          ),
          Expanded(
            child: _body(),
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
        return HlogPage(
          userUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnnnObTCNg1QJoEd9Krwl3kSUnPYTZrxb5Ig&usqp=CAU',
          userName: article.nickname,
          images: article.images.map((img) => img.path).toList(),
          countLikes: article.likes,
          writeTime: article.date.toString(),
          articleText: article.text,
          communityName: widget.communityName,
        );
      },
    );
  }
}
