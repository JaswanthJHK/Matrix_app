import 'package:flutter/material.dart';
import 'package:matrix_app_project/features/presentaition/pages/profile_section/screen/profile_page.dart';
import 'package:matrix_app_project/features/presentaition/statemanagement/provider/chat_provider/chat_provider.dart';
import 'package:matrix_app_project/features/presentaition/pages/chat_section/widget/chat_messages.dart';
import 'package:matrix_app_project/features/presentaition/pages/chat_section/widget/chat_textfield.dart';
import 'package:matrix_app_project/features/service/notification_service.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.userId});
  final String userId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final notificationService = NotificationService();
  @override
  void initState() {
    Provider.of<FirebaseChatProvider>(context, listen: false)
      ..getUserById(widget.userId)
      ..getMessages(widget.userId);
    super.initState();
    notificationService.firebaseNotification(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ChatMessages(receiverId: widget.userId),
            // ChatTextField(receiverId: widget.userId)
            ChatTextField(recieverId: widget.userId)
          ],
        ),
      ),
    );
  }

 

  AppBar _buildAppBar() => AppBar(
      elevation: 0,
      foregroundColor: Colors.black,
      backgroundColor: Colors.transparent,
      title: Consumer<FirebaseChatProvider>(
        builder: (context, value, child) => value.user != null
            ? InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilPage(uid: widget.userId),
                      ));
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(value.user!.photUrl),
                      radius: 20,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      children: [
                        Text(
                          value.user!.username,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          value.user!.isOnline ? 'Online' : 'Offline',
                          style: TextStyle(
                            color: value.user!.isOnline
                                ? Colors.green
                                : Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : const SizedBox(
                child: Text('huiuuuu'),
              ),
      ));
}
