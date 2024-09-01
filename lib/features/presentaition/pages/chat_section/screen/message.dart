import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:matrix_app_project/core/usecases/colors.dart';
import 'package:matrix_app_project/features/data/functions/firebase_firestore_service.dart';
import 'package:matrix_app_project/features/presentaition/statemanagement/provider/chat_provider/chat_provider.dart';
import 'package:matrix_app_project/features/presentaition/pages/chat_section/widget/chat_user_list.dart';
import 'package:matrix_app_project/features/presentaition/widgets/global/costum_appbar_widget.dart';
import 'package:provider/provider.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

// final userData = [
//   UserModel(
//       email: 'test1@gmail.com',
//       uid: '1',
//       photoUrl:
//           'https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-1080x675.jpg',
//       username: 'Siyad',
//       about: 'devloper',
//       followers: [1],
//       following: [1],
//       lastActive: DateTime.now(),
//       isOnline: true),
//       User(
//       email: 'test2@gmail.com',
//       uid: '2',
//       photoUrl:
//           'https://imgupscaler.com/images/samples/animal-after.webp',
//       username: 'Sugu',
//       about: 'devloper',
//       followers: [1],
//       following: [1],
//       lastActive: DateTime.now(),
//       isOnline: true),
// ];

class _MessagePageState extends State<MessagePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Provider.of<FirebaseChatProvider>(context, listen: false).getAllUser();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        FirebaseFirestoreService.updateUserData({
          'lastActive': DateTime.now(),
          'isOnline': true,
        });
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        FirebaseFirestoreService.updateUserData({'isOnline': false});
        break;
      case AppLifecycleState.hidden:
      // TODO: Handle this case.
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: const CostumAppBarWidget(
        title: "Messeges",
        titleAlign: false,
        leading: Image(image: AssetImage('asset/images/Main_logo.png')),
      ),
      body: Consumer<FirebaseChatProvider>(
        builder: (context, chatvalue, child) {
          {
            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: chatvalue.users.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => chatvalue.users[index].uid !=
                      FirebaseAuth.instance.currentUser?.uid
                  ? UserItems(user: chatvalue.users[index])
                  : const SizedBox(),
            );
          }
        },
      ),
    );
  }
}
