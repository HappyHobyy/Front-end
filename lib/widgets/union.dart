import 'package:flutter/material.dart';
import 'package:hobbyhobby/Auth/auth_manager.dart';
import 'package:hobbyhobby/Union/create_union.dart';
import 'package:hobbyhobby/Union/tag_page.dart';
import 'package:hobbyhobby/Union/union_detail.dart';
import 'package:hobbyhobby/constants.dart';

class UnionPage extends StatefulWidget {
  final AuthManager authManager;
  const UnionPage({super.key, required this.authManager});

  @override
  State<UnionPage> createState() => _UnionPageState();
}

class _UnionPageState extends State<UnionPage> with SingleTickerProviderStateMixin {
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

  void loadUnions() {
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
          openTalkLink: 'https://open.kakao.com/o/sVWNA0sg'
        ),
        UnionMeeting(
          imageUrl: 'https://example.com/image1.jpg',
          userName: 'user_2',
          tag1: 'tag2-1',
          tag2: 'tag2-2',
          title: '연합 모임 예시_2',
          maxPeople: 'max',
          date: '09:41',
          openTalkLink: 'https://open.kakao.com/o/sample1',
        ),
        UnionMeeting(
          imageUrl: 'https://example.com/image1.jpg',
          userName: 'user_3',
          tag1: 'tag3-1',
          tag2: 'tag3-2',
          title: '연합 모임 예시_3',
          maxPeople: 'max',
          date: '09:41',
          openTalkLink: 'https://open.kakao.com/o/sample3',
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
          openTalkLink: 'https://open.kakao.com/o/sample4',
        ),
        SingleMeeting(
          imageUrl: 'https://example.com/image1.jpg',
          userName: 'user_5',
          tag1: 'tag_5-1',
          tag2: 'tag_5-2',
          title: '단일 모임 예시_2',
          maxPeople: 'max',
          date: '09:41',
          openTalkLink: 'https://open.kakao.com/o/sample5',
        ),
      ];
    });
  }

  void addMeeting(dynamic meeting) {
    setState(() {
      if (meeting is SingleMeeting) {
        singleMeetings.add(meeting);
      } else if (meeting is UnionMeeting) {
        unionMeetings.add(meeting);
      }
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
                  return CreateUnionScreen(authManager: _authManager, onMeetingCreated: addMeeting,);
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
          buildMeetingList(unionMeetings),
          buildMeetingList(singleMeetings),
        ],
      ),
    );
  }

  Widget buildMeetingList(List<dynamic> meetings) {
    return Column(
      children: [
        Container(
          height: 30,
          alignment: Alignment.topLeft,
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: TextButton(
            child: const Text(
              '+ 태그 추가하기',
              style: TextStyle(
                fontSize: 11,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<Widget>(builder: (BuildContext context) {
                  return const TagPage();
                }),
              );
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(0),
            itemCount: meetings.length,
            itemBuilder: (context, index) {
              final meeting = meetings[index];
              return MeetingTile(meeting: meeting);
            },
          ),
        ),
      ],
    );
  }
}

class MeetingTile extends StatelessWidget {
  final dynamic meeting;

  const MeetingTile({Key? key, required this.meeting}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(meeting.imageUrl),
      ),
      title: Text(meeting.title),
      subtitle: Row(
        children: [
          Text(meeting.userName),
          const SizedBox(width: 20),
          const Icon(Icons.account_circle_sharp, size: 15),
          const SizedBox(width: 5),
          Text(meeting.maxPeople),
          const SizedBox(width: 20),
          Text('# ${meeting.tag1}', style: const TextStyle(fontSize: 12)),
          const SizedBox(width: 5),
          Text('# ${meeting.tag2}', style: const TextStyle(fontSize: 12)),
        ],
      ),
      trailing: Text(meeting.date),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UnionDetailPage(
              leading: meeting.imageUrl,
              title: meeting.title,
              userName: meeting.userName,
              tag1: meeting.tag1,
              tag2: meeting.tag2,
              maxPeople: meeting.maxPeople,
              trailing: meeting.date,
              openTalkLink: meeting.openTalkLink,
            ),
          ),
        );
      },
    );
  }
}

class CreateUnionScreen extends StatelessWidget {
  final AuthManager authManager;
  final Function(dynamic) onMeetingCreated;
  const CreateUnionScreen({Key? key, required this.authManager, required this.onMeetingCreated,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                height: 600,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      SizedBox(
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
                  ),
                ),
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateUnion(authManager: authManager, onMeetingCreated: onMeetingCreated,),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Constants.primaryColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: const Center(
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
        ),
      ),
    );
  }
}

class UnionMeeting {
  final String imageUrl;
  final String userName;
  final String tag1;
  final String tag2;
  final String title;
  final String maxPeople;
  final String date;
  final String openTalkLink;

  UnionMeeting({
    required this.imageUrl,
    required this.userName,
    required this.tag1,
    required this.tag2,
    required this.title,
    required this.maxPeople,
    required this.date,
    required this.openTalkLink,
  });
}

class SingleMeeting {
  final String imageUrl;
  final String userName;
  final String tag1;
  final String tag2;
  final String title;
  final String maxPeople;
  final String date;
  final String openTalkLink;

  SingleMeeting({
    required this.imageUrl,
    required this.userName,
    required this.tag1,
    required this.tag2,
    required this.title,
    required this.maxPeople,
    required this.date,
    required this.openTalkLink,
  });
}
