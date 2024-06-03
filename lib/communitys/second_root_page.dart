import 'package:flutter/material.dart';
import 'package:hobbyhobby/Auth/auth_manager.dart';
import 'package:hobbyhobby/constants.dart';
import 'package:hobbyhobby/communitys/community_home.dart';
import 'package:hobbyhobby/communitys/hboard.dart';
import 'package:hobbyhobby/communitys/review.dart';
import 'package:hobbyhobby/communitys/rental.dart';
import 'package:hobbyhobby/Auth/jwt_token_model.dart';

class SecondRootPage extends StatefulWidget {
  final AuthManager authManager;
  final String communityName;
  final int communityID;

  const SecondRootPage(
      {Key? key, required this.authManager, required this.communityName, required this.communityID})
      : super(key: key);

  @override
  _SecondRootPageState createState() => _SecondRootPageState();
}

class _SecondRootPageState extends State<SecondRootPage> {
  int _selectedIndex = 0;
  late AuthManager _authManager;
  late Future<JwtToken> jwtTokenFuture;

  @override
  void initState() {
    super.initState();
    _authManager = widget.authManager;
    jwtTokenFuture = _authManager.loadAccessToken();
  }

  List<Widget> _widgetOptions() {
    return [
      CommunityHomePage(
        authManager: widget.authManager, communityName: widget.communityName, communityID: widget.communityID,
      ),
      HboardPage(
        authManager: widget.authManager, communityName: widget.communityName, communityID: widget.communityID
      ),
      ReviewPage(
          authManager: widget.authManager, communityName: widget.communityName, communityID: widget.communityID
      ),
      const RentalPage(),
    ];
  }

  List<String> secondiconList = [
    'assets/Hlog아이콘.png',
    'assets/Hboard아이콘.png',
    'assets/장비리뷰아이콘.png',
    'assets/장비대여아이콘.png',

  ];

  List<String> secondtitleList = [
    'H-log',
    'H-board',
    '장비 리뷰',
    '장비 대여',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions()[_selectedIndex],
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          unselectedIconTheme: IconThemeData(color: Colors.black),
          selectedIconTheme: IconThemeData(color: Constants.primaryColor),
          items: List.generate(
            secondiconList.length,
            (index) => BottomNavigationBarItem(
              icon: ImageIcon(
    AssetImage(secondiconList[index]),
                size: 26.0,
              ),
              label: secondtitleList[index],
            ),
          ),
        ),
      ),
    );
  }
}
