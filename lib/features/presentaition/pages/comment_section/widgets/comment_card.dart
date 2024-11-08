import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:matrix_app_project/core/usecases/colors.dart';
import 'package:matrix_app_project/features/presentaition/pages/profile_section/screen/profile_page.dart';

class CommentCard extends StatefulWidget {
  final snap;
  const CommentCard({super.key, required this.snap});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilPage(uid: widget.snap['uid']),
              ));
        },
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                widget.snap['profilePic'],
              ),
              radius: 18,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: widget.snap['name'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary)),
                      TextSpan(
                          text: '  ${widget.snap['text']}',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary))
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      DateFormat.yMMMd()
                          .format(widget.snap['timestamp'].toDate()),
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
