import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:matrix_app_project/core/usecases/colors.dart';
import 'package:matrix_app_project/core/usecases/constants.dart';
import 'package:matrix_app_project/core/util/utils.dart';
import 'package:matrix_app_project/features/presentaition/widgets/costum_appbar_widget.dart';
import 'package:matrix_app_project/features/presentaition/widgets/costum_button.dart';
import 'package:matrix_app_project/features/presentaition/widgets/image_dialog.dart';

class ProfilPage extends StatefulWidget {
  final String uid;
  ProfilPage({super.key, required this.uid});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  var userData = {};
  int postLength = 0;
  int followers = 0;
  int following = 0;
  bool isLoading = false;
  bool isFollowing = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      // get post length
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      postLength = postSnap.docs.length;
      userData = userSnap.data()!;
      followers = userSnap.data()!['followes'].length;
      following = userSnap.data()!['following'].length;
      isFollowing = userSnap
          .data()![followers]
          .contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {});
    } catch (e) {
      showSnackBarMethod(e.toString(), context);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            backgroundColor: scffoldBackgroundClr,
            appBar: const CostumAppBarWidget(
              title: 'Profile',
              leading: Image(image: AssetImage('asset/images/Main_logo.png')),
              showActionIcon: true,
            ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onLongPress: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 9.0, sigmaY: 9.0),
                                    child: ImageDialog(
                                      imageUrl: userData['photoUrl'],
                                    ),
                                  );
                                },
                              );
                              Future.delayed(Duration(seconds: 2), () {
                                Navigator.pop(context);
                              });
                            },
                            child: CircleAvatar(
                              backgroundColor: greyDark,
                              backgroundImage: NetworkImage(
                                userData['photoUrl'],
                              ),
                              radius: 60,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  sizeTen,
                                  Text(
                                    userData['username'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                  sizeEight,
                                  Text(userData['about']),

                                 FirebaseAuth.instance.currentUser!.uid == widget.uid? EditProfileButton(
                                      onTap: () {},
                                      text: 'Edit Profile',
                                      size: 30,
                                      ):isFollowing ? EditProfileButton(
                                      onTap: () {},
                                      text: 'Unfollow',
                                      size: 30,
                                      ): EditProfileButton(
                                      onTap: () {},
                                      text: 'Follow',
                                      size: 30,
                                      )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      sizeTwentyFive,
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              buildStatColumn(postLength, "Posts"),
                              buildStatColumn(followers, "Followers"),
                              buildStatColumn(following, "Following"),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(),
                FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('posts')
                      .where('uid', isEqualTo: widget.uid)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return GridView.builder(
                      shrinkWrap: true,
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        DocumentSnapshot snap =
                            (snapshot.data! as dynamic).docs[index];
                        return Image(
                          image: NetworkImage(
                            snap['postUrl'],
                          ),
                          fit: BoxFit.cover,
                        );
                      },
                    );
                  },
                )
              ],
            ),
          );
  }

  Column buildStatColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.grey),
        )
      ],
    );
  }
}
