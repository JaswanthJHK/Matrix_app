import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:matrix_app_project/core/usecases/colors.dart';
import 'package:matrix_app_project/core/usecases/constants.dart';
import 'package:matrix_app_project/features/data/models/message_model.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {super.key, required this.message, required this.isImage});

  final Message message;
  final bool isImage;

  @override
  Widget build(BuildContext context) {
    bool isMe = FirebaseAuth.instance.currentUser!.uid == message.senderId;

    final formattedDateTime =
        DateFormat('yyyy-MM-dd HH:mm').format(message.sentTime);
    return Align(
      alignment: isMe ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        decoration: BoxDecoration(
            color: isMe ? greyLite : const Color.fromARGB(255, 240, 240, 240),
            borderRadius: isMe
                ?
                const BorderRadius.only(
                    topRight: radiusThirty,
                    topLeft: radiusThirty,
                    bottomLeft: radiusThirty,
                  )
                
                :  const BorderRadius.only(
                    topRight: radiusThirty,
                    topLeft: radiusThirty,
                    bottomRight: radiusThirty,
                  )),
        margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            isImage
                ? Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: NetworkImage(message.content),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Text(
                    message.content,
                    style:
                        const TextStyle(color: Color.fromARGB(255, 21, 21, 21)),
                  ),
            Text(
             // timeago.format(message.sentTime),
             formattedDateTime,
              style: const TextStyle(color: greyDark, fontSize: 10),
            )
          ],
        ),
      ),
    );
  }
}
