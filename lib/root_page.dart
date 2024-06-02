import 'package:flutter/material.dart';
import 'package:hobbyhobby/Auth/auth_manager.dart';
import 'package:hobbyhobby/widgets/community.dart';
import 'package:hobbyhobby/widgets/home.dart';
import 'package:hobbyhobby/widgets/mypage.dart';
import 'package:hobbyhobby/widgets/union.dart';
import 'package:hobbyhobby/constants.dart';

class RootPage extends StatefulWidget {
  final AuthManager authManager;
  final int initialIndex;
  const RootPage({Key? key, required this.authManager, this.initialIndex = 0}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  late int _bottomNavIndex;
  late AuthManager _authManager;

  // 페이지 리스트
  List<Widget> _widgetOptions() {
    return [
      HomePage(authManager: _authManager),
      CommunityPage(authManager: _authManager),
      UnionPage(authManager: _authManager),
      MyPage(authManager: _authManager),
    ];
  }

  @override
  void initState() {
    super.initState();
    _bottomNavIndex = widget.initialIndex;
    _authManager = widget.authManager;
  }
  // 페이지 아이콘 리스트
  List<String> iconList = [
    'assets/메인아이콘.png',
    'assets/커뮤니티아이콘.png',
    'assets/연합아이콘.png',
    'assets/마이페이지아이콘.png',
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
                  icon: ImageIcon(
                    AssetImage(iconList[index]),
                    color: _bottomNavIndex == index ? Constants.primaryColor : Colors.black,
                  ),
              label: titleList[index],
            ),
          ),
        ),
      ),
    );
  }
}
