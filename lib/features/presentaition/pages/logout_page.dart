import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:matrix_app_project/features/presentaition/pages/login_page.dart';
import 'package:matrix_app_project/features/presentaition/widgets/costum_appbar_widget.dart';
import 'package:matrix_app_project/features/presentaition/widgets/snackbar_widget.dart';

class LogOutPage extends StatefulWidget {
  const LogOutPage({super.key});

  @override
  State<LogOutPage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<LogOutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CostumAppBarWidget(
        leading: IconButton(onPressed:() =>Navigator.pop(context) , icon: const BackButton()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("You Logged in successfully"),
            ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    warning(context, "You're logged out");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ));
                  });
                },
                child: const Text("Logout")),
          ],
        ),
      ),
    );
  }
}
