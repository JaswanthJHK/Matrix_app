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

class AboutDialogone extends StatelessWidget {
  const AboutDialogone({super.key});

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      title: const Text("About us"),
      content: const Text("Matrix is a revolutionary social media app that lets you express yourself through stunning posts, connect with friends and communities through seamless chat and group conversations, discover new interests and people, all while staying secure with end-to-end encryption and data ownership. It's a customizable, ad-free platform that puts you in control of your experience. Download Matrix today and join the future of social interaction!",),
       actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog
          },
          child: const Text('Ok'),
        ),
 ]
    );
  }
}

class PrivacyPolicyDialog extends StatelessWidget {
  const PrivacyPolicyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      title: const Text("Privacy policy"),
      content: const Text('''
Matrix Privacy Policy: Protecting Your Information
This Privacy Policy outlines how Matrix collects, uses, and discloses your information. We value your privacy and strive to provide a secure and transparent platform.

Information We Collect:

Personal Information: Provided directly by you, such as name, email, and profile picture.
Content: Posts, captions, comments, and other content you share on Matrix.
Messaging: Your messages and chats with other users.
Device Information: Device type, operating system, and unique identifier.
Usage Information: Time and date of use, pages viewed, and features used.
Log Data: IP address, browser type, and referring website.
How We Use Information:

Provide, maintain, and improve the Matrix App.
Develop new features and services to enhance your experience.
Personalize your experience by presenting relevant content and recommendations.
Send promotional emails and notifications based on your preferences.
Respond to your inquiries and support requests efficiently.
Comply with applicable laws and regulations to ensure a safe and legal platform.'''),
 actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog
          },
          child: const Text('Ok'),
        ),
 ]
    );
  }
}