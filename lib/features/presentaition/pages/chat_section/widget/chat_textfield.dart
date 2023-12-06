import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:matrix_app_project/core/usecases/colors.dart';
import 'package:matrix_app_project/features/data/functions/firebase_firestore_service.dart';
import 'package:matrix_app_project/features/data/functions/media_service.dart';
import 'package:matrix_app_project/features/presentaition/pages/chat_section/widget/chat_custom_textfield.dart';
import 'package:matrix_app_project/features/service/notification_service.dart';

class ChatTextField extends StatefulWidget {
  const ChatTextField({super.key, required this.recieverId});

  final String recieverId;

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  final chatController = TextEditingController();
  final notificationService = NotificationService();
  Uint8List? file;

  @override
  void initState() {
    notificationService.getReceiverToken(widget.recieverId);
    super.initState();
  }

  @override
  void dispose() {
    chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: chatCustomTextFormField(
            chatController: chatController,
            hintText: 'Add Message',
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        CircleAvatar(
          backgroundColor: greyDark,
          radius: 20,
          child: IconButton(
              onPressed: () => _sendText(context),
              icon: const Icon(
                Icons.send,
                color: Colors.white,
              )),
        ),
        const SizedBox(
          width: 5,
        ),
        CircleAvatar(
          backgroundColor: greyDark,
          radius: 20,
          child: IconButton(
              onPressed: () => _sendImages(),
              icon: const Icon(
                Icons.camera_alt,
                color: Colors.white,
              )),
        ),
      ],
    );
  }

  Future<void> _sendText(BuildContext context) async {
    if (chatController.text.isNotEmpty) {
      await FirebaseFirestoreService.addTextMessage(
        content: chatController.text,
        receiverId: widget.recieverId,
      );

      //  NOTIFICATION SERVICE AREA FOR ADDING THE PARAMETERS FOR SENTNOTIFICATION

      await notificationService.sendNotification(
          body: chatController.text,
          senterId: FirebaseAuth.instance.currentUser!.uid);

      chatController.clear();
      FocusScope.of(context).unfocus();
    }
    FocusScope.of(context).unfocus();
  }

  Future<void> _sendImages() async {
    final pickedImage = await MediaService.pickImage();
    setState(() => file = pickedImage);
    if (file != null) {
      await FirebaseFirestoreService.addImageMessage(
        receiverId: widget.recieverId,
        file: file!,
      );
      await notificationService.sendNotification(
          body: 'image........',
          senterId: FirebaseAuth.instance.currentUser!.uid);
    }
  }
}
