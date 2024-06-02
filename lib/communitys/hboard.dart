import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../widgets/like_button.dart';
import 'hboard_detail_page.dart';

class HboardPage extends StatefulWidget {
  final String communityName;

  const HboardPage({super.key, required this.communityName});

  @override
  State<HboardPage> createState() => _HboardPageState();
}

class _HboardPageState extends State<HboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.communityName,
          style: Constants.titleTextStyle,
        ),
        actions: const [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: LikeButton()),
        ],
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
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(CupertinoIcons.pencil),
                  onPressed: () {},
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
    List<PostData> postDataList = [
      PostData(title: "오늘의 풋살 후기", author: "드리븐마스터", time: "09:41"),
      PostData(title: "안녕하세요!", author: "터치마에스트로", time: "09:30"),
      PostData(title: "게시물 예시_2", author: "작성자이름", time: "08:16"),
    ];

    return ListView.separated(
      itemCount: postDataList.length,
      itemBuilder: (context, index) {
        final postData = postDataList[index];
        return ListTile(
          // Use data from postData object to populate the list tile
          title: Text(postData.title),
          subtitle: Row(
            children: [
              Text(postData.author),
              SizedBox(width: 5),
              Row(
                children: [
                  Icon(Icons.favorite, size: 16, color: Colors.red),
                  SizedBox(width: 2),
                  Text("3"),
                ],
              ),
              SizedBox(width: 5),
              Row(
                children: [
                  Icon(Icons.comment, size: 16),
                  SizedBox(width: 2),
                  Text("3"),
                ],
              ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 18.0),
              Text(postData.time),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(
                  communityName: widget.communityName,
                  postTitle: postData.title,
                  authorName: postData.author,
                  postTime: postData.time,
                ),
              ),
            );
          },
        );
      },
      separatorBuilder: (context, index) => Divider(color: Colors.grey[200]),
    );
  }
}

class PostData {
  final String title;
  final String author;
  final String time;

  PostData({
    required this.title,
    required this.author,
    required this.time,
  });
}
