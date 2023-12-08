import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:matrix_app_project/features/presentaition/widgets/feature_widgets/logout_show_dialog.dart';
import 'package:matrix_app_project/features/presentaition/widgets/global/costum_appbar_widget.dart';

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
                  // FirebaseAuth.instance.signOut().then((value) {
                    
                  //   warning(context, "You're logged out");
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => const LoginPage(),
                  //       ));
                  // });
                       showDialog(
                            context: context,
                            builder: (context) {
                              // POST EDIT DELETE SHOWDIALOG AREA ------------------------
                              return BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                                child:const LogoutAlertDialog()
                              );
                            },
                          );
                  
                },
                child: const Text("Logout")),
          ],
        ),
      ),
    );
  }
}
