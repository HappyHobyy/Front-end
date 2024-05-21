import 'dart:ffi';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hobbyhobby/Auth/auth_manager.dart';
import 'package:hobbyhobby/Union/create_union.dart';
import 'package:hobbyhobby/Union/tag_page.dart';
import 'package:hobbyhobby/Union/union_detail.dart';
import 'package:hobbyhobby/constants.dart';
import 'package:page_transition/page_transition.dart';

class UnionPage extends StatefulWidget {
  final AuthManager authManager;
  const UnionPage({super.key,required this.authManager});

  @override
  State<UnionPage> createState() => _UnionPageState();
}

class _UnionPageState extends State<UnionPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late AuthManager _authManager;
  List<UnionMeeting> unionMeetings = [];
  List<SingleMeeting> singleMeetings = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _authManager = widget.authManager;
    loadUnions();
  }

  void loadUnions(){
    setState(() {
      unionMeetings = [
        UnionMeeting(
          imageUrl: 'https://example.com/image1.jpg',
          userName: '천재사진작가',
          tag1: '천체',
          tag2: '사진',
          title: '천체 관측 같이 즐겨요!',
          maxPeople: '12',
          date: '09:41',
        ),
        UnionMeeting(
          imageUrl: 'https://example.com/image1.jpg',
          userName: 'user_2',
          tag1: 'tag2-1',
          tag2: 'tag2-2',
          title: '연합 모임 예시_2',
          maxPeople: 'max',
          date: '09:41',
        ),
        UnionMeeting(
          imageUrl: 'https://example.com/image1.jpg',
          userName: 'user_3',
          tag1: 'tag3-1',
          tag2: 'tag3-2',
          title: '연합 모임 예시_3',
          maxPeople: 'max',
          date: '09:41',
        ),
      ];
      singleMeetings = [
        SingleMeeting(
          imageUrl: 'https://example.com/image1.jpg',
          userName: 'user_4',
          tag1: 'tag_4-1',
          tag2: 'tag_4-2',
          title: '단일 모임 예시_1',
          maxPeople: '5',
          date: '09:41',
        ),
        SingleMeeting(
          imageUrl: 'https://example.com/image1.jpg',
          userName: 'user_5',
          tag1: 'tag_5-1',
          tag2: 'tag_5-2',
          title: '단일 모임 예시_2',
          maxPeople: 'max',
          date: '09:41',
        ),
      ];
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          '모임',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<Widget>(builder: (BuildContext context) {
                  return Scaffold(
                      appBar: AppBar(
                        title: const Text(
                          '모임 생성',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      body: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  height: 600,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.4),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: const Align(
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            height: 30,
                                            width: 10,
                                          ),
                                          Text(
                                            '약관 및 주의사함',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                                const SizedBox(height: 30),
                                InkWell(
                                  onTap: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CreateUnion(authManager: _authManager,)),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Constants.primaryColor,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 15),
                                    child: Center(
                                      child: Text(
                                        '동의하기',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )));
                }),
              );
            },
            icon: const Icon(
              Icons.add,
              color: Colors.black,
              size: 30,
            ),
          )
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(text: '연합 모임'),
            Tab(text: '단일 모임'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Column(
            children: [
              Container(
                height: 30,
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextButton(
                  child: Text(
                    '+ 태그 추가하기',
                    style: TextStyle(
                      fontSize: 11,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<Widget>(
                          builder: (BuildContext context) {
                            return TagPage();
                          }),
                    );
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount: unionMeetings.length,
                itemBuilder: (context, index) {
                  final unionMeeting = unionMeetings[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(unionMeeting.imageUrl),
                    ),
                    title: Text(unionMeeting.title),
                    subtitle: Row(
                      children: [
                        Text(unionMeeting.userName),
                        const SizedBox(width: 20),
                        Icon(Icons.account_circle_sharp, size: 15),
                        const SizedBox(width: 5),
                        Text(unionMeeting.maxPeople),
                        const SizedBox(width: 20),
                        Text('# ${unionMeeting.tag1}', style: TextStyle(fontSize: 12)),
                        const SizedBox(width: 5),
                        Text('# ${unionMeeting.tag2}', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    trailing: Text(unionMeeting.date),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UnionDetailPage(
                            leading: unionMeeting.imageUrl,
                            title: unionMeeting.title,
                            userName: unionMeeting.userName,
                            tag1: unionMeeting.tag1,
                            tag2: unionMeeting.tag2,
                            maxPeople: unionMeeting.maxPeople,
                            trailing: unionMeeting.date,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),)
            ],
          ),
          Column(
            children: [
              Container(
                height: 30,
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextButton(
                  child: Text(
                    '+ 태그 추가하기',
                    style: TextStyle(
                      fontSize: 11,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<Widget>(
                          builder: (BuildContext context) {
                            return TagPage();
                          }),
                    );
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount: singleMeetings.length,
                itemBuilder: (context, index) {
                  final singleMeeting = singleMeetings[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(singleMeeting.imageUrl),
                    ),
                    title: Text(singleMeeting.title),
                    subtitle: Row(
                      children: [
                        Text(singleMeeting.userName),
                        const SizedBox(width: 20),
                        Icon(Icons.account_circle_sharp, size: 15),
                        const SizedBox(width: 5),
                        Text(singleMeeting.maxPeople),
                        const SizedBox(width: 20),
                        Text('# ${singleMeeting.tag1}', style: TextStyle(fontSize: 12)),
                        const SizedBox(width: 5),
                        Text('# ${singleMeeting.tag2}', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    trailing: Text(singleMeeting.date),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UnionDetailPage(
                            leading: singleMeeting.imageUrl,
                            title: singleMeeting.title,
                            userName: singleMeeting.userName,
                            tag1: singleMeeting.tag1,
                            tag2: singleMeeting.tag2,
                            maxPeople: singleMeeting.maxPeople,
                            trailing: singleMeeting.date,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),)
            ],
          ),
        ],
      ),
    );
  }
}

class UnionMeeting{
  String imageUrl;
  String userName;
  String tag1;
  String tag2;
  String title;
  String maxPeople;
  String date;

  UnionMeeting({
    required this.imageUrl,
    required this.userName,
    required this.tag1,
    required this.tag2,
    required this.title,
    required this.maxPeople,
    required this.date,
  });
}

class SingleMeeting{
  String imageUrl;
  String userName;
  String tag1;
  String tag2;
  String title;
  String maxPeople;
  String date;

  SingleMeeting({
    required this.imageUrl,
    required this.userName,
    required this.tag1,
    required this.tag2,
    required this.title,
    required this.maxPeople,
    required this.date,
  });
}