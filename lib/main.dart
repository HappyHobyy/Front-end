import 'package:flutter/material.dart';
import 'package:hobbyhobby/Auth/explanation.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 초기화 보장
  await Future.delayed(const Duration(seconds: 1)); // 1초 지연
  KakaoSdk.init(nativeAppKey: 'c6680d3c0807622d413ea95edd94f0d1');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ExplanationPage(),

      // 아래 코드들은 회원가입 창(생년월일)에서 한국어 설정을 위한 코드입니다.
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''), // English, no country code
        Locale('ko', ''), // Korean, no country code
      ],
    );
  }
}