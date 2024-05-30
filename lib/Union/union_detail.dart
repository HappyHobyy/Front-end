import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:hobbyhobby/Auth/auth_manager.dart';
import 'package:hobbyhobby/Union/union_model.dart';
import 'package:hobbyhobby/Union/union_repository.dart';
import 'package:hobbyhobby/Union/union_view_model.dart';
import 'package:hobbyhobby/constants.dart';
import 'package:hobbyhobby/root_page.dart';
import 'package:hobbyhobby/widgets/community.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

class UnionDetailPage extends StatefulWidget {
  final AuthManager authManager;
  final UnionRepository unionRepository;
  final dynamic meetings;

  const UnionDetailPage({
    Key? key,
    required this.authManager,
    required this.unionRepository,
    required this.meetings,
  }) : super(key: key);

  @override
  _UnionDetailPageState createState() => _UnionDetailPageState();
}

class _UnionDetailPageState extends State<UnionDetailPage> {
  late AuthManager _authManager;
  late UnionRepository _unionRepository;
  late UnionViewModel _unionViewModel;
  bool _isLoading = true;
  late dynamic _meetings;
  DateTime? date;
  String? location;
  String? text;
  String? openTalkLink;
  late bool isUserJoined;
  late bool isUserLiked;
  String? displayDate;

  @override
  void initState() {
    super.initState();
    _meetings = widget.meetings;
    _authManager = widget.authManager;
    _unionRepository = widget.unionRepository;
    _unionViewModel = UnionViewModel(_unionRepository, _authManager);
    loadUnionDetails();
  }

  void loadUnionDetails() async {
    try {
      if(_meetings is UnionMeeting){
        final details = await _unionViewModel.getUnionMeetingDetail(_meetings.articleId);
        setState(() {
          date = details.meetingDate;
          displayDate = '${date?.year}년 ${date?.month}월 ${date?.day}일 ${date?.hour}시 ${date?.minute.toString().padLeft(2, '0')}분';
          location = details.location;
          text = details.mainText;
          openTalkLink = details.openTalkLink;
          isUserJoined = details.isUserJoined;
          isUserLiked = details.isUserLiked;
          _isLoading = false;
        });
      } else if(_meetings is SingleMeeting){
        final details = await _unionViewModel.getSingleMeetingDetail(_meetings.articleId);
        setState(() {
          date = details.meetingDate;
          location = details.location;
          text = details.mainText;
          openTalkLink = details.openTalkLink;
          isUserJoined = details.isUserJoined;
          isUserLiked = details.isUserLiked;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Failed to load meeting details: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.width,
                pinned: true,
                actions: [
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'delete') {
                        _showDeleteConfirmationDialog(context);
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem<String>(
                          value: 'delete',
                          child: Text('삭제'),
                        ),
                      ];
                    },
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: _meetings.imageUrl.startsWith('http')
                      ? Image.network(
                    _meetings.imageUrl,
                    fit: BoxFit.cover,
                  )
                      : Image.asset(
                    _meetings.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _meetings.title,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          Text(
                            _meetings.userNickname,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(width: 80),
                          _buildTag('${_meetings.tag1}'),
                          const SizedBox(width: 10),
                          if (_meetings is UnionMeeting)
                            _buildTag('${_meetings.tag2}'),
                        ],
                      ),
                      Divider(
                        color: Colors.grey.withOpacity(0.4),
                        height: 30,
                        thickness: 1,
                      ),
                      const SizedBox(height: 20),
                      _buildDetailSection('모임 시간', displayDate ?? '정보 없음'),
                      const SizedBox(height: 50),
                      _buildDetailSection('장소', location ?? '정보 없음'),
                      const SizedBox(height: 50),
                      _buildDetailSection('최대 인원', '${_meetings.maxPeople} 명'),
                      const SizedBox(height: 50),
                      _buildDetailSection('모임 설명', text ?? '정보 없음'),
                      Divider(
                        color: Colors.grey.withOpacity(0.4),
                        height: 30,
                        thickness: 1,
                      ),
                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 90,
              color: Colors.white,
              alignment: Alignment.center,
            ),
          ),
          Positioned(
            bottom: 22.0,
            right: 20.0,
            child: FloatingActionButton(
              heroTag: 'fab1', //고유한 Hero 태그 추가
              onPressed: () async {
                if(!isUserLiked && _meetings is UnionMeeting){
                  _showLikeDialog(context);
                  await _unionViewModel.likeUnionMeeting(_meetings.articleId);
                }else if(!isUserLiked && _meetings is SingleMeeting){
                  _showLikeDialog(context);
                  await _unionViewModel.likeSingleMeeting(_meetings.articleId);
                }else if(isUserLiked && _meetings is UnionMeeting){
                  _showCancleLikeDialog(context);
                  await _unionViewModel.deleteLikeUnionMeeting(_meetings.articleId);
                }else if(isUserLiked && _meetings is SingleMeeting){
                  _showCancleLikeDialog(context);
                  await _unionViewModel.deleteLikeSingleMeeting(_meetings.articleId);
                }
                setState(() {
                  isUserLiked = !isUserLiked;
                });
              },
              child: Icon(
                isUserLiked ? Icons.favorite : Icons.favorite_outline,
                color: isUserLiked ? Colors.red : null,
                size: 24.0,
              ),
            ),
          ),
          Positioned(
            bottom: 20.0,
            left: MediaQuery.of(context).size.width / 5,
            child: FloatingActionButton.extended(
              heroTag: 'fab2', //고유한 Hero 태그 추가
              onPressed: () async {
                if (!isUserJoined && _meetings is UnionMeeting) {
                  _showAttendDialog(context);
                  await _unionViewModel.memberUnionMeeting(_meetings.articleId);
                } else if(!isUserJoined && _meetings is SingleMeeting){
                  _showAttendDialog(context);
                  await _unionViewModel.memberSingleMeeting(_meetings.articleId);
                } else if(isUserJoined && _meetings is UnionMeeting){
                  _showCancelDialog(context);
                  await _unionViewModel.deleteMemberUnionMeeting(_meetings.articleId);
                } else if (isUserJoined && _meetings is SingleMeeting) {
                  _showCancelDialog(context);
                  await _unionViewModel.deleteMemberSingleMeeting(_meetings.articleId);
                }
              },
              label: SizedBox(
                width: 200,
                height: 40,
                child: Center(
                  child: Text(
                    isUserJoined ? '취소하기' : '참석하기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              backgroundColor: isUserJoined ? Colors.grey : Constants.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String tag) {
    return Container(
      height: 20,
      width: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(tag),
      ),
    );
  }

  Widget _buildDetailSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Text(content),
      ],
    );
  }

  void _showAttendDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('약관 및 주의사항'),
          content: Text('약관 내용을 여기에 입력하세요.'),
          actions: <Widget>[
            TextButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('동의하기'),
              onPressed: () {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('오픈톡 링크'),
                      content: InkWell(
                        child: Text(
                          openTalkLink ?? '정보 없음',
                          style: TextStyle(color: Colors.blue),
                        ),
                        onTap: () async {
                          final url = openTalkLink ?? '';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                      ),
                      actions: [
                        TextButton(
                          child: Text('확인'),
                          onPressed: () {
                            setState(() {
                              isUserJoined = true;
                            });
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('취소 하시겠습니까?'),
          actions: <Widget>[
            TextButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('동의하기'),
              onPressed: () {
                setState(() {
                  isUserJoined = false;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('삭제 하시겠습니까?'),
          actions: <Widget>[
            TextButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('확인'),
              onPressed: () async {
                try{
                  if(_meetings is UnionMeeting){
                    await _unionViewModel.deleteUnionMeeting(_meetings.articleId);
                    Navigator.pushAndRemoveUntil(
                      context,
                      PageTransition(
                        child: RootPage(authManager: _authManager, initialIndex: 2),
                        type: PageTransitionType.rightToLeftWithFade,
                        duration: Duration(milliseconds: 300),
                      ),
                          (Route<dynamic> route) => false,
                    );
                  } else if(_meetings is SingleMeeting){
                    await _unionViewModel.deleteSingleMeeting(_meetings.articleId);
                    Navigator.pushAndRemoveUntil(
                      context,
                      PageTransition(
                        child: RootPage(authManager: _authManager, initialIndex: 2),
                        type: PageTransitionType.rightToLeftWithFade,
                        duration: Duration(milliseconds: 300),
                      ),
                          (Route<dynamic> route) => false,
                    );
                  }
                } catch(error){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to delete meeting: $error')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showLikeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('좋아요가 등록되었습니다.'),
          actions: <Widget>[
            TextButton(
              child: Text('확인'),
              onPressed: () {
                setState(() {
                  isUserLiked = true;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showCancleLikeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('좋아요가 취소되었습니다.'),
          actions: <Widget>[
            TextButton(
              child: Text('확인'),
              onPressed: () {
                setState(() {
                  isUserLiked = false;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
