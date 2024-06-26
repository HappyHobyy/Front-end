import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

String postContent = """안녕하세요, 풋살 커뮤니티 여러분! 

오늘 참여한 풋살 경험을 나누고자 합니다.

우선, 풋살 경기는 정말로 즐거웠습니다.
커뮤니티 내에서 같이 뛰어주신 여러분들께 감사의 말씀을 전합니다. 함께하는 모든 순간이 활력 넘치는 경험이었습니다.

다음 주말에도 같이 풋살을 즐기고 싶습니다.
함께하는 모든 순간이 즐거웠고, 앞으로도 더 많은 경험을 나누고 싶습니다. 감사합니다!""";
String dateTime = "2024. 05. 24 09:41";

class DetailPage extends StatelessWidget {
  final String communityName;
  final String postTitle;
  final String authorName;
  final String postTime;

  const DetailPage({
    super.key,
    required this.communityName,
    required this.postTitle,
    required this.authorName,
    required this.postTime,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        title: Text(communityName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              postTitle,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/profile_picture.png'),
                  radius: 20,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      authorName,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  dateTime,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            Divider(color: Colors.grey[200]),
            SizedBox(height: 16),
            Text(
              postContent,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Divider(color: Colors.grey[200]),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Icon(Icons.favorite, size: 16, color: Colors.red),
                    SizedBox(width: 2),
                    Text("3"),
                  ],
                ),
                SizedBox(width: 5),
                Row(
                  children: [
                    Icon(Icons.comment, size: 16),
                    SizedBox(width: 2),
                    Text("3"),
                  ],
                ),
              ],
            ),
            Text(
              "Comments",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/profile_picture_com1.png'),
                    ),
                    title: Text('mocoa'),
                    subtitle: Text('오늘 진짜 인정! 너무너무 재밌었어요.'),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/profile_picture_com2.png'),
                    ),
                    title: Text('피알아이'),
                    subtitle: Text('드리븐님은 정말 매주 빠짐없이 나가시네요'),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/profile_picture_com3.png'),
                    ),
                    title: Text('꼬마앙마'),
                    subtitle: Text('담주엔 꼭!!! 모임 참석 일찍 누를께요,,,ㅠㅠ'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
