import 'package:flutter/material.dart';
import 'package:matrix_app_project/core/usecases/constants.dart';
import 'package:matrix_app_project/features/data/functions/firebase_firestore_service.dart';

class BlocReportBottomSheet {
  void showOptions(BuildContext context, String postId, String userId) {
    Color iconColor = Theme.of(context).colorScheme.secondaryContainer;

    showModalBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.primaryFixed,
      context: context,
      builder: (context) {
        return SafeArea(
            child: Wrap(
          children: [
            sizeFifty,
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListTile(
                leading: Icon(Icons.save_alt_sharp, color: iconColor),
                title: Text(
                  "  S A V E ",
                  style: TextStyle(color: iconColor),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),

            // block user
            ListTile(
              leading: Icon(Icons.block, color: iconColor),
              title: Text(
                "  B L O C K",
                style: TextStyle(color: iconColor),
              ),
              onTap: () {
                Navigator.pop(context);
                //  _blockUser(context, userId);
              },
            ),

            // cancel
            ListTile(
              leading: Icon(Icons.remove_circle_outline, color: iconColor),
              title: Text(
                " U N F O L L O W ",
                style: TextStyle(color: iconColor),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            // report message
            ListTile(
              leading: Icon(Icons.report, color: iconColor),
              title: Text(
                "  R E P O R T",
                style: TextStyle(color: iconColor),
              ),
              onTap: () {
                Navigator.pop(context);
                _reportMessage(context, postId, userId);
              },
            ),

            ListTile(
              leading: Icon(Icons.cancel_outlined, color: iconColor),
              title: Text(
                "  C A N C E L",
                style: TextStyle(color: iconColor),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            sizeFifty,
          ],
        ));
      },
    );
  }

  // report message
  void _reportMessage(BuildContext context, String messageId, String userId) {
    Color textColor = Theme.of(context).colorScheme.secondaryContainer;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.primaryFixed,
        title: Text(
          "R E P O R T  U S E R",
          style: TextStyle(color: textColor),
        ),
        content: Text(
          "Are you sure you want to report this user?",
          style: TextStyle(color: textColor),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "C A N C E L",
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
          ),
          TextButton(
            onPressed: () {
              FirebaseFirestoreService().reportUser(messageId, userId);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Message Reported"),
                ),
              );
            },
            child: Text(
              "R E P O R T",
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
          ),
        ],
      ),
    );
  } // report message
}
