import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matrix_app_project/core/usecases/colors.dart';
import 'package:matrix_app_project/core/usecases/constants.dart';
import 'package:matrix_app_project/core/util/utils.dart';
import 'package:matrix_app_project/features/presentaition/pages/bottom_nav/bottom_nav.dart';
import 'package:matrix_app_project/features/presentaition/statemanagement/auth_methodes.dart';
import 'package:matrix_app_project/features/presentaition/widgets/costum_button.dart';
import 'package:matrix_app_project/features/presentaition/widgets/textfieled_widget.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  Uint8List? _image;

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthMethods>(
      builder: (context, signInAuthProvider, child) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Sign Up",
            style: TextStyle(
                color: blackClr, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: scffoldBackgroundClr,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                
                  sizeHundred,

                  //
                  Stack(
                    children: [
                      _image != null
                          ? CircleAvatar(
                              radius: 64,
                              backgroundImage: MemoryImage(_image!),
                            )
                          : const CircleAvatar(
                              radius: 64,
                              backgroundImage: NetworkImage(
                                  "https://img.freepik.com/premium-vector/man-avatar-profile-picture-vector-illustration_268834-538.jpg"),
                            ),
                      Positioned(
                          bottom: -10,
                          left: 80,
                          child: IconButton(
                              // image selecting from gallery
                              onPressed: selectImage,
                              icon: const Icon(Icons.add_a_photo)))
                    ],
                  ),
                  sizeFifty,

                  // textfieled area

                  MyTextfieled(
                    controller: signInAuthProvider.signInUserNameTextController,
                    hintText: 'User name',
                    isPasswordType: false,
                    icon: Icons.person,
                  ),
                  sizeTen,

                  MyTextfieled(
                    controller: signInAuthProvider.signInAboutController,
                    hintText: 'About',
                    isPasswordType: false,
                    icon: Icons.abc_outlined,
                  ),

                  sizeTen,

                  MyTextfieled(
                    controller: signInAuthProvider.signInEmailTextController,
                    hintText: 'Email',
                    isPasswordType: false,
                    icon: Icons.mail,
                  ),

                  sizeTen,

                  MyTextfieled(
                    controller: signInAuthProvider.signInPasswordController,
                    hintText: 'password',
                    isPasswordType: true,
                    icon: Icons.lock,
                  ),

                  sizeTwentyFive,

                  // sign In button area

                  MyButton(
                    // onTap: ()=> signInAuthProvider.handleSignIn(context),
                    onTap: () async {
                      String res = await AuthMethods().signUpUser(
                          username: signInAuthProvider
                              .signInUserNameTextController.text,
                          about: signInAuthProvider.signInAboutController.text,
                          email:
                              signInAuthProvider.signInEmailTextController.text,
                          password:
                              signInAuthProvider.signInPasswordController.text,
                          file: _image!);

                      if (res != 'Success') {
                        showSnackBarMethod(res, context);
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BottomNavBar(),
                            ));
                      }
                    },

                    isLogin: false,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
