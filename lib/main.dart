import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:matrix_app_project/features/auth/splash_screen.dart';
// import 'package:matrix_app_project/features/data/functions/user_data/get_user_data.dart';
import 'package:matrix_app_project/features/presentaition/statemanagement/auth_methodes.dart';
import 'package:matrix_app_project/features/presentaition/statemanagement/login_auth_methods.dart';
import 'package:matrix_app_project/features/presentaition/statemanagement/provider/add_post/edit_post.dart';
import 'package:matrix_app_project/features/presentaition/statemanagement/provider/add_post/edit_profile.dart';
import 'package:matrix_app_project/features/presentaition/statemanagement/provider/chat_provider/chat_provider.dart';
import 'package:matrix_app_project/features/presentaition/statemanagement/provider/get_data/get_data.dart';
// import 'package:matrix_app_project/features/presentaition/statemanagement/provider/comment_provider/comment_length_notifier.dart';
// import 'package:matrix_app_project/features/presentaition/statemanagement/provider/comment_provider/comment_provider.dart';
// import 'package:matrix_app_project/features/presentaition/statemanagement/provider/follow_unfollow_user/follow_unfollow_provider.dart';
import 'package:matrix_app_project/features/presentaition/statemanagement/provider/get_user_profile/get_userdata_profile_provider.dart';
import 'package:matrix_app_project/features/presentaition/statemanagement/provider/user_data_provider/follow_user.dart';
import 'package:matrix_app_project/features/presentaition/statemanagement/provider/search_provider/search_provider.dart';
import 'package:matrix_app_project/features/presentaition/statemanagement/provider/user_provider.dart';
import 'package:provider/provider.dart';


Future<void> _backgroundMessageHandler(
    RemoteMessage message) async {
  await Firebase.initializeApp(
   
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthMethods(),
        ),
        // ChangeNotifierProvider(
        //   create: (context) => ProfileDataProvider(), // we desable this in 19/10/23  for checking
        // ),

        ChangeNotifierProvider(
          create: (context) => LoginAuth(),
        ),

        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => EditPostProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => EditProfileProvider(),
        ),

        ChangeNotifierProvider(
          create: (context) => UserDataProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FirebaseChatProvider(),
        ),

        ChangeNotifierProvider(
          create: (context) => GetUserDataProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
