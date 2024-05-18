import 'package:flutter/material.dart';
import 'package:hobbyhobby/constants.dart';
import 'package:hobbyhobby/communitys/community_home.dart';
import 'package:hobbyhobby/communitys/hboard.dart';
import 'package:hobbyhobby/communitys/review.dart';
import 'package:hobbyhobby/communitys/rental.dart';

class SecondRootPage extends StatefulWidget {
  final String communityName;

  const SecondRootPage({Key? key, required this.communityName})
      : super(key: key);

  @override
  _SecondRootPageState createState() => _SecondRootPageState();
}

class _SecondRootPageState extends State<SecondRootPage> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions() {
    return [
      CommunityHomePage(
        communityName: widget.communityName,
      ),
      const HboardPage(),
      const ReviewPage(),
      const RentalPage(),
    ];
  }

  List<IconData> secondiconList = [
    Icons.monochrome_photos,
    Icons.list_alt,
    Icons.mode_comment_outlined,
    Icons.recycling,
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
              icon: Icon(secondiconList[index]),
              label: secondtitleList[index],
            ),
          ),
        ),
      ),
    );
  }
}
