import 'package:flutter/material.dart';
import 'package:matrix_app_project/core/usecases/colors.dart';
import 'package:matrix_app_project/features/presentaition/widgets/feature_widgets/logout_show_dialog.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                color: scffoldBackgroundClr,
              ),
              child:
                  //  Text(
                  //   'Drawer Menu',
                  //   style: TextStyle(
                  //     color: blackClr,
                  //     fontSize: 24,
                  //   ),
                  // ),
                  Image.asset('asset/images/Main_logo.png')),
          ListTile(
            leading: Icon(Icons.policy),
            title: Text('Privacy Policy'),
            onTap: () {
              showPrivacyDialog(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () {
              showaboutDialog(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              // Show the logout confirmation dialog
              showLogoutDialog(context);
            },
          ),
        ],
      ),
    );
  }
}

void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return LogoutAlertDialog();
    },
  );
}

void showaboutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AboutDialogone();
    },
  );
}

void showPrivacyDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => PrivacyPolicyDialog(),
  );
}
