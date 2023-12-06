import 'package:flutter/material.dart';
import 'package:matrix_app_project/features/data/models/second_user_model.dart';
import 'package:matrix_app_project/features/presentaition/pages/chat_section/screen/chat_screen.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:matrix_app_project/core/usecases/colors.dart';

class UserItems extends StatefulWidget {
  const UserItems({
    super.key,
    required this.user,
  });
  final UserModel user;

  @override
  State<UserItems> createState() => _UserItemsState();
}

class _UserItemsState extends State<UserItems> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ChatScreen(userId: widget.user.uid),
        ));
      },
      child: ListTile(
        leading: Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(widget.user.photUrl),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: CircleAvatar(
                backgroundColor:
                    widget.user.isOnline ? Colors.green : Colors.transparent,
                radius: 5,
              ),
            )
          ],
        ),
        title: Text(
          widget.user.username,
          style: const TextStyle(
              color: blackClr, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "Last seen ${timeago.format(widget.user.lastActive)}",
          maxLines: 2,
          style: const TextStyle(
              color: greyDark, fontSize: 11, overflow: TextOverflow.ellipsis),
        ),
        trailing: Text(_formatLastActive(widget.user.lastActive)) ,
      ),
    );
  }
}
String _formatLastActive(DateTime lastActive) {
  final now = DateTime.now();
  final difference = now.difference(lastActive);

  if (difference.inDays > 0) {
    return timeago.format(lastActive, locale: 'en_short');
  } else if (difference.inHours > 0) {
    return '${difference.inHours}h';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes}min';
  } else {
    return 'Now';
  }
}
