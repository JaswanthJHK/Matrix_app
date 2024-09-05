import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:matrix_app_project/core/usecases/colors.dart';
import 'package:matrix_app_project/core/usecases/constants.dart';
import 'package:matrix_app_project/features/presentaition/pages/profile_section/screen/edit_profile.dart';

import 'package:matrix_app_project/features/presentaition/pages/profile_section/widgets/menu_items/navigation_drawer.dart';
import 'package:matrix_app_project/features/presentaition/statemanagement/provider/edit_profile/edit_profile.dart';
import 'package:matrix_app_project/features/presentaition/statemanagement/provider/user_data_provider/follow_user.dart';
import 'package:matrix_app_project/features/presentaition/pages/profile_section/widgets/followers_list.dart';
import 'package:matrix_app_project/features/presentaition/widgets/global/costum_appbar_widget.dart';
import 'package:matrix_app_project/features/presentaition/widgets/global/costum_button.dart';
import 'package:matrix_app_project/features/presentaition/pages/profile_section/widgets/image_dialog.dart';
import 'package:matrix_app_project/features/presentaition/pages/profile_section/widgets/profile_post_grid.dart';
import 'package:provider/provider.dart';

class ProfilPage extends StatefulWidget {
  final String uid;
  ProfilPage({super.key, required this.uid});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage>
    with AutomaticKeepAliveClientMixin<ProfilPage> {
  var userData = {};
  int postLength = 0;

  int? followers;
  int? following;
  bool isLoading = false;
  bool isFollowing = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            backgroundColor: Theme.of(context).colorScheme.primary,
            appBar: CostumAppBarWidget(
              title: userData['username'],
              titleAlign: true,
              // leading: Image(image: AssetImage('asset/images/Main_logo.png')),
              showActionIcon: true,
            ),
            drawer: const DrawerMenu(),
            //       AppBar(
            //         backgroundColor: scffoldBackgroundClr,
            //         elevation: 0,
            //   title: Text(
            //     'Profile',
            //     style: TextStyle(
            //         color: blackClr, fontSize: 25, fontWeight: FontWeight.bold),
            //   ),
            //   centerTitle: true,
            //   actions: [
            //     PopupMenuButton<MenuItem>(
            //       itemBuilder: (context) => [
            //         ...MenuItems.itemFirst.map(buildItem).toList(),
            //       ],
            //     )
            //   ],
            // ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Consumer<EditProfileProvider>(
                        builder: (context, value, child) {
                          return Row(
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
                                  Future.delayed(const Duration(seconds: 2),
                                      () {
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      sizeTen,
                                      Text(
                                        userData['username'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary),
                                      ),
                                      sizeEight,
                                      Text(userData['about']),
                                      FirebaseAuth.instance.currentUser!.uid ==
                                              widget.uid
                                          ? EditProfileButton(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProfileEditPage(
                                                        userId: widget.uid,
                                                      ),
                                                    ));
                                              },
                                              text: 'Edit Profile',
                                              size: 30,
                                            )
                                          : Consumer<UserDataProvider>(
                                              builder: (context, followValue,
                                                  child) {
                                                return isFollowing
                                                    ? EditProfileButton(
                                                        onTap: () async {
                                                          followValue.followUsers(
                                                              uid: FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid,
                                                              followId:
                                                                  userData[
                                                                      'uid']);

                                                          setState(() {
                                                            isFollowing = false;
                                                            followers =
                                                                (followers! -
                                                                    1);
                                                          });
                                                        },
                                                        text: 'Unfollow',
                                                        size: 30,
                                                      )
                                                    : EditProfileButton(
                                                        onTap: () async {
                                                          followValue.followUsers(
                                                              uid: FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid,
                                                              followId:
                                                                  userData[
                                                                      'uid']);

                                                          setState(() {
                                                            isFollowing = true;
                                                            followers =
                                                                (followers! +
                                                                    1);
                                                          });
                                                        },
                                                        text: 'Follow',
                                                        size: 30,
                                                      );
                                              },
                                            )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          );
                        },
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
                              InkWell(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FollowersList(
                                            name: "Followers",
                                            followers: userData['followers']),
                                      )),
                                  child:
                                      buildStatColumn(followers, "Followers")),
                              InkWell(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FollowersList(
                                            name: "Following",
                                            followers: userData['following']),
                                      )),
                                  child:
                                      buildStatColumn(following, "Following")),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(
                  height: 0.1,
                ),
                sizeTen,
                ProfilePostGrid(widget: widget)
              ],
            ),
          );
  }

  Column buildStatColumn(int? users, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Consumer<UserDataProvider>(builder: (context, value, child) {
          return Text(
            users.toString(),
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          );
        }),
        Text(
          label,
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.grey),
        )
      ],
    );
  }

  getData() async {
    followers ??= 0;
    following ??= 0;
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
      followers = userSnap.data()!['followers'].length;
      following = userSnap.data()!['following'].length;
      isFollowing = userSnap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {});
    } catch (e) {
      // showSnackBarMethod(e.toString(), context);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
