import 'package:flutter/material.dart';
import 'package:hobbyhobby/communitys/second_root_page.dart';
import 'package:hobbyhobby/constants.dart';
import 'package:hobbyhobby/widgets/like_button.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

/* 임시 placeholder 탭 정보 */
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
const hobbyImageMap = <String, AssetImage>{
  "낭독 봉사": AssetImage("assets/hobby/낭독 봉사.jpg"),
  "가죽 공예": AssetImage("assets/hobby/가죽공예.jpg"),
  "골프": AssetImage("assets/hobby/골프.jpg"),
  "나무 심기 봉사": AssetImage("assets/hobby/나무 심기 봉사.jpg"),
  "낚시": AssetImage("assets/hobby/낚시.jpg"),
  "등산": AssetImage("assets/hobby/등산.jpg"),
  "뜨개질": AssetImage("assets/hobby/뜨개질.jpg"),
  "러닝": AssetImage("assets/hobby/러닝.jpg"),
  "레고 조립": AssetImage("assets/hobby/레고.jpg"),
  "마술": AssetImage("assets/hobby/마술.jpg"),
  "미술": AssetImage("assets/hobby/미술.jpg"),
  "바베큐": AssetImage("assets/hobby/바베큐.jpg"),
  "반려식물": AssetImage("assets/hobby/반려식물.jpg"),
  "배드민턴": AssetImage("assets/hobby/배드민턴.jpg"),
  "베이비박스 봉사": AssetImage("assets/hobby/베이비박스 봉사.jpg"),
  "베이킹": AssetImage("assets/hobby/베이킹.jpg"),
  "보드게임": AssetImage("assets/hobby/보드게임.jpg"),
  "볼링": AssetImage("assets/hobby/볼링.jpg"),
  "비디오게임": AssetImage("assets/hobby/비디오게임.jpg"),
  "사진 찍기": AssetImage("assets/hobby/사진.jpg"),
  "산책": AssetImage("assets/hobby/산책.jpg"),
  "서핑": AssetImage("assets/hobby/서핑.jpg"),
  "스케이트 보드": AssetImage("assets/hobby/스케이트보드.jpg"),
  "스키": AssetImage("assets/hobby/스키.jpg"),
  "여행": AssetImage("assets/hobby/여행.jpg"),
  "연극": AssetImage("assets/hobby/연극.jpg"),
  "영화": AssetImage("assets/hobby/영화.jpg"),
  "유기견 봉사": AssetImage("assets/hobby/유기견 봉사.jpg"),
  "음악": AssetImage("assets/hobby/음악.jpg"),
  "인테리어": AssetImage("assets/hobby/인테리어.jpg"),
  "자전거": AssetImage("assets/hobby/자전거.jpg"),
  "전시회": AssetImage("assets/hobby/전시회.jpg"),
  "천체관측": AssetImage("assets/hobby/천체관측.jpg"),
  "캘리그라피": AssetImage("assets/hobby/캘리그라피.jpg"),
  "캠핑": AssetImage("assets/hobby/캠핑.jpg"),
  "코딩": AssetImage("assets/hobby/코딩.jpg"),
  "크로스핏": AssetImage("assets/hobby/크로스핏.jpg"),
  "클라이밍": AssetImage("assets/hobby/클라이밍.jpg"),
  "타로": AssetImage("assets/hobby/타로.jpg"),
  "테니스": AssetImage("assets/hobby/테니스.jpg"),
  "풋살": AssetImage("assets/hobby/풋살.jpg"),
  "필라테스": AssetImage("assets/hobby/필라테스.jpg"),
  "홈브루": AssetImage("assets/hobby/홈브루.jpg"),
  "홈카페": AssetImage("assets/hobby/홈카페.jpg"),
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
List<AssetImage> allHobbiesListIcons = const <AssetImage>[
  AssetImage("assets/community_icons/Exercise.png"),
  AssetImage("assets/community_icons/Drawing.png"),
  AssetImage("assets/community_icons/Noodles.png"),
  AssetImage("assets/community_icons/Reading.png"),
  AssetImage("assets/community_icons/TV Show.png"),
  AssetImage("assets/community_icons/Trust.png"),
];
// 전체 취미 분류 리스트
List<List<String>> hobbyCategories = [
  sports,
  arts,
  cooking,
  learning,
  entertainment,
  volunteering,
];
// 운동 및 스포츠
List<String> sports = [
  "자전거",
  "골프",
  "등산",
  "크로스핏",
  "서핑",
  "테니스",
  "스케이트 보드",
  "스키",
  "볼링",
  "산책",
  "클라이밍",
  "풋살",
  "필라테스",
  "배드민턴",
  "러닝"
];

// 창작 및 예술
List<String> arts = [
  "사진 찍기",
  "미술",
  "캘리그라피",
  "전시회",
  "연극",
  "가죽 공예",
  "레고 조립",
  "인테리어",
  "뜨개질",
  "반려식물"
];

// 요리
List<String> cooking = ["홈브루", "베이킹", "홈카페", "바베큐"];

// 독서 및 학습
List<String> learning = ["코딩", "천체관측"];

// 엔터테인먼트
List<String> entertainment = [
  "보드 게임",
  "비디오 게임",
  "영화",
  "마술",
  "캠핑",
  "낚시",
  "여행",
  "음악 감상",
  "타로"
];

// 봉사활동
List<String> volunteering = ["나무 심기", "낭독 봉사", "유기견 봉사", "베이비박스 봉사", "플로깅"];

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
              backgroundImage: hobbyImageMap[strings[index]],
            ),
            title: Text(strings[index]),
            trailing: const LikeButton(),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SecondRootPage(communityName: strings[index]),
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
                  style: Constants.titleTextStyle,
                ),
                bottom: TabBar(
                  splashFactory: NoSplash.splashFactory,
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
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
                          // leading: ImageIcon(allHobbiesListIcons[index]),
                          leading: ImageIcon(allHobbiesListIcons[index]),
                          title: Text(allHobbiesList[index]),
                          trailing: const Icon(Icons.navigate_next),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GroupedCommunityPage(
                                  title: allHobbiesList[index],
                                  icon: ImageIcon((allHobbiesListIcons[index])),
                                  content: hobbyCategories[index],
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

class GroupedCommunityPage extends StatelessWidget {
  final String title;
  final ImageIcon icon;
  final List<String> content;

  const GroupedCommunityPage(
      {super.key,
      required this.title,
      required this.icon,
      required this.content});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              const SizedBox(width: 8), // space between icon and title
              Text(
                title,
                style: Constants.titleTextStyle,
              ),
            ],
          ),
        ),
        body: toListView(content),
      ),
    );
  }
}
