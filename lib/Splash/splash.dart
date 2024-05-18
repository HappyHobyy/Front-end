// splash.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hobbyhobby/Auth/auth_manager.dart';
import 'package:hobbyhobby/Auth/auth_repository.dart';
import 'package:hobbyhobby/Auth/explanation.dart';
import 'package:hobbyhobby/Community/community_remote_api.dart';
import 'package:hobbyhobby/DataSource/local_data_storage.dart';
import 'package:hobbyhobby/root_page.dart';
import 'package:hobbyhobby/Splash/splash_view_model.dart';
import 'dart:async';

import '../Auth/auth_remote_api.dart';
import '../Community/community_repository.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashPage> {
  late SplashViewModel _splashViewModel;
  late AuthRepository authRepository;
  late CommunityRepository communityRepository;
  late AuthManager authManager;

  @override
  void initState() {
    super.initState();
    authRepository = AuthRepository(LocalDataStorage(), AuthRemoteApi());
    communityRepository = CommunityRepository(CommunityRemoteApi());
    authManager = AuthManager(authRepository);
    _splashViewModel =
        SplashViewModel(authRepository, authManager, communityRepository);
    _splashViewModel.addListener(_onAuthStateChanged);
    _splashViewModel.checkAuthentication();

  }

  @override
  void dispose() {
    _splashViewModel.removeListener(_onAuthStateChanged);
    super.dispose();
  }

  void _onAuthStateChanged() {
    if(_splashViewModel.authState == AuthState.uninitialized){
      return;
    }
    if (_splashViewModel.authState == AuthState.authenticated) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => RootPage()),
      );
    } else if (_splashViewModel.authState == AuthState.unauthenticated) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) =>
                ExplanationPage(authRepository: authRepository)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 250,
              height: 50,
              child: SvgPicture.asset('assets/hobbyhobby_splash_Icon.svg'),
            ),
            SizedBox(height: 300),
          ],
        ),
      ),
    );
  }
}
