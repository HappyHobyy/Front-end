import 'package:flutter/material.dart';
import 'package:hobbyhobby/constants.dart';
import 'package:hobbyhobby/widgets/community.dart';

class UnionDetailPage extends StatefulWidget {
  final String leading;
  final String title;
  final String userName;
  final String tag1;
  final String tag2;
  final String maxPeople;
  final String trailing;

  const UnionDetailPage({
    Key? key,
    required this.leading,
    required this.title,
    required this.userName,
    required this.tag1,
    required this.tag2,
    required this.maxPeople,
    required this.trailing,
  }) : super(key: key);

  @override
  _UnionDetailPageState createState() => _UnionDetailPageState();
}

class _UnionDetailPageState extends State<UnionDetailPage> {
  bool isJoined_1 = false; // botton1의 상태 관리
  bool isJoined_2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: MediaQuery
                    .of(context)
                    .size
                    .width,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    "assets/hobby/천체관측.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.all(20.10),
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
                      SizedBox(height: 3),
                      Row(
                        children: [
                          Text(
                            widget.userName,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(width: 80),
                          Container(
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
                              child: Text(widget.tag1),
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
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
                              child: Text(widget.tag2),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.grey.withOpacity(0.4),
                        height: 100,
                        thickness: 1,
                      ),
                      Text(
                        '모임 시간',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text('2024.5.20'),
                      SizedBox(height: 60,),
                      Text(
                        '장소',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text('강원 횡성군 강림면 월안1길 82 천문인마을'),
                      SizedBox(height: 60,),
                      Text(
                        '최대 인원',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text('${widget.maxPeople} 명'),
                      SizedBox(height: 60,),
                      Text(
                        '모임 설명',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                          '안녕하세요! 천체관측을 취미로 가지고 있는 학생입니다. \n'
                              '이번 5월 10일에 횡성 천문인 마을로 천체관측을 하러 가는데 사진을 취미로 하시는 분과 같이 즐기고 싶어 모임을 만들었어요. \n'
                              '같이 별에 대해서 알아보고 사진도 찍고 좋은 시간 가져보고 싶습니다. \n'
                      ),
                      Divider(
                        color: Colors.grey.withOpacity(0.4),
                        height: 100,
                        thickness: 1,
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 22.0,
            right: 20.0,
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  isJoined_1 = !isJoined_1;
                });
              },
              child: isJoined_1 ?
                  const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 24.0,
                  )
                  : const Icon(
                Icons.favorite_outline,
                size: 24.0,
              ),
            ),
          ),
          Positioned(
            bottom: 20.0,
            left: MediaQuery
                .of(context)
                .size
                .width / 5, // 화면의 가운데에서 왼쪽으로 100 이동
            child: FloatingActionButton.extended(
              onPressed: () {
                setState(() {
                  isJoined_2 = !isJoined_2;
                });
              },
              label: SizedBox(
                width: 200, // width를 200으로 설정
                height: 40, // height를 40으로 설정
                child: Center(
                  child: Text(
                    isJoined_2 ? '취소하기' : '참석하기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              backgroundColor: isJoined_2 ? Colors.grey : Constants.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}