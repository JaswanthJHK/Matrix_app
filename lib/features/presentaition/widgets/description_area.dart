import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:matrix_app_project/core/usecases/colors.dart';
import 'package:matrix_app_project/features/presentaition/pages/comment_screen.dart';
import 'package:matrix_app_project/features/presentaition/widgets/post_card.dart';

class DescriptionArea extends StatelessWidget {
  const DescriptionArea({
    super.key,
    required this.widget,
    required this.commentLength,
  });

  final PostCard widget;

  final int commentLength;

  @override
  Widget build(BuildContext context) {
    return Container(
      //  color: Colors.amberAccent,
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
              visible: widget.snap['likes']
                  .isNotEmpty, // Show only if there's at least one like
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
                style: const TextStyle(color: blackClr),
                children: [
                  TextSpan(
                    text: widget.snap['username'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  TextSpan(
                    text: '  ${widget.snap['description']}',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 58, 58, 58),
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
              visible: commentLength>0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  'View all $commentLength comments',
                  style: TextStyle(fontSize: 16, color: greyLite),
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
          )
        ],
      ),
    );
  }
}
