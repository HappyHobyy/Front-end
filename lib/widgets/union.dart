import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hobbyhobby/Auth/auth_manager.dart';
import 'package:hobbyhobby/Union/create_union.dart';
import 'package:hobbyhobby/Union/tag_page.dart';
import 'package:hobbyhobby/Union/union_detail.dart';
import 'package:hobbyhobby/Union/union_model.dart';
import 'package:hobbyhobby/Union/union_repository.dart';
import 'package:hobbyhobby/Union/union_view_model.dart';
import 'package:hobbyhobby/constants.dart';
import 'package:provider/provider.dart';

class UnionPage extends StatefulWidget {
  final AuthManager authManager;
  final UnionRepository unionRepository;

  const UnionPage({super.key, required this.authManager, required this.unionRepository});

  @override
  State<UnionPage> createState() => _UnionPageState();
}

class _UnionPageState extends State<UnionPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late AuthManager _authManager;
  late UnionRepository _unionRepository;
  late UnionViewModel _unionViewModel;
  List<UnionMeeting> unionMeetings = [];
  List<SingleMeeting> singleMeetings = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _authManager = widget.authManager;
    _unionRepository = widget.unionRepository;
    _unionViewModel = UnionViewModel(_unionRepository, _authManager);
    loadUnions();
  }

  void loadUnions() async{
    try {
      final fetchedUnionMeetings = await _unionViewModel.getUnionMeeting();
      final fetchedSingleMeetings = await _unionViewModel.getSingleMeeting();
      setState(() {
        unionMeetings = fetchedUnionMeetings as List<UnionMeeting>;
        singleMeetings = fetchedSingleMeetings as List<SingleMeeting>;
        _isLoading = false;
      });
    } catch (e) {
      print('Failed to load meetings: $e');
      setState(() {
        _isLoading = false;
      });
    }
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
                  return CreateUnionScreen(authManager: _authManager, onMeetingCreated: addMeeting,unionViewModel: _unionViewModel,);
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
      body: _isLoading
          ? Center(child: CircularProgressIndicator(),)
          : TabBarView(
              controller: _tabController,
              children: <Widget>[
                buildMeetingList(unionMeetings, isSingleMeeting: false),
                buildMeetingList(singleMeetings, isSingleMeeting: true),
            ],
          ),
    );
  }

  Widget buildMeetingList(List<dynamic> meetings, {required bool isSingleMeeting}) {
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
              return MeetingTile(meeting: meeting, isSingleMeeting: isSingleMeeting, authManager: _authManager, unionRepository: _unionRepository,);
            },
          ),
        ),
      ],
    );
  }
}

class MeetingTile extends StatelessWidget {
  final dynamic meeting;
   final AuthManager authManager;
   final UnionRepository unionRepository;
  final bool isSingleMeeting;

  const MeetingTile({Key? key, required this.meeting, required this.isSingleMeeting, required this.authManager, required this.unionRepository }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String displayDate;

    if (meeting.createDate.year == now.year &&
        meeting.createDate.month == now.month &&
        meeting.createDate.day == now.day) {
      // 오늘 생성된 경우 시, 분 표시
      displayDate = '${meeting.createDate.hour}:${meeting.createDate.minute.toString().padLeft(2, '0')}';
    } else {
      // 그 외의 경우 월, 일 표시
      displayDate = '${meeting.createDate.month}/${meeting.createDate.day}';
    }

    String truncateText(String text, int maxLength) {
      return text.length > maxLength ? '${text.substring(0, maxLength)}...' : text;
    }

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: meeting.imageUrl.startsWith('http')
            ? NetworkImage(meeting.imageUrl)
            : AssetImage(meeting.imageUrl) as ImageProvider,
      ),
      title: Text(
        truncateText(meeting.title, 8),
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Row(
        children: [
          Text(
            truncateText(meeting.userNickname, 8),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(width: 50),
          const Icon(Icons.account_circle_sharp, size: 15),
          const SizedBox(width: 5),
          Text('${meeting.maxPeople}'),
          const SizedBox(width: 50),
          Expanded(
            child: Text(
              '# ${meeting.tag1}',
              style: const TextStyle(fontSize: 12),
            ),
          ),
          if (!isSingleMeeting) ...[
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                '# ${meeting.tag2}',
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ],
          const SizedBox(width: 20),
        ],
      ),
      trailing: Text(
        displayDate,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UnionDetailPage(
              authManager: authManager,
              unionRepository: unionRepository,
              meetings: meeting,
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
  final UnionViewModel unionViewModel;
  const CreateUnionScreen({Key? key, required this.authManager, required this.onMeetingCreated, required this.unionViewModel}) : super(key: key);

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
                        '약관 및 주의사항',
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
                      builder: (context) => CreateUnion(authManager: authManager, onMeetingCreated: onMeetingCreated,unionViewModel: unionViewModel,),
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
