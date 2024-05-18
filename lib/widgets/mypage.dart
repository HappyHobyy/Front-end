// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

int postsNum = 0;
int likesNum = 0;
int commentsNum = 0;

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
          title: const Text(
            '마이페이지',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
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
                backgroundImage:
                    NetworkImage('https://via.placeholder.com/150'),
              ),
              SizedBox(height: 7),

              Text(
                'John Doe',
                style: TextStyle(
                  fontSize: 24,
                  // fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 0),
              Text(
                'johndoe@example.com',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [Text("게시물"), Text(postsNum.toString())],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [Text("좋아요"), Text(likesNum.toString())],
                        )),
                    Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [Text("댓글"), Text(commentsNum.toString())],
                        )),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text('게시물', textAlign: TextAlign.center),
                          onTap: () {
                            // Handle Posts tap
                          },
                        ),
                        Text(postsNum.toString()),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text('좋아요', textAlign: TextAlign.center),
                          onTap: () {
                            // Handle Likes tap
                          },
                        ),
                        Text(likesNum.toString()),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text('댓글', textAlign: TextAlign.center),
                          onTap: () {
                            // Handle Comments tap
                          },
                        ),
                        Text(commentsNum.toString()),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32), // Add some space before the ListView
              Expanded(
                child: ListView(
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
