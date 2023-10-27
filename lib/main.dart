import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:matrix_app_project/features/presentaition/pages/splash_screen.dart';
import 'package:matrix_app_project/features/presentaition/statemanagement/auth_methodes.dart';
import 'package:matrix_app_project/features/presentaition/statemanagement/login_auth_methods.dart';
import 'package:matrix_app_project/features/presentaition/statemanagement/provider/user_provider.dart';
import 'package:provider/provider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        //   create: (context) => AddPost(),   // we desable this in 19/10/23  for checking 
        // ),


        ChangeNotifierProvider(
          create: (context) => LoginAuth(),
        ),

        ChangeNotifierProvider(
          create: (context) => LoginAuth(),
        ),

         ChangeNotifierProvider(create: (context) => UserProvider(),) // user provider class from rivanranavat
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
        
         
          useMaterial3: true,
        ),
        home:   SplashScreen(),
      ),
    );
  }
}
