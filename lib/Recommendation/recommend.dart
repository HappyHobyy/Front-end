import 'package:flutter/material.dart';
import 'package:hobbyhobby/constants.dart';
import 'package:hobbyhobby/root_page.dart';
import 'package:hobbyhobby/Auth/auth_manager.dart';

class RecommendationPage extends StatefulWidget {
  final AuthManager authManager;
  final List<String> hobbies;

  const RecommendationPage({
    Key? key,
    required this.hobbies,
    required this.authManager,
  }) : super(key: key);

  @override
  _RecommendationPageState createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage> {
  late AuthManager _authManager;

  @override
  void initState() {
    super.initState();
    _authManager = widget.authManager;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  Text(
                    '유저님에게는',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                    ),
                  ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.hobbies[0], // 첫 번째 변수
                    style: TextStyle(
                      color: Constants.textColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    ', ',
                    style: TextStyle(
                      color: Constants.textColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                    ),// 일반 텍스트
                  ),
                  Text(
                    widget.hobbies[1], // 두 번째 변수
                    style: TextStyle(
                      color: Constants.textColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    ', ',
                    style: TextStyle(
                      color: Constants.textColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                    ),// 일반 텍스트
                  ),
                  Text(
                    widget.hobbies[2],
                    style: TextStyle(
                      color: Constants.textColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
                    Text(
                      '취미가 잘 맞을 것 같아요',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                      ),
                    ),
                const SizedBox(height: 50),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 50, // 원하는 위치로 조정
            child: Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RootPage(authManager: _authManager),
                    ),
                  );
                },
                child: Container(
                  width: 330,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Constants.primaryColor,
                  ),
                  child: Center(
                    child: Text(
                      '바로 추가하러 가기',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
