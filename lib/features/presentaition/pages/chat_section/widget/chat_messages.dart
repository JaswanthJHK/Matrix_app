import 'package:flutter/material.dart';
import 'package:matrix_app_project/features/data/models/message_model.dart';
import 'package:matrix_app_project/features/presentaition/statemanagement/provider/chat_provider/chat_provider.dart';
import 'package:matrix_app_project/features/presentaition/pages/chat_section/widget/chat_message_bubble.dart';
import 'package:matrix_app_project/features/presentaition/pages/chat_section/widget/empty_widget.dart';
import 'package:provider/provider.dart';

class ChatMessages extends StatelessWidget {
  ChatMessages({super.key, required this.receiverId});

  final String receiverId;

  final messages = [
    Message(
      senderId: '2',
      receiverId: 'IMgAyfyeMvhUExzyoNsJVxc1Pr72',
      sentTime: DateTime.now(),
      content: 'Hello',
      messageType: MessageType.text,
    ),
    Message(
      senderId: 'IMgAyfyeMvhUExzyoNsJVxc1Pr72',
      receiverId: '2',
      sentTime: DateTime.now(),
      content: 'Hii',
      messageType: MessageType.text,
    ),
    Message(
      senderId: '2',
      receiverId: 'IMgAyfyeMvhUExzyoNsJVxc1Pr72',
      sentTime: DateTime.now(),
      content: 'Hello how are you',
      messageType: MessageType.text,
    ),
    Message(
      senderId: 'IMgAyfyeMvhUExzyoNsJVxc1Pr72',
      receiverId: '2',
      sentTime: DateTime.now(),
      content:
          'https://images.unsplash.com/photo-1699694927472-46a4fcf68973?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      messageType: MessageType.image,
    ),
    Message(
      senderId: '2',
      receiverId: 'IMgAyfyeMvhUExzyoNsJVxc1Pr72',
      sentTime: DateTime.now(),
      content: 'Okay bye',
      messageType: MessageType.text,
    ),
  ];

  @override
  Widget build(BuildContext context) => Consumer<FirebaseChatProvider>(
        builder: (context, Messagevalue, child) => Messagevalue.messages.isEmpty
            ? const Expanded(
                child: EmptyWidget(icon: Icons.waving_hand, text: 'Say Hello'),
              )
            : Expanded(
                child: ListView.builder(
                  controller:
                      Provider.of<FirebaseChatProvider>(context, listen: false)
                          .scrollController,
                  itemCount: Messagevalue.messages.length,
                  itemBuilder: (context, index) {
                    final isTextMessege =
                        Messagevalue.messages[index].messageType ==
                            MessageType.text;
                    // final isMe =
                    //     receiverId != Messagevalue.messages[index].senderId;

                    return isTextMessege
                        ? MessageBubble(
                            
                            message: Messagevalue.messages[index],
                            isImage: false,
                          )
                        : MessageBubble(
                           
                            message: Messagevalue.messages[index],
                            isImage: true,
                          );
                  },
                ),
              ),
      );
}
