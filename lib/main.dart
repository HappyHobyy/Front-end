import 'package:flutter/material.dart';
import 'package:hobbyhobby/Auth/auth_remote_api.dart';
import 'package:hobbyhobby/Auth/auth_repository.dart';
import 'package:hobbyhobby/Auth/explanation.dart';
import 'package:hobbyhobby/Splash/splash.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 초기화 보장
  await Future.delayed(const Duration(seconds: 1)); // 1초 지연
  KakaoSdk.init(nativeAppKey: 'c6680d3c0807622d413ea95edd94f0d1');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
      // 아래 코드들은 회원가입 창(생년월일)에서 한국어 설정을 위한 코드입니다.
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('ko', ''), // Korean, no country code
      ],
    );
  }
}