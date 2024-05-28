import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:hobbyhobby/constants.dart';
import 'package:hobbyhobby/widgets/community.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';


class UnionDetailPage extends StatefulWidget {
  final String leading;
  final String title;
  final String userName;
  final String tag1;
  final String tag2;
  final String maxPeople;
  final String trailing;
  final String openTalkLink;

  const UnionDetailPage({
    Key? key,
    required this.leading,
    required this.title,
    required this.userName,
    required this.tag1,
    required this.tag2,
    required this.maxPeople,
    required this.trailing,
    required this.openTalkLink
  }) : super(key: key);

  @override
  _UnionDetailPageState createState() => _UnionDetailPageState();
}

class _UnionDetailPageState extends State<UnionDetailPage> {
  bool isJoined1 = false; // button1
  bool isJoined2 = false; // button2

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.width,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    "assets/hobby/천체관측.jpg",
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
                        widget.title,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          Text(
                            widget.userName,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(width: 80),
                          _buildTag(widget.tag1),
                          const SizedBox(width: 10),
                          _buildTag(widget.tag2),
                        ],
                      ),
                      Divider(
                        color: Colors.grey.withOpacity(0.4),
                        height: 30,
                        thickness: 1,
                      ),
                      const SizedBox(height: 20,),
                      _buildDetailSection('모임 시간', '2024.5.20'),
                      const SizedBox(height: 50),
                      _buildDetailSection('장소', '강원 횡성군 강림면 월안1길 82 천문인마을'),
                      const SizedBox(height: 50),
                      _buildDetailSection('최대 인원', '${widget.maxPeople} 명'),
                      const SizedBox(height: 50),
                      _buildDetailSection('모임 설명',
                          '안녕하세요! 천체관측을 취미로 가지고 있는 학생입니다. \n이번 5월 10일에 횡성 천문인 마을로 천체관측을 하러 가는데 사진을 취미로 하시는 분과 같이 즐기고 싶어 모임을 만들었어요. \n같이 별에 대해서 알아보고 사진도 찍고 좋은 시간 가져보고 싶습니다. \n'),
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
              onPressed: () {
                setState(() {
                  isJoined1 = !isJoined1;
                });
              },
              child: Icon(
                isJoined1 ? Icons.favorite : Icons.favorite_outline,
                color: isJoined1 ? Colors.red : null,
                size: 24.0,
              ),
            ),
          ),
          Positioned(
            bottom: 20.0,
            left: MediaQuery.of(context).size.width / 5,
            child: FloatingActionButton.extended(
              heroTag: 'fab2', //고유한 Hero 태그 추가
              onPressed: () {
                if (!isJoined2) {
                  _showAgreementDialog(context);
                }
                setState(() {
                  if(isJoined2){
                    isJoined2 = !isJoined2;
                  }
                });
              },
              label: SizedBox(
                width: 200,
                height: 40,
                child: Center(
                  child: Text(
                    isJoined2 ? '취소하기' : '참석하기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              backgroundColor: isJoined2 ? Colors.grey : Constants.primaryColor,
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

  void _showAgreementDialog(BuildContext context) {
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
                          widget.openTalkLink,
                          style: TextStyle(color: Colors.blue),
                        ),
                        onTap: () async {
                          final url = widget.openTalkLink;
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
                              isJoined2 = true;
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
}
