import 'package:flutter/material.dart';
import 'package:hobbyhobby/constants.dart';

class AnimationPage extends StatefulWidget {
  const AnimationPage({Key? key}) : super(key: key);

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  final List<String> hobbies = ["#볼링", "#낚시", "#등산", "#자전거", "#요리", "#골프", "#풋살"]; // 다양한 취미 텍스트를 담은 리스트

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _animation = Tween<Offset>(
      begin: const Offset(0.1, 0),
      end: const Offset(-0.1, 0),
    ).animate(_controller);
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
              (index) => CardWidget(text: hobbies[index % hobbies.length]), // 리스트의 텍스트를 순환하면서 가져와 사용
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