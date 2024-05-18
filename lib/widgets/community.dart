import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hobbyhobby/constants.dart';
import 'package:hobbyhobby/widgets/like_button.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

TextStyle titleTextStyle = const TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w700,
  letterSpacing: 0.3,
);

const List<Tab> hobbyTabs = <Tab>[
  Tab(text: "내 취미"),
  Tab(text: "추천 취미"),
  Tab(text: "인기 취미"),
  Tab(text: "전체"),
];

List<String> myTabsString = <String>[
  "내 취미",
  "추천 취미",
  "인기 취미",
  "전체",
];

List<String> myHobbiesList = <String>["자전거", "풋살", "배드민턴"];
final hobbyImageMap = <String, NetworkImage>{
  "자전거": const NetworkImage(
      "https://cdn.pixabay.com/photo/2022/02/27/06/33/man-7036709_1280.jpg"),
  "풋살": const NetworkImage(
      "https://cdn.pixabay.com/photo/2015/04/20/03/02/football-730587_1280.jpg"),
  "배드민턴": const NetworkImage(
      "https://cdn.pixabay.com/photo/2016/05/31/23/21/badminton-1428046_1280.jpg"),
};

List<String> suggestedHobbiesList = <String>[
  "러닝",
  "클라이밍",
  "스케이트 보드",
  "등산",
  "크로스핏",
  "필라테스",
  "자전거",
];
List<String> popularHobbiesList = <String>[
  "영화",
  "낚시",
  "등산",
  "풋살",
  "러닝",
  "사진",
  "클라이밍",
  "음악",
];
List<String> allHobbiesList = const <String>[
  "운동 및 스포츠",
  "창작 및 예술",
  "요리",
  "독서 및 학습",
  "엔터테인먼트",
  "봉사활동"
];
List<Icon> allHobbiesListIcons = const <Icon>[
  Icon(Icons.directions_run),
  Icon(CupertinoIcons.pencil),
  Icon(Icons.directions_run),
  Icon(Icons.book),
  Icon(Icons.youtube_searched_for),
  Icon(Icons.directions_run),
];

ListView toListView(List<String> strings) {
  return ListView.separated(
      separatorBuilder: (context, index) => Divider(
            color: Colors.grey[200],
          ),
      itemCount: strings.length + 1,
      itemBuilder: (context, index) {
        if (index == strings.length) {
          // 마지막 divider 추가
          return Container(); // zero height: not visible
        } else {
          return ListTile(
            leading: CircleAvatar(
              // child: Text('A'),
              backgroundImage: hobbyImageMap[strings[index]],
            ),
            title: Text(strings[index]),
            trailing: const LikeButton(),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SpecificCommunityPage(content: strings[index]),
                ),
              );
            },
          );
        }
      });
}

class _CommunityPageState extends State<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: DefaultTabController(
          length: hobbyTabs.length,
          child: Scaffold(
            appBar: AppBar(
                title: Text(
                  '커뮤니티',
                  style: titleTextStyle,
                ),
                bottom: TabBar(
                  splashFactory: NoSplash.splashFactory,
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                    // Use the default focused overlay color
                    return states.contains(MaterialState.focused)
                        ? null
                        : Colors.transparent;
                  }),
                  labelStyle: const TextStyle(
                    fontSize: 15,
                  ),
                  indicatorColor: Constants.primaryColor,
                  tabs: hobbyTabs,
                )),
            body: TabBarView(
              children: [
                toListView(myHobbiesList),
                toListView(suggestedHobbiesList),
                toListView(popularHobbiesList),
                ListView.separated(
                  separatorBuilder: (context, index) =>
                      Divider(color: Colors.grey[200]),
                  itemCount: allHobbiesList.length + 1,
                  itemBuilder: (context, index) {
                    if (index == allHobbiesList.length) {
                      // 마지막 divider 추가
                      return Container(); // zero height: not visible
                    } else {
                      return ListTile(
                          leading: allHobbiesListIcons[index],
                          title: Text(allHobbiesList[index]),
                          trailing: const Icon(Icons.navigate_next),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GroupedCommunityPage(
                                  content: allHobbiesList[index],
                                  icon: allHobbiesListIcons[index],
                                ),
                              ),
                            );
                          });
                    }
                  },
                ),
              ],
            ),
          )),
    );
  }
}

class SpecificCommunityPage extends StatelessWidget {
  final String content;

  const SpecificCommunityPage({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          content,
          style: titleTextStyle,
        ),
      ),
    );
  }
}

class GroupedCommunityPage extends StatelessWidget {
  final String content;
  final Icon icon;

  const GroupedCommunityPage(
      {super.key, required this.content, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            Text(
              content,
              style: titleTextStyle,
            ),
          ],
        ),
      ),
      body: toListView(myHobbiesList),
    );
  }
}
