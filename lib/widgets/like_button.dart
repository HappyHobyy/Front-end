import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  final bool? isLiked;
  final ValueChanged<bool>? onLikedChanged;

  const LikeButton({
    Key? key,
    this.isLiked,
    this.onLikedChanged,
  }) : super(key: key);

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.isLiked!;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isLiked ? Icons.favorite : Icons.favorite_border,
        color: _isLiked ? Colors.red : null,
      ),
      onPressed: () {
        setState(() {
          _isLiked = !_isLiked;
        });
        widget.onLikedChanged?.call(_isLiked);
      },
    );
  }
}
