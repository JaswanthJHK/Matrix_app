import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:matrix_app_project/features/data/models/user.dart';
import 'package:matrix_app_project/features/presentaition/pages/comment_section/screen/comment_screen.dart';
import 'package:matrix_app_project/features/presentaition/pages/home_main_section/widgets/like_animation.dart';
import 'package:matrix_app_project/features/presentaition/pages/profile_section/widgets/profile_posted_images_card.dart';

class LikeAndCommentWidget extends StatelessWidget {
  const LikeAndCommentWidget({
    Key? key,
    required this.widget,
    required this.user,
  }) : super(key: key);

  final ProfilePostedCard widget;
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
              // Your like button logic here
            },
            icon: widget.snap['likes'].contains(user.uid)
                ? const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 30,
                  )
                : const Icon(
                    Icons.favorite_border_outlined,
                  ),
          ),
        ),
        IconButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CommentScreen(
                snap: widget.snap,
              ),
            ),
          ),
          icon: const Icon(
            Icons.comment_outlined,
            size: 30,
          ),
        ),
      ],
    );
  }
}

class DescriptionAreaWidget extends StatelessWidget {
  const DescriptionAreaWidget({
    super.key,
    required this.widget,
    required this.commentLength,
  });

  final ProfilePostedCard widget;
  final int commentLength;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          DefaultTextStyle(
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w800,
                ),
            child: Visibility(
              visible: widget.snap['likes'].isNotEmpty,
              child: Text(
                '${widget.snap['likes'].length} likes',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 2),
            child: RichText(
              text: TextSpan(
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
                children: [
                  TextSpan(
                    text: widget.snap['username'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  TextSpan(
                    text: '  ${widget.snap['description']}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CommentScreen(snap: widget.snap),
                ),
              );
            },
            child: Visibility(
              visible: commentLength > 0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  'View all $commentLength comments',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              DateFormat.yMMMd().format(
                widget.snap['datePublished'].toDate(),
              ),
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
