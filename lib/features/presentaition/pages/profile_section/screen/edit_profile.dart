import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matrix_app_project/core/usecases/colors.dart';
import 'package:matrix_app_project/core/usecases/constants.dart';
import 'package:matrix_app_project/core/util/utils.dart';
import 'package:matrix_app_project/features/presentaition/pages/bottom_nav/bottom_nav.dart';
import 'package:matrix_app_project/features/presentaition/statemanagement/auth_methodes.dart';
import 'package:matrix_app_project/features/presentaition/statemanagement/provider/edit_profile/edit_profile.dart';
import 'package:matrix_app_project/features/presentaition/widgets/global/costum_button.dart';
import 'package:matrix_app_project/features/presentaition/widgets/feature_widgets/textfieled_widget.dart';
import 'package:provider/provider.dart';

class ProfileEditPage extends StatefulWidget {
  final userId;
  const ProfileEditPage({super.key, required this.userId});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  var nameController = TextEditingController();
  var aboutController = TextEditingController();
  Uint8List? _image;
  var proUserData = {};

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
            "Edit Profile",
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
                    controller: nameController,
                    hintText: 'User name',
                    isPasswordType: false,
                    icon: Icons.person,
                  ),
                  sizeTen,

                  MyTextfieled(
                    controller: aboutController,
                    hintText: 'About',
                    isPasswordType: false,
                    icon: Icons.abc_outlined,
                  ),

                  sizeTen,

                  // MyTextfieled(
                  //   controller: signInAuthProvider.signInEmailTextController,
                  //   hintText: 'Email',
                  //   isPasswordType: false,
                  //   icon: Icons.mail,
                  // ),

                  // sizeTen,

                  // MyTextfieled(
                  //   controller: signInAuthProvider.signInPasswordController,
                  //   hintText: 'password',
                  //   isPasswordType: true,
                  //   icon: Icons.lock,
                  // ),

                  sizeTwentyFive,

                  // sign In button area

                  MyNormalButton(
                      onTap: () {
                        Provider.of<EditProfileProvider>(context, listen: false)
                            .editProfile(nameController.text.trim(),
                                aboutController.text.trim(), _image!);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BottomNavBar(),
                            ));
                      },
                      text: 'Updadte',
                      size: 65)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  getData() async {
    try {
      var userSnapp = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .get();

      // get post length
      // var postSnap = await FirebaseFirestore.instance
      //     .collection('posts')
      //     .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      //     .get();

      proUserData = userSnapp.data()!;
    } catch (e) {
      // showSnackBarMethod(e.toString(), context);
    }
  }
}
