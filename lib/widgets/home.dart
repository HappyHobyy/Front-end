import 'package:flutter/material.dart';
import 'package:hobbyhobby/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: EdgeInsets.only(top: 10, left: 20, right: 20),
        child: Column(
          children: [
            Row(
                children: [
                  TextButton(
                  onPressed: () {},
                  child: Text(
                    'AI 추천',
                    style: TextStyle(
                      color: Constants.textColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
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
          ],
        ),
      ),
    );
  }
}
