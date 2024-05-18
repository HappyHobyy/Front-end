// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hobbyhobby/constants.dart';

int postsNum = 0;
int likesNum = 0;
int commentsNum = 0;
String userName = 'John Doe';
String userEmail = 'johndoe@example.com';
NetworkImage userImage = NetworkImage('https://via.placeholder.com/150');

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          // splashColor: Colors.transparent,
          // highlightColor: Colors.transparent,
          ),
      child: Scaffold(
        appBar: AppBar(
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
                  color: const Color(0xFFfffbfe),
                  // color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("게시물"),
                            SizedBox(height: 3),
                            Text(postsNum.toString())
                          ],
                        ),
                      ),
                      const VerticalDivider(),
                      Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text("좋아요"),
                              SizedBox(height: 3),
                              Text(likesNum.toString())
                            ],
                          )),
                      const VerticalDivider(),
                      Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text("댓글"),
                              SizedBox(height: 3),
                              Text(commentsNum.toString())
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12), // Add some space before the ListView
              Expanded(
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    ListTile(
                      leading: Icon(CupertinoIcons.person),
                      title: Text('프로필 수정'),
                      onTap: () {
                        // Handle Edit Profile tap
                      },
                    ),
                    ListTile(
                      leading: Icon(CupertinoIcons.star),
                      title: Text('즐겨찾기 커뮤니티'),
                      onTap: () {
                        // Handle Edit Profile tap
                      },
                    ),
                    ListTile(
                      leading: Icon(CupertinoIcons.question_circle),
                      title: Text('고객센터'),
                      onTap: () {
                        // Handle Questions tap
                      },
                    ),
                    ListTile(
                      leading: Icon(CupertinoIcons.exclamationmark_bubble),
                      title: Text('공지사항'),
                      onTap: () {
                        // Handle Questions tap
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.logout),
                      title: Text('로그아웃'),
                      onTap: () {
                        // Handle Logout tap
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
