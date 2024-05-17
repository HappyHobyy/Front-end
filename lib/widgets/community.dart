import 'package:flutter/material.dart';
import 'package:hobbyhobby/communitys/community_home.dart';
import 'package:hobbyhobby/communitys/second_root_page.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // 다음 페이지로 이동하는 코드
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondRootPage()),
            );
          },
          child: Text('커뮤니티 페이지로 이동'),
        ),
      ),
    );
  }
}
