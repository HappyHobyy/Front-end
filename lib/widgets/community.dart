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

List<String> allHobbiesMaptoList = Constants.hobbyImageMap.keys
    .toList(); // to find index of each community in map, map is converted into a list.

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
  "사진",
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
  "보드게임",
  "비디오게임",
  "영화",
  "마술",
  "캠핑",
  "낚시",
  "여행",
  "음악감상",
  "타로"
];

// 봉사활동
List<String> volunteering = ["나무 심기", "낭독 봉사", "유기견 봉사", "베이비박스 봉사", "플로깅"];
late List<Community> myCommunitiesList;

class _CommunityPageState extends State<CommunityPage> {
  late AuthManager _authManager;
  late Future<List<Community>> popularCommunitiesFuture;
  late Future<List<Community>> myCommunitiesFuture;
  late Future<List<Community>> recommendedCommunitiesFuture;
  late Future<JwtToken> jwtTokenFuture;
  bool _isLoading = true; // Add loading state

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
      // Initialize the futures
      popularCommunitiesFuture = ApiService().fetchData(
        jwtToken,
        'community-service',
        'api/community/popular',
            (json) => Community.fromJson(json),
      );
      myCommunitiesFuture = ApiService().fetchData(
        jwtToken,
        'community-service',
        'api/community/user',
            (json) => Community.fromJson(json),
      );
      recommendedCommunitiesFuture = ApiService().fetchData(
        jwtToken,
        'community-service',
        'api/community/recommend',
            (json) => Community.fromJson(json),
      );

      // Assign the fetched data to myCommunitiesList
      myCommunitiesList = await myCommunitiesFuture;

      setState(() {
        _isLoading = false; // Update loading state
      });

      // Assign the fetched data to myCommunitiesList
      myCommunitiesList = await myCommunitiesFuture;
    } catch (e) {
      print("Error loading data: $e");
      setState(() {
        _isLoading = false; // Update loading state even if there's an error
      });
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
      // Reload data
      await _loadData();
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
        final isLiked = myCommunitiesList.any((likedCommunity) =>
            likedCommunity.communityId == community.communityId);
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: Constants.hobbyImageMap[community.communityName],
          ),
          title: Text(community.communityName),
          trailing: LikeButton(
            isLiked: isLiked,
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
                builder: (context) => SecondRootPage(
                  authManager: _authManager,
                  communityName: community.communityName,
                  communityID: community.communityId,
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: DefaultTabController(
          length: hobbyTabs.length,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
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
                FutureBuilder<List<Community>>(
                  future: myCommunitiesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData ||
                        snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text('No communities found.'));
                    } else {
                      return toListView(snapshot.data!);
                    }
                  },
                ),
                FutureBuilder<List<Community>>(
                  future: recommendedCommunitiesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData ||
                        snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text('No communities found.'));
                    } else {
                      return toListView(snapshot.data!);
                    }
                  },
                ),
                FutureBuilder<List<Community>>(
                  future: popularCommunitiesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData ||
                        snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text('No communities found.'));
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
                        leading: ImageIcon(allHobbiesListIcons[index]),
                        title: Text(allHobbiesList[index]),
                        trailing: const Icon(Icons.navigate_next),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GroupedCommunityPage(
                                title: allHobbiesList[index],
                                icon: ImageIcon(
                                    (allHobbiesListIcons[index])),
                                content: hobbyCategories[index],
                                likePost: likePost,
                                deletePost: deletePost,
                                authManager: _authManager, // Pass the _authManager here
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          )),
    );
  }
}

ListView toListViewAllHobbies(
    List<String> strings,
    void Function(int communityId) likePost,
    void Function(int communityId) deletePost,
    AuthManager authManager, // Add this parameter
    ) {
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
        final communityId = allHobbiesMaptoList.indexOf(strings[index]);
        final isLiked = myCommunitiesList
            .any((community) => community.communityId == communityId);
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: Constants.hobbyImageMap[strings[index]],
          ),
          title: Text(strings[index]),
          trailing: LikeButton(
            isLiked: isLiked,
            onLikedChanged: (bool liked) {
              if (liked) {
                likePost(communityId);
              } else {
                deletePost(communityId);
              }
              print('Button liked state is: $liked');
            },
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SecondRootPage(
                  authManager: authManager, // Pass authManager here
                  communityName: strings[index],
                  communityID: communityId,
                ),
              ),
            );
          },
        );
      }
    },
  );
}

class GroupedCommunityPage extends StatelessWidget {
  final String title;
  final ImageIcon icon;
  final List<String> content;
  final void Function(int communityId) likePost;
  final void Function(int communityId) deletePost;
  final AuthManager authManager; // Add this parameter

  const GroupedCommunityPage({
    super.key,
    required this.title,
    required this.icon,
    required this.content,
    required this.likePost,
    required this.deletePost,
    required this.authManager, // Add this parameter
  });

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
        body: toListViewAllHobbies(content, likePost, deletePost, authManager), // Pass authManager here
      ),
    );
  }
}
