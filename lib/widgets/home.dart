import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hobbyhobby/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hobbyhobby/widgets/home_remote_api.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:hobbyhobby/Recommendation/test.dart';
import 'package:hobbyhobby/widgets/home_model.dart';
import 'package:hobbyhobby/Auth/auth_manager.dart';
import 'package:hobbyhobby/Auth/jwt_token_model.dart';
import 'package:hobbyhobby/constants.dart';

class HomePage extends StatefulWidget {
  final AuthManager authManager;

  const HomePage({super.key, required this.authManager});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AuthManager _authManager;
  late Future<JwtToken> jwtTokenFuture;
  late HomeRemoteApi _homeRemoteApi;
  List<int> _currentList =
      List.generate(4, (index) => 0); // 4개의 캐러셀 슬라이더를 위한 리스트
  HomeModel? homeData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _authManager = widget.authManager;
    jwtTokenFuture = _authManager.loadAccessToken();
    _homeRemoteApi = HomeRemoteApi();
    fetchHomeData();
  }

  Future<void> fetchHomeData() async {
    try {
      JwtToken jwtToken = await jwtTokenFuture;
      HomeModel? data = await _homeRemoteApi.popularContentsArticles(jwtToken);
      setState(() {
        homeData = data;
        isLoading = false;
      });
    } catch (e) {
      print('오류 발생: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              const SizedBox(width: 10),
              Image.asset('assets/logo.png', width: 130),
            ],
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0.0,
          actions: [
            IconButton(
              onPressed: () {
                // 알림 버튼을 눌렀을 때 액션
              },
              icon: Icon(
                Icons.notifications_none,
                color: Colors.black,
                size: 30.0,
              ),
            ),
            const SizedBox(width: 15),
          ],
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const SizedBox(width: 10),
            Image.asset('assets/logo.png', width: 130),
          ],
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () {
              // 알림 버튼을 눌렀을 때 액션
            },
            icon: Icon(
              Icons.notifications_none,
              color: Colors.black,
              size: 30.0,
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'AI 추천',
                    style: TextStyle(
                      color: Constants.textColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    '으로 새로운 취미를',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Text(
                '발견하세요.',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TestPage(authManager: _authManager),
                    ),
                  );
                },
                child: Image.asset(
                  'assets/hobby_test.png',
                  width: screenWidth,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    '커뮤니티',
                    style: TextStyle(
                      color: Constants.textColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    '를 통해 취미 경험을',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Text(
                '들려주세요.',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              _buildPhotoCarouselSlider(
                  homeData?.popularPhotoArticles ?? [], screenWidth, 0),
              _buildPhotoCarouselSlider(
                  homeData?.nonePopularPhotoArticles ?? [], screenWidth, 1),
              _buildGatheringCarouselSlider(
                  homeData?.popularGatheringArticles ?? [], screenWidth, 2),
              _buildGatheringCarouselSlider(
                  homeData?.nonePopularGatheringArticles ?? [], screenWidth, 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoCarouselSlider(
      List<PhotoArticle> articles, double screenWidth, int sliderIndex) {
    if (articles.isEmpty) {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider.builder(
          itemCount: articles.length,
          itemBuilder: (context, index, realIndex) {
            final article = articles[index];
            return Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Container(
                    width: screenWidth,
                    height: screenWidth,
                    child: CachedNetworkImage(
                      imageUrl: article.firstImageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 15,
                  right: 15,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.only(left: 8, right: 10, top: 3),
                    child: Text(
                      '#${article.communityName}',
                      style: TextStyle(
                        color: Constants.textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          options: CarouselOptions(
            enableInfiniteScroll: false,
            aspectRatio: 1,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                _currentList[sliderIndex] = index;
              });
            },
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: AnimatedSmoothIndicator(
            activeIndex: _currentList[sliderIndex],
            count: articles.length,
            effect: ScrollingDotsEffect(
              dotColor: Colors.black26,
              activeDotColor: Constants.primaryColor,
              activeDotScale: 1,
              spacing: 4.0,
              dotWidth: 6.0,
              dotHeight: 6.0,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8.0, right: 8.0),
          child: Row(
            children: [
              Text('${articles[_currentList[sliderIndex]].userNickName}'),
              Spacer(),
              Text(
                '좋아요 ${articles[_currentList[sliderIndex]].likes}개',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            '${articles[_currentList[sliderIndex]].comments}',
            style: TextStyle(fontSize: 16),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                '${articles[_currentList[sliderIndex]].date}',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildGatheringCarouselSlider(
      List<GatheringArticle> articles, double screenWidth, int sliderIndex) {
    if (articles.isEmpty) {
      return Container();
    }

    List<String> hobbyKeys = Constants.hobbyImageMap.keys.toList();
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: articles.length,
          itemBuilder: (context, index, realIndex) {
            final article = articles[index];
            return Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Container(
                    width: screenWidth,
                    height: screenWidth,
                    child: CachedNetworkImage(
                      imageUrl: article.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 15,
                  right: 15,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.only(left: 8, right: 10, top: 3),
                    child: Text(
                      '#${hobbyKeys[article.communityId1]} #${hobbyKeys[article.communityId2]}',
                      style: TextStyle(
                        color: Constants.textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          options: CarouselOptions(
            enableInfiniteScroll: false,
            aspectRatio: 1,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                _currentList[sliderIndex] = index;
              });
            },
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: AnimatedSmoothIndicator(
            activeIndex: _currentList[sliderIndex],
            count: articles.length,
            effect: ScrollingDotsEffect(
              dotColor: Colors.black26,
              activeDotColor: Constants.primaryColor,
              activeDotScale: 1,
              spacing: 4.0,
              dotWidth: 6.0,
              dotHeight: 6.0,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8.0, right: 8.0),
          child: Row(
            children: [
              Text('${articles[_currentList[sliderIndex]].userNickname}'),
              Spacer(),
              Text(
                '좋아요 ${articles[_currentList[sliderIndex]].likes}개',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.0, left: 8.0),
          child: Text(
            '${articles[_currentList[sliderIndex]].title}',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                  '모집 인원 : ${articles[_currentList[sliderIndex]].joinCount} / ${articles[_currentList[sliderIndex]].joinMax}명'),
              Spacer(),
              Text(
                '${articles[_currentList[sliderIndex]].createdAt.toLocal()}',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
