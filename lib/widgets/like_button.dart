import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LikeButton extends StatefulWidget {
  const LikeButton({super.key});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool liked = false;

  void toggleButton() {
    setState(() {
      liked = !liked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: toggleButton,
        child: liked
            ? const Icon(
                Icons.favorite,
                color: Colors.red,
                size: 24.0,
              )
            // .animate(target: liked ? 1 : 0)
            // .scaleXY(duration: 400.ms, begin: 1.0, end: 1.2)
            // .then()
            // .scaleXY(duration: 400.ms, begin: 1.2, end: 1.1)
            : const Icon(
                Icons.favorite_outline,
                size: 24.0,
              )
        // .animate(target: liked ? 1 : 0)
        // .scaleXY(duration: 400.ms, begin: 1.0, end: 1.2)
        // .then()
        // .scaleXY(duration: 400.ms, begin: 1.2, end: 1.1)
        );
  }
}
