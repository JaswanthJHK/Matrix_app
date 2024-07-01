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
              decoration: const BoxDecoration(
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
            leading: const Icon(Icons.policy),
            title: const Text('Privacy Policy'),
            onTap: () {
              showPrivacyDialog(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {
              showaboutDialog(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
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
      return const LogoutAlertDialog();
    },
  );
}

void showaboutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const AboutDialogone();
    },
  );
}

void showPrivacyDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const PrivacyPolicyDialog(),
  );
}
