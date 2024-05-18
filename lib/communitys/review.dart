import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hobbyhobby/constants.dart';
import 'package:hobbyhobby/widgets/like_button.dart';

class ReviewPage extends StatefulWidget {
  final String communityName;

  const ReviewPage({super.key, required this.communityName});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
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
    return ListView(children: [
      ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            "assets/community_icons/Drawing.png",
            fit: BoxFit.cover,
          ),
        ),
        title: const Text("지냑 찰리 TF 풋살화 리뷰"),
        subtitle: const Text("축구화"),
        trailing: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                SizedBox(width: 4.0), // Add some space between icon and text
                Text("4.9"),
              ],
            ),
            SizedBox(height: 4.0), // Add some space between rows
            Text("09:41"),
          ],
        ),
      ),
      ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            "assets/community_icons/Drawing.png",
            fit: BoxFit.cover,
          ),
        ),
        title: const Text('스포츠트라이브 풋살공 리뷰'),
        subtitle: const Text("축구공"),
        trailing: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                SizedBox(width: 4.0), // Add some space between icon and text
                Text("5.0"),
              ],
            ),
            SizedBox(height: 4.0), // Add some space between rows
            Text("09:41"),
          ],
        ),
      ),
    ]);
  }
}

class ReviewPost {
  const ReviewPost();
}
