// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hobbyhobby/Auth/auth_manager.dart';
import 'package:hobbyhobby/Auth/auth_repository.dart';
import 'package:hobbyhobby/Auth/explanation.dart';
import 'package:hobbyhobby/constants.dart';
import 'package:page_transition/page_transition.dart';
import '../Auth/auth_remote_api.dart';
import '../DataSource/local_data_storage.dart';

int postsNum = 1;
int likesNum = 10;
int commentsNum = 0;
String userName = '뉴트리아';
String userEmail = 'qkrwldn2010@naver.com';
AssetImage userImage = AssetImage('assets/마이페이지예시.png');

class MyPage extends StatefulWidget {
  final AuthManager authManager;

  const MyPage({Key? key, required this.authManager}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  late AuthManager _authManager;
  late AuthRepository _authRepository;

  @override
  void initState() {
    super.initState();
    _authRepository = AuthRepository(LocalDataStorage(), AuthRemoteApi());
    _authManager = widget.authManager;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          // splashColor: Colors.transparent,
          // highlightColor: Colors.transparent,
          ),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            '마이페이지',
            style: Constants.titleTextStyle,
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Icon(Icons.settings),
            ),
          ],
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 16),
              CircleAvatar(
                radius: 50,
                backgroundImage: userImage,
              ),
              SizedBox(height: 7),

              Text(
                userName,
                style: TextStyle(
                  fontSize: 24,
                  // fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 0),
              Text(
                userEmail,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(
                height: 32,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 20,
                child: Card(
                  surfaceTintColor: Color(0xFFfffbfe),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "게시물",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                postsNum.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Constants.primaryColor,
                                ),
                              )
                            ],
                          ),
                        ),
                        const VerticalDivider(),
                        Container(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Text(
                                  "좋아요",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  likesNum.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Constants.primaryColor,
                                  ),
                                )
                              ],
                            )),
                        const VerticalDivider(),
                        Container(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Text(
                                  "댓글",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  commentsNum.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Constants.primaryColor,
                                  ),
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12), // Add some space before the ListView

              SizedBox(
                width: MediaQuery.of(context).size.width - 20,
                child: Card(
                  surfaceTintColor: Colors.white,
                  child: Column(
                    children: ListTile.divideTiles(context: context, tiles: [
                      ListTile(
                        leading: Icon(CupertinoIcons.person),
                        title: Text('프로필 수정'),
                        trailing: const Icon(Icons.navigate_next),
                        onTap: () {
                          // Handle Edit Profile tap
                        },
                      ),
                      ListTile(
                        leading: Icon(CupertinoIcons.star),
                        title: Text('즐겨찾기 커뮤니티'),
                        trailing: const Icon(Icons.navigate_next),
                        onTap: () {
                          // Handle Favorite Community tap
                        },
                      ),
                      ListTile(
                        leading: Icon(CupertinoIcons.question_circle),
                        trailing: const Icon(Icons.navigate_next),
                        title: Text('고객센터'),
                        onTap: () {
                          // Handle Customer Support tap
                        },
                      ),
                      ListTile(
                        leading: Icon(CupertinoIcons.exclamationmark_bubble),
                        trailing: const Icon(Icons.navigate_next),
                        title: Text('공지사항'),
                        onTap: () {
                          // Handle Announcements tap
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.logout),
                        trailing: const Icon(Icons.navigate_next),
                        title: Text('로그아웃'),
                        onTap: () {
                          _authManager.removeToken();
                          Navigator.pushReplacement(
                            context,
                            PageTransition(
                              child: ExplanationPage(
                                  authRepository: _authRepository,
                                  authManager: _authManager),
                              type: PageTransitionType.rightToLeftWithFade,
                              duration: Duration(milliseconds: 300),
                            ),
                          );},
                      ),
                    ]).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
