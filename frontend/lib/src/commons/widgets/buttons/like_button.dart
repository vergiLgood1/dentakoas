import 'package:denta_koas/src/commons/widgets/cards/widget/post/header.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  const LikeButton({super.key});

  @override
  LikeButtonState createState() => LikeButtonState();
}

class LikeButtonState extends State<LikeButton> {
  bool isLiked = false;

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isLiked ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
        color: isLiked ? TColors.primary : Colors.grey,
      ),
      onPressed: toggleLike,
    );
  }
}
