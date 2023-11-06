import 'package:flutter/material.dart';
import 'package:matrix_app_project/features/data/data_sources/firestore_methodes.dart';
import 'package:matrix_app_project/features/data/models/user.dart';
import 'package:matrix_app_project/features/presentaition/pages/comment_screen.dart';
import 'package:matrix_app_project/features/presentaition/widgets/like_animation.dart';
import 'package:matrix_app_project/features/presentaition/widgets/post_card.dart';

class LikeAndComment extends StatelessWidget {
  const LikeAndComment({
    super.key,
    required this.widget,
    required this.user,
  });

  final PostCard widget;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LikeAnimation(
          isAnimating: widget.snap['likes'].contains(user.uid),
          smallLike: true,
          child: IconButton(
              onPressed: () async {
                await FirestoreMethodes().likePost(
                  widget.snap['postId'],
                  user.uid,
                  widget.snap['likes'],
                );
              },
              icon: widget.snap['likes'].contains(user.uid)
                  ? const Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 30,
                    )
                  : const Icon(
                      Icons.favorite_border_outlined,
                    )),
        ),
        IconButton(
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CommentScreen(
              snap: widget.snap,
            ),
          )),
          icon: const Icon(
            Icons.comment_outlined,
            size: 30,
          ),
        ),
      ],
    );
  }
}
