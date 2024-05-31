import 'package:flutter/material.dart';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hobbyhobby/communitys/second_root_page.dart';
import 'package:hobbyhobby/constants.dart';
import 'package:hobbyhobby/communitys/hlog_model.dart';
import 'package:hobbyhobby/Auth/auth_manager.dart';
import 'package:hobbyhobby/Auth/jwt_token_model.dart';
import 'package:hobbyhobby/communitys/hlog_remote_api.dart';

class HlogWritePage extends StatefulWidget {
  final AuthManager authManager;
  final List<File>? images;
  final String communityName;
  final int communityID;

  const HlogWritePage({Key? key, required this.authManager, required this.images,
  required this.communityName, required this.communityID}) : super(key: key);

  @override
  State<HlogWritePage> createState() => _HlogWritePageState();
}

class _HlogWritePageState extends State<HlogWritePage> {
  TextEditingController _textEditingController = TextEditingController();
  int _currentImageIndex = 0;
  late AuthManager _authManager;
  late Future<JwtToken> jwtTokenFuture;
  late HlogRemoteApi _hlogRemoteApi;

  @override
  void initState() {
    super.initState();
    _authManager = widget.authManager;
    jwtTokenFuture = _authManager.loadAccessToken();
    _hlogRemoteApi = HlogRemoteApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '풋살',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        scrolledUnderElevation: 0,
        actions: [
          Row(
          children: [
          TextButton(
            onPressed: () async {
              // 현재 사용자의 액세스 토큰을 가져옵니다.
             try {
               JwtToken jwtToken = await jwtTokenFuture;

               HLogPostRequest postRequest = HLogPostRequest(
                 communityId: widget.communityID,
                 text: _textEditingController.text,
                 files: widget.images,
               );
               // 게시글을 저장하는 메서드 호출
               await _hlogRemoteApi.savePost(jwtToken, postRequest, widget.images ?? []);
               Navigator.push(
                 context,
                 MaterialPageRoute(
                   builder: (context) =>
                       SecondRootPage(authManager: _authManager,
                           communityName: widget.communityName,
                           communityID: widget.communityID),
                 ),
               );
             } catch (e) {
               print('오류 발생: $e');
             }
            },
            child: Text(
              'Done',
              style: TextStyle(
                color: Constants.primaryColor,
                fontSize: 15,
              ),
            ),
          ),
              SizedBox(width: 10),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.images != null && widget.images!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            height: 250.0,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: false,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentImageIndex = index;
                              });
                            },
                          ),
                          items: widget.images!.map((image) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: Image.file(image),
                                );
                              },
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: widget.images!.asMap().entries.map((entry) {
                            return Container(
                              width: 8.0,
                              height: 8.0,
                              margin: EdgeInsets.symmetric(horizontal: 4.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentImageIndex == entry.key
                                    ? Constants.primaryColor
                                    : Colors.grey,
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            TextField(
              controller: _textEditingController,
              maxLines: null,
              decoration: InputDecoration(
                hintText: '내용을 입력하세요.',
                border: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
