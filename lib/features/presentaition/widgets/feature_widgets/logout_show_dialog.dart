import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:matrix_app_project/features/auth/login_page.dart';
import 'package:matrix_app_project/features/presentaition/widgets/global/snackbar_widget.dart';

class LogoutAlertDialog extends StatelessWidget {
  const LogoutAlertDialog({super.key});

   @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Logout'),
      content: const Text('Are you sure you want to logout?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog
          },
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            FirebaseAuth.instance.signOut().then((value) {
                    
                    warning(context, "You're logged out");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ));
                  });
            Navigator.pop(context); // Close the dialog
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}