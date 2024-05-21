import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hobbyhobby/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:hobbyhobby/Recommendation/test.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<int> _currentList = List.generate(4, (index) => 0); // 4개의 캐러셀 슬라이더를 위한 리스트

  final List<String> images = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnnnObTCNg1QJoEd9Krwl3kSUnPYTZrxb5Ig&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRisv-yQgXGrto6OxQxX62JyvyQGvRsQQ760g&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQifBWUhSiSfL0t8M3XCOe8aIyS6de2xWrt5A&usqp=CAU',
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
            children: [
              const SizedBox(width: 10),
              Image.asset(
                  'assets/logo.png',
              width: 130),
            ]
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
                      builder: (context) => TestPage(),
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
              CarouselSlider.builder(
                itemCount: images.length,
                itemBuilder: (context, index, realIndex) {
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          width: screenWidth,
                          height: screenWidth,
                          child: CachedNetworkImage(
                            imageUrl: images[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 15,
                        right: 15,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.only(left: 8, right: 10, top: 3),
                          child: Text(
                            '#취미',
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
                        _currentList[0] = index;
                      });
                    },
                  ),
                ),
              const SizedBox(height: 10),
              Center(
                child: AnimatedSmoothIndicator(
                activeIndex: _currentList[0],
                count: images.length,
                effect: ScrollingDotsEffect(
                    dotColor: Colors.black26,
                    activeDotColor: Constants.primaryColor,
                    activeDotScale: 1,
                    spacing: 4.0,
                    dotWidth: 6.0,
                    dotHeight: 6.0),
              ),
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('아이디입니다.'),
                      Text('내용입니다.'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CarouselSlider.builder(
                itemCount: images.length,
                itemBuilder: (context, index, realIndex) {
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          width: screenWidth,
                          height: screenWidth,
                          child: CachedNetworkImage(
                            imageUrl: images[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 15,
                        right: 15,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.only(left: 8, right: 10, top: 3),
                          child: Text(
                            '#취미',
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
                      _currentList[1] = index;
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: AnimatedSmoothIndicator(
                  activeIndex: _currentList[1],
                  count: images.length,
                  effect: ScrollingDotsEffect(
                      dotColor: Colors.black26,
                      activeDotColor: Constants.primaryColor,
                      activeDotScale: 1,
                      spacing: 4.0,
                      dotWidth: 6.0,
                      dotHeight: 6.0),
                ),
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('아이디입니다.'),
                      Text('내용입니다.'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CarouselSlider.builder(
                itemCount: images.length,
                itemBuilder: (context, index, realIndex) {
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          width: screenWidth,
                          height: screenWidth,
                          child: CachedNetworkImage(
                            imageUrl: images[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 15,
                        right: 15,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.only(left: 8, right: 10, top: 3),
                          child: Text(
                            '#취미',
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
                      _currentList[2] = index;
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: AnimatedSmoothIndicator(
                  activeIndex: _currentList[2],
                  count: images.length,
                  effect: ScrollingDotsEffect(
                      dotColor: Colors.black26,
                      activeDotColor: Constants.primaryColor,
                      activeDotScale: 1,
                      spacing: 4.0,
                      dotWidth: 6.0,
                      dotHeight: 6.0),
                ),
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('아이디입니다.'),
                      Text('내용입니다.'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CarouselSlider.builder(
                itemCount: images.length,
                itemBuilder: (context, index, realIndex) {
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          width: screenWidth,
                          height: screenWidth,
                          child: CachedNetworkImage(
                            imageUrl: images[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 15,
                        right: 15,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.only(left: 8, right: 10, top: 3),
                          child: Text(
                            '#취미',
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
                      _currentList[3] = index;
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: AnimatedSmoothIndicator(
                  activeIndex: _currentList[3],
                  count: images.length,
                  effect: ScrollingDotsEffect(
                      dotColor: Colors.black26,
                      activeDotColor: Constants.primaryColor,
                      activeDotScale: 1,
                      spacing: 4.0,
                      dotWidth: 6.0,
                      dotHeight: 6.0),
                ),
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('아이디입니다.'),
                      Text('내용입니다.'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ],
            ),
          ),
      ),
    );
  }
}
