import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  final ValueChanged<bool>? onLikedChanged; // Make the callback optional
  const LikeButton({Key? key, this.onLikedChanged}) : super(key: key);

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool liked = false;

  void toggleButton() {
    setState(() {
      liked = !liked;
      if (widget.onLikedChanged != null) {
        widget.onLikedChanged!(
            liked); // Notify the parent about the state change if the callback is provided
      }
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
