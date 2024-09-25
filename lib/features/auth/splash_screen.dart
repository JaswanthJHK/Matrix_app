// import 'package:firebase_auth/firebase_auth.dart';
// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:matrix_app_project/core/usecases/colors.dart';
import 'package:matrix_app_project/features/presentaition/pages/bottom_nav/bottom_nav.dart';
import 'package:matrix_app_project/features/auth/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SplashScreen> {
 

  @override
  Widget build(BuildContext context) {
    splashFuntion(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Image.asset(
          'asset/images/Main_logo_final.png',
          height: 190,
        ),
      ),
    );
  }
}

splashFuntion(BuildContext context) async {
  // FirebaseAuth auth = FirebaseAuth.instance;
  await Future.delayed(const Duration(seconds: 2));
  // auth.currentUser?.uid != null
  //     ? Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const LoginPage(),
  //         ))
  //     :
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return const BottomNavBar(); // if user logged in then this screen will show
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                }
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: blackClr,
                  ),
                );
              }
              return const LoginPage(); // if not then this screen will show for
            }),
      ));
}
