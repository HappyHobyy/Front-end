import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:hobbyhobby/communitys/hlog_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hobbyhobby/constants.dart';
import 'package:hobbyhobby/communitys/hlog_remote_api.dart';
import 'package:hobbyhobby/Auth/auth_manager.dart';
import 'package:hobbyhobby/Auth/jwt_token_model.dart';

class HlogPage extends StatefulWidget {
  final String userUrl;
  final String userName;
  final List<String> images;
  final int countLikes;
  final String writeTime;
  final String articleText;
  final String communityName;
  final int articleId;
  final AuthManager authManager;
  final bool isUserLiked;
  final bool isUserArticleOwner;
  final VoidCallback onDelete;
  const HlogPage({
    super.key,
    required this.userUrl,
    required this.userName,
    required this.images,
    required this.countLikes,
    required this.writeTime,
    required this.articleText,
    required this.communityName,
    required this.articleId,
    required this.authManager,
    required this.isUserLiked,
    required this.isUserArticleOwner,
    required this.onDelete,
  });

  @override
  State<HlogPage> createState() => _HlogPageState();
}

class _HlogPageState extends State<HlogPage> {
  int _current = 0;
  late bool _isFavorited;
  bool _isBookmarked = false;
  late HlogRemoteApi _hlogRemoteApi;
  late AuthManager _authManager;
  late Future<JwtToken> jwtTokenFuture;
  late int _countLikes;

  @override
  void initState() {
    super.initState();
    _authManager = widget.authManager;
    jwtTokenFuture = _authManager.loadAccessToken();
    _hlogRemoteApi = HlogRemoteApi();
    _isFavorited = widget.isUserLiked;
    _countLikes = widget.countLikes;
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0), // 모서리를 둥글게 설정
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // 그림자 색상
                spreadRadius: 5, // 그림자 퍼지는 정도
                blurRadius: 10, // 그림자 흐림 정도
                offset: Offset(0, 3), // 그림자 위치 조정
              ),
            ],
          ),
          child: Column(
            children: [
              _header(),
              _images(screenSize.width),
              _options(),
              _comment(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 8.0, top: 8.0, bottom: 8.0),
              child: ClipOval( //프로필 사진
              child: CachedNetworkImage(
              imageUrl: widget.userUrl,
              width: 33, // 원하는 크기로 설정
              height: 33, // 원하는 크기로 설정
              fit: BoxFit.cover,
              ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.userName, // 계정 이름
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    widget.communityName,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (widget.isUserArticleOwner)
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: PopupMenuButton<String>(
              onSelected: (value) async {
                if (value == 'delete') {
                  JwtToken jwtToken = await jwtTokenFuture;
                  HLogDeleteRequest hlogdeleteRequest =
                      HLogDeleteRequest(articleId: widget.articleId);
                  await _hlogRemoteApi.articleDelete(jwtToken, hlogdeleteRequest);
                  widget.onDelete();
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<String>(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete_outline),
                        const SizedBox(width: 16),
                        Text(
                            '삭제',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        ),
                      ],
                    ),
                  ),
                ];
              },
            ),
          ),
      ],
    );
  }

  Widget _images(double screenWidth) {
    return CarouselSlider.builder(
      //이미지 갯수
        itemCount: widget.images.length,
        //이미지 빌더
        itemBuilder: (context, index, realIndex) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
            child: Container(
            width: screenWidth,
            height: screenWidth,
            child: CachedNetworkImage(
              //인덱스에 해당하는 이미지 로드
              imageUrl: widget.images[index],
              fit: BoxFit.cover,
            ),
          ),
            ),
            ),
          );
        },
        // carousel_slider위젯의 여러가지 옵션 정의
        options: CarouselOptions(
          enableInfiniteScroll: false,
          aspectRatio: 1,
          viewportFraction: 1,
          onPageChanged: (index, reason) {
            setState(() {
              //인덱스 갱신
              _current = index;
            });
          },
        ));
  }

  Widget _options() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: GestureDetector(
                onTap: () async {
                  setState(() {
                    _isFavorited = !_isFavorited; // Toggle the favorite state
                    if (_isFavorited) {
                      _countLikes++; // Increment like count
                    } else {
                      _countLikes--; // Decrement like count
                    }
                  });

                  JwtToken jwtToken = await jwtTokenFuture;
                  HLogLikeRequest likeRequest = HLogLikeRequest(articleId: widget.articleId);
                  likeDeleteRequest deleteRequest = likeDeleteRequest(articleId: widget.articleId);

                  if (_isFavorited) {
                    await _hlogRemoteApi.likePost(jwtToken, likeRequest);
                  } else {
                    await _hlogRemoteApi.likeDelete(jwtToken, deleteRequest);
                  }
                },
                child: Icon(
                  _isFavorited ? Icons.favorite : Icons.favorite_border,
                  color: _isFavorited ? Colors.red : Colors.black,
                  size: 25,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:8),
              child: GestureDetector(child: Icon(Icons.mode_comment_outlined)),
            ),
            Padding(
              padding: const EdgeInsets.only(left:8, right: 20),
              child:
              GestureDetector(child: Icon(Icons.share_outlined)),
            ),
          ],
        ),
        (widget.images.length == 1)
            ? Container()
            : AnimatedSmoothIndicator(
          activeIndex: _current,
          count: widget.images.length,
          effect: ScrollingDotsEffect(
              dotColor: Colors.black26,
              activeDotColor: Constants.primaryColor,
              activeDotScale: 1,
              spacing: 4.0,
              dotWidth: 6.0,
              dotHeight: 6.0),
        ),
        Row(
          children: [
            //안보이는 아이템1
            Opacity(
              opacity: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                    child: Icon(Icons.bookmark_border)),
              ),
            ),
            //안보이는 아이템2
            Opacity(
              opacity: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                    child: Icon(Icons.bookmark_border)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isBookmarked = !_isBookmarked; // Toggle the favorite state
                  });
                },
                child: Icon(
                  _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: _isBookmarked ? Constants.primaryColor : Colors.black,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _comment() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '좋아요 ${_countLikes}개',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExpandableText(
              '${widget.articleText}',
              expandText: '더보기',
              linkColor: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4, top: 8),
            child: Text(
              '${widget.writeTime}',
              style: const TextStyle(fontSize: 10),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
