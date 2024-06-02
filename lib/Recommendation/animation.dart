import 'package:flutter/material.dart';
import 'package:hobbyhobby/Recommendation/recommend.dart';
import 'package:hobbyhobby/constants.dart';
import 'package:hobbyhobby/Recommendation/recommend_remote_api.dart';
import 'package:hobbyhobby/Auth/auth_manager.dart';

class AnimationPage extends StatefulWidget {
  final AuthManager authManager;
  final List<int?> answers;

  const AnimationPage({Key? key, required this.authManager, required this.answers}) : super(key: key);

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  final List<String> showHobbies = [
    "#볼링", "#낚시", "#등산", "#자전거", "#요리", "#골프", "#풋살", "#미술", "#인테리어", "#뜨개질", "#산책", "#클라이밍"
  ]; // 다양한 취미 텍스트를 담은 리스트
  List<String> hobbies = [];
  late AuthManager _authManager;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: true);

    _animation = Tween<Offset>(
      begin: const Offset(0.1, 0),
      end: const Offset(-0.1, 0),
    ).animate(_controller);
    _fetchHobbies();
    _authManager = widget.authManager;
  }

  Future<void> _fetchHobbies() async {
    final api = RecommendationRemoteApi();
    final recommendation = await api.mbtiTestPost(widget.answers);

    if (recommendation != null) {
      setState(() {
        hobbies = recommendation.hobbies;
      });
      
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RecommendationPage(authManager: _authManager, hobbies: hobbies))
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildRow() {
    // Calculate the width of each CardWidget based on screen width
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = screenWidth / 6;
    int maxCards = (screenWidth / cardWidth).floor();

    return SlideTransition(
      position: _animation,
      child: Row(
        children: List.generate(
          maxCards,
              (index) => CardWidget(text: showHobbies[index % showHobbies.length]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: 500,
          child: Column(
            children: [
              SizedBox(height: 120),
              Column(
                children: [
                  Text(
                    "유저님이 좋아하실 만한",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "취미를 찾고 있어요",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    colors: [
                      Colors.transparent,
                      Constants.primaryColor,
                      Constants.primaryColor,
                      Colors.transparent,
                    ],
                    stops: const [0.1, 0.3, 0.7, 0.9],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.dstIn,
                child: buildRow(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final String text;

  const CardWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(
            color: Constants.textColor,
          ),
        ),
      ),
    );
  }
}