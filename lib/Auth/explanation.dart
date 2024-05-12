import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hobbyhobby/constants.dart';
import 'package:hobbyhobby/Auth/create.dart';
import 'package:page_transition/page_transition.dart';
import 'package:hobbyhobby/Auth/login.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

// 소셜 로그인을 구현할 플랫폴
enum LoginPlatform {
  kakao,
  naver,
  google,
}

class ExplanationPage extends StatefulWidget {
  const ExplanationPage({super.key});

  @override
  State<ExplanationPage> createState() => _ExplanationPageState();
}

class _ExplanationPageState extends State<ExplanationPage> {
  int currentPage = 0; // 현재 페이지 인덱스를 추적하는 변수

  List<String> pageTexts = [
    'What\'s your Hobby?',
    '페이지 2 문구',
    '페이지 3 문구',
    '페이지 4 문구',
  ];

  late bool isInstalled;
  late OAuthToken token; // 토큰
  late LoginPlatform _loginPlatform;

  @override
  // 초기화
  void initState() {
    super.initState();
    initIsInstalled();
  }

  // 카카오톡 로그인
  Future<void> signInWithKakao() async {
    try {
      if (isInstalled == null) {
        isInstalled = await isKakaoTalkInstalled();
      }

      if (isInstalled!) {
        token = await UserApi.instance.loginWithKakaoTalk();
      } else {
        token = await UserApi.instance.loginWithKakaoAccount();
      }

      // token 값이 null이 아닌지 확인한 후 사용
      if (token != null) {
        final url = Uri.https('kapi.kakao.com', '/v2/user/me');
        final response = await http.get(
          url,
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${token!.accessToken}'
          },
        );

        final profileInfo = json.decode(response.body);
        final email = profileInfo['kakao_account']['email'];
        final name = profileInfo['properties']['nickname'];
        String oAuth = 'OAUTH_KAKAO';

        /**
        if (email != null && name != null) {
          sendUserInfoToServer(email, name, oAuth);
        }
            **/

        setState(() {
          _loginPlatform = LoginPlatform.kakao;
        });
      } else {
        print('토큰이 초기화되지 않았습니다.');
      }
    } catch (error) {
      print('카카오톡으로 로그인 실패 $error');
    }
  }
  // 카카오톡 설치 여부 확인
  void initIsInstalled() {
    isKakaoTalkInstalled().then((value) {
      setState(() {
        isInstalled = value;
      });
    });
  }

  // 네이버 로그인
  void signInWithNaver() async {
    final NaverLoginResult result = await FlutterNaverLogin.logIn();

    if (result.status == NaverLoginStatus.loggedIn) {
      final email = result.account.email;
      final name = result.account.name;
      String oAuth = 'OAUTH_NAVER';

      /**
      if (email != null && name != null) {
        sendUserInfoToServer(email, name, oAuth);
      }
       **/

      setState(() {
        _loginPlatform = LoginPlatform.naver;
      });
    }
  }

  // 구글 로그인
  void signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      final email = googleUser.email;
      final name = googleUser.displayName;
      String oAuth = 'OAUTH_GOOGLE';

      /**
      if (email != null && name != null) {
        sendUserInfoToServer(email, name, oAuth);
      }
      **/

      setState(() {
        _loginPlatform = LoginPlatform.google;
      });
    }
  }
  /**
  // 서버로 유저 정보 전송
  void sendUserInfoToServer(String email, String nickname, String oAuth) async {
    final url = Uri.parse('http://52');
    final response = await http.post(
      url,
      body: json.encode({'email': email, 'nickname': nickname, 'oAuth': oAuth}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('사용자 정보를 서버에 전송했습니다.');
    } else {
      print('사용자 정보를 서버에 전송하지 못했습니다.');
    }
  }
  **/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
        children: [
          const SizedBox(height: 80),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hobby',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.3,
                    ),
                  ),
                  Text(
                    'Hobby',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                      color: Constants.primaryColor,
                    ),
                  ),
                ]
            ),
          SizedBox(height: 30),
          Column(
            children: [
              Container(
                height: 300,
                child: PageView(
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index; // 현재 페이지 업데이트
                    });
                  },
                  children: [
                    Image.asset('assets/explanation1.jpg'),
                    Image.asset('assets/explanation1.jpg'),
                    Image.asset('assets/explanation1.jpg'),
                    Image.asset('assets/explanation1.jpg')
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Text(
                pageTexts[currentPage], // 현재 페이지에 해당하는 텍스트 표시
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 4; i++)
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: i == currentPage
                            ? Constants.primaryColor
                            : Colors.grey,
                      ),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
          InkWell(
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreatePage()),
              );
            },
            child: Container(
              width: 250,
              decoration: BoxDecoration(
                color: Constants.primaryColor,
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Center(
                child: Text(
                  '회원가입',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '이미 계정이 있으신가요?',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          child: LoginPage(),
                          type: PageTransitionType.bottomToTop,
                          duration: Duration(milliseconds: 300)));
                },
                child: Text(
                '로그인',
                  style: TextStyle(
                    color: Constants.primaryColor,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(child: Divider()),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                    'OR',
                  style: TextStyle(
                   fontSize: 13,
                  ),
                ),
              ),
              Expanded(child: Divider()),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  signInWithKakao();
                },
                child: Container(
                  child: Image.asset(
                      'assets/kakao.png',
                      height: 40),
                ),
              ),
              const SizedBox(width: 40),
              GestureDetector(
                onTap: () {
                  signInWithNaver();
                },
                child: Container(
                  child: Image.asset(
                      'assets/naver.png',
                      height: 40),
                ),
              ),
              const SizedBox(width: 40),
              GestureDetector(
                onTap: () {
                  signInWithGoogle();
                },
                child: Container(
                  child: Image.asset(
                      'assets/google.png',
                      height: 40),
                ),
              ),
            ],
          )
        ],
        ),
      ),
    );
  }
}

