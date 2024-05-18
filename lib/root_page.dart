import 'package:flutter/material.dart';
import 'package:hobbyhobby/widgets/community.dart';
import 'package:hobbyhobby/widgets/home.dart';
import 'package:hobbyhobby/widgets/mypage.dart';
import 'package:hobbyhobby/widgets/union.dart';
import 'package:hobbyhobby/constants.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _bottomNavIndex = 0;

  // 페이지 리스트
  List<Widget> _widgetOptions() {
    return [
      const HomePage(),
      const CommunityPage(),
      const UnionPage(),
      const MyPage(),
    ];
  }

  // 페이지 아이콘 리스트
  List<IconData> iconList = [
    Icons.home,
    Icons.forum,
    Icons.groups,
    Icons.person,
  ];

  // 네비게이션 바 제목 리스트
  List<String> titleList = [
    '메인',
    '커뮤니티',
    '연합',
    '마이페이지',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: Row(
      //       children: [
      //         const SizedBox(width: 20),
      //         Text(
      //           'Hobby',
      //           style: TextStyle(
      //             fontSize: 24,
      //             fontWeight: FontWeight.w700,
      //             letterSpacing: 0.3,
      //           ),
      //         ),
      //         Text(
      //           'Hobby',
      //           style: TextStyle(
      //             fontSize: 24,
      //             fontWeight: FontWeight.w700,
      //             color: Constants.primaryColor,
      //             letterSpacing: 0.3,
      //           ),
      //         ),
      //       ]
      //   ),
      //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      //   elevation: 0.0,
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         // 알림 버튼을 눌렀을 때 액션
      //       },
      //       icon: Icon(
      //         Icons.notifications_none,
      //         color: Colors.black,
      //         size: 30.0,
      //       ),
      //     ),
      //     const SizedBox(width: 15),
      //   ],
      // ),
      body: _widgetOptions()[_bottomNavIndex],
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: _bottomNavIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          unselectedIconTheme: const IconThemeData(color: Colors.black),
          selectedIconTheme: IconThemeData(color: Constants.primaryColor),
          items: List.generate(
            iconList.length,
            (index) => BottomNavigationBarItem(
              icon: Icon(iconList[index]),
              label: titleList[index],
            ),
          ),
        ),
      ),
    );
  }
}
