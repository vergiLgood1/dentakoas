import 'package:denta_koas/src/features/appointment/controller/post.controller/posts_controller.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LikeButton extends StatefulWidget {
  final String postId;

  const LikeButton({
    super.key,
    required this.postId,
  });

  @override
  LikeButtonState createState() => LikeButtonState();
}

class LikeButtonState extends State<LikeButton> {
  bool isLiked = false; // Status awal tombol like
  final controller = Get.put(PostController()); // Ambil controller

  void toggleLike() async {
    bool newIsLiked = !isLiked; // Ubah status like sementara

    try {
      // Panggil API untuk like atau unlike
      if (newIsLiked) {
        controller.createLike(widget.postId);
      } else {
        controller.createLike(widget.postId);
      }

      // Jika berhasil, baru ubah status like
      setState(() {
        isLiked = newIsLiked;
      });
    } catch (e) {
      TLoaders.errorSnackBar(
        title: 'Error',
        message: e.toString(),
      );
    }
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
