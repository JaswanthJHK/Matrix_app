import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matrix_app_project/core/usecases/colors.dart';
import 'package:matrix_app_project/core/usecases/constants.dart';
import 'package:matrix_app_project/core/util/utils.dart';
import 'package:matrix_app_project/features/data/functions/firestore_methodes.dart';
import 'package:matrix_app_project/features/data/models/user.dart';
import 'package:matrix_app_project/features/presentaition/pages/bottom_nav/bottom_nav.dart';
import 'package:matrix_app_project/features/presentaition/statemanagement/provider/user_provider.dart';
import 'package:matrix_app_project/features/presentaition/pages/add_post_section/widgets/add_post_choose_area.dart';
import 'package:matrix_app_project/features/presentaition/widgets/global/costum_appbar_widget.dart';
import 'package:matrix_app_project/features/presentaition/widgets/global/costum_button.dart';
import 'package:matrix_app_project/features/presentaition/widgets/feature_widgets/textfieled_widget.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  //----------------------------this will refresh the null value because the refreshUser will refresh data
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }
  //---------------------------------------------------------------------------------

  Uint8List? _file;

  TextEditingController _captionController = TextEditingController();
  bool _isLoading = false;

  selectImage(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text("Create a post"),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Take a photo"),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.camera);
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Choos from Gallery"),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.gallery);
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _captionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);

    final User? user = Provider.of<UserProvider>(context).getUser;

    return _file == null
        ? Scaffold(
            backgroundColor: scffoldBackgroundClr,
            appBar: const CostumAppBarWidget(
              title: 'Add your post',
              titleAlign: false,
              leading: Image(image: AssetImage('asset/images/Main_logo.png')),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  sizeFifty,
                  Center(
                    child: InkWell(
                      onTap: () => selectImage(context),
                      child: AddPostScreeShowImage(mediaquery: mediaquery),
                    ),
                  ),
                  sizeTwentyFive,
                ],
              ),
            ),
          )
        : Scaffold(
            backgroundColor: scffoldBackgroundClr,
            appBar: const CostumAppBarWidget(
              title: 'Add your post',
              titleAlign: false,
              leading: Image(image: AssetImage('asset/images/Main_logo.png')),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  _isLoading
                      ? const LinearProgressIndicator()
                      : const Padding(
                          padding: EdgeInsets.only(top: 0),
                        ),
                  sizeFifty,
                  Center(
                    child: InkWell(
                      onTap: () {},
                      child: AddPostScreenImageUpload(
                          mediaquery: mediaquery, file: _file),
                    ),
                  ),
                  sizeTwentyFive,
                  MyTextfieled(
                      controller: _captionController,
                      hintText: 'Add Caption',
                      icon: Icons.abc_outlined),
                  sizeFifty,
                  MyNormalButton(
                    onTap: () {
                      postImage(user!.uid, user.username, user.photoUrl);
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const BottomNavBar(),
                      ));
                    },
                    text: 'Upload',
                    size: 65,
                  ),
                ],
              ),
            ),
          );
  }

  postImage(
    String uid,
    String username,
    String profImage,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FirestoreMethodes().postUpload(
        _captionController.text,
        _file!,
        uid,
        username,
        profImage,
      );
      if (res == 'success') {
        setState(() {
          _isLoading = false;
        });
        showSnackBarMethod('Posted!', context);
        clearImage();
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBarMethod(res, context);
      }
    } catch (e) {
      showSnackBarMethod(e.toString(), context);
    }
  }
}
