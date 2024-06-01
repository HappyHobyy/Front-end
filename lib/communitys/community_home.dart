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
  final ScrollController _scrollController = ScrollController();
  bool isFetchingMore = false;
  int currentPage = 0;
  bool hasMoreArticles = true;

  @override
  void initState() {
    super.initState();
    print('CommunityHomePage initState with communityID: ${widget.communityID}');
    _authManager = widget.authManager;
    jwtTokenFuture = _authManager.loadAccessToken();
    _hlogRemoteApi = HlogRemoteApi();
    _loadRecentArticles();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent && !isLoading && hasMoreArticles) {
        _loadMoreArticles();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadRecentArticles() async {
    setState(() {
      isLoading = true;
      currentPage = 0; // 페이지를 초기화하여 처음부터 다시 로드하도록 설정
    });
    try {
      JwtToken jwtToken = await jwtTokenFuture;
      print('Fetching articles for communityID: ${widget.communityID}, currentPage: $currentPage');
      await _hlogRemoteApi.fetchRecentArticles(jwtToken, currentPage, widget.communityID);
      setState(() {
        articles = _hlogRemoteApi.articles;
        currentPage++;
        hasMoreArticles = _hlogRemoteApi.articles.length == 10;
      });
    } catch (error) {
      print('오류 발생: $error');
      // 에러 처리
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _loadMoreArticles() async {
    if (isFetchingMore) return; // 중복 호출 방지
    setState(() {
      isFetchingMore = true;
    });
    try {
      JwtToken jwtToken = await jwtTokenFuture;
      await _hlogRemoteApi.fetchRecentArticles(jwtToken, currentPage, widget.communityID);
      setState(() {
        articles.addAll(_hlogRemoteApi.articles);
        currentPage++;
        hasMoreArticles = _hlogRemoteApi.articles.length == 10;
      });
    } catch (error) {
      print('오류 발생: $error');
      // 에러 처리
    } finally {
      setState(() {
        isFetchingMore = false;
      });
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
            child: RefreshIndicator(
              onRefresh: _loadRecentArticles,
              child: _body(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _body() {
    if (isLoading && articles.isEmpty) {
      return Center(child: CircularProgressIndicator());
    } else {
      return ListView.builder(
        controller: _scrollController,
        itemCount: articles.length + (hasMoreArticles ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == articles.length) {
            return Center(child: CircularProgressIndicator());
          } else {
            final article = articles[index];
            return HlogPage(
              userUrl: article.userImageUrl,
              userName: article.nickname,
              images: article.images.map((img) => img.path).toList(),
              countLikes: article.likes,
              writeTime: article.date.toString(),
              articleText: article.text,
              communityName: widget.communityName,
              articleId: article.photoArticleId,
              authManager: _authManager,
              isUserLiked: article.isUserLiked,
              isUserArticleOwner: article.isUserArticleOwner,
              onDelete: _loadRecentArticles, // 게시물이 삭제되면 _loadRecentArticles를 호출하여 다시 로드
            );
          }
        },
      );
    }
  }
}
