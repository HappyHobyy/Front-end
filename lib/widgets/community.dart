import 'package:flutter/material.dart';
import 'package:hobbyhobby/Auth/jwt_token_model.dart';
import 'package:hobbyhobby/communitys/second_root_page.dart';
import 'package:hobbyhobby/constants.dart';
import 'package:hobbyhobby/widgets/like_button.dart';

import '../Auth/auth_manager.dart';
import '../api_service.dart';
import '../communitys/models.dart';

class CommunityPage extends StatefulWidget {
  final AuthManager authManager;

  const CommunityPage({super.key, required this.authManager});

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

// temporary
List<String> myHobbiesList = <String>["자전거", "풋살", "배드민턴"];
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

// 전체 취미
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
              backgroundImage: Constants.hobbyImageMap[strings[index]],
            ),
            title: Text(strings[index]),
            trailing: LikeButton(
              onLikedChanged: (bool liked) {
                print('Button liked state is: $liked');
              },
            ),
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
  late AuthManager _authManager;
  late Future<List<PopularCommunity>> popularCommunitiesFuture;
  late Future<List<MyCommunity>> myCommunitiesFuture;
  late Future<JwtToken> jwtTokenFuture;

  @override
  void initState() {
    super.initState();
    _authManager = widget.authManager;
    jwtTokenFuture = _authManager.loadAccessToken();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final jwtToken = await jwtTokenFuture;
      setState(() {
        popularCommunitiesFuture = ApiService().fetchData(
          jwtToken,
          'community-service',
          'api/community/popular',
          (json) => PopularCommunity.fromJson(json),
        );
        myCommunitiesFuture = ApiService().fetchData(
          jwtToken,
          'community-service',
          'api/community/user',
          (json) => MyCommunity.fromJson(json),
        );
      });
    } catch (e) {
      print("Error loading data: $e");
    }
  }

  Future<void> likePost(int communityId) async {
    try {
      final jwtToken = await jwtTokenFuture;
      await ApiService().sendData(
        jwtToken,
        'community-service',
        'api/community/user',
        {'communityId': communityId},
      );
      print('Post liked successfully');
    } catch (e) {
      print("Error liking post: $e");
    }
  }

  Future<void> deletePost(int communityId) async {
    try {
      final jwtToken = await jwtTokenFuture;
      await ApiService().deleteData(
        jwtToken,
        'community-service',
        'api/community/user',
        {'communityId': communityId},
      );
      print('Post deleted successfully');
    } catch (e) {
      print("Error deleting post: $e");
    }
  }

  ListView toListView<T extends Community>(List<T> communities) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(color: Colors.grey[200]),
      itemCount: communities.length,
      itemBuilder: (context, index) {
        final community = communities[index];
        return ListTile(
          leading: CircleAvatar(
            // Constants.hobbyImageMap[strings[index]]
            // backgroundImage: NetworkImage(community.imageUrl),
            backgroundImage: Constants.hobbyImageMap[community.communityName],
          ),
          title: Text(community.communityName),
          trailing: LikeButton(
            onLikedChanged: (bool liked) {
              if (liked) {
                likePost(community.communityId);
              } else {
                deletePost(community.communityId);
              }
              print('Button liked state is: $liked');
            },
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    SecondRootPage(communityName: community.communityName),
              ),
            );
          },
        );
      },
    );
  }

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
                // toListView(myHobbiesList),
                FutureBuilder<List<MyCommunity>>(
                  future: myCommunitiesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No communities found.'));
                    } else {
                      return toListView(snapshot.data!);
                    }
                  },
                ),
                // toListView(suggestedHobbiesList),
                const Text('tmp'),
                // toListView(popularHobbiesList),
                FutureBuilder<List<PopularCommunity>>(
                  future: popularCommunitiesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No communities found.'));
                    } else {
                      return toListView(snapshot.data!);
                    }
                  },
                ),

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
