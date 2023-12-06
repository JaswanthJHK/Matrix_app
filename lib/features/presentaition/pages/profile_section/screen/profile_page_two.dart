// import 'dart:ui';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:matrix_app_project/core/usecases/colors.dart';
// import 'package:matrix_app_project/core/usecases/constants.dart';
// import 'package:matrix_app_project/features/presentaition/pages/profile_section/widgets/image_dialog.dart';
// import 'package:matrix_app_project/features/presentaition/pages/profile_section/widgets/profile_post_grid.dart';
// import 'package:matrix_app_project/features/presentaition/statemanagement/provider/user_data_provider/follow_user.dart';
// import 'package:matrix_app_project/features/presentaition/widgets/global/costum_appbar_widget.dart';
// import 'package:matrix_app_project/features/presentaition/widgets/global/costum_button.dart';
// // import 'package:matrix_app_project/features/presentation/statemanagement/provider/user_data_provider/follow_user.dart';
// // import 'package:matrix_app_project/features/presentation/widgets/global/costum_appbar_widget.dart';
// // import 'package:matrix_app_project/features/presentation/widgets/global/costum_button.dart';
// // import 'package:matrix_app_project/features/presentation/pages/profile_section/widgets/image_dialog.dart';
// import 'package:provider/provider.dart';

// class ProfilePageTwo extends StatefulWidget {
//   final String uid;
//   ProfilePageTwo({Key? key, required this.uid}) : super(key: key);

//   @override
//   State<ProfilePageTwo> createState() => _ProfilPageState();
// }

// class _ProfilPageState extends State<ProfilePageTwo> {
//   var userData = {};
//   int postLength = 0;
//   int? followers;
//   int? following;
//   bool isLoading = false;
//   bool isFollowing = false;

//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }

//   getData() async {
//     followers ??= 0;
//     following ??= 0;
//     setState(() {
//       isLoading = true;
//     });
//     try {
//       var userSnap = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(widget.uid)
//           .get();

//       // Fetch post count
//       var postSnap = await FirebaseFirestore.instance
//           .collection('posts')
//           .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//           .get();

//       postLength = postSnap.docs.length;
//       userData = userSnap.data()!;
//       followers = userSnap.data()!['followers'].length;
//       following = userSnap.data()!['following'].length;
//       isFollowing = userSnap
//           .data()!['followers']
//           .contains(FirebaseAuth.instance.currentUser!.uid);
//       setState(() {});
      
//       // Listen to real-time updates
//       FirebaseFirestore.instance
//           .collection('users')
//           .doc(widget.uid)
//           .snapshots()
//           .listen((event) {
//         setState(() {
//           followers = event.data()!['followers'].length;
//           following = event.data()!['following'].length;
//           isFollowing = event.data()!['followers'].contains(
//             FirebaseAuth.instance.currentUser!.uid,
//           );
//         });
//       });

//     } catch (e) {
//       // Handle errors
//     }
//     setState(() {
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return isLoading
//         ? const Center(
//             child: CircularProgressIndicator(),
//           )
//         : Scaffold(
//             backgroundColor: scffoldBackgroundClr,
//             appBar: const CostumAppBarWidget(
//               title: 'Profile',
//               leading: Image(image: AssetImage('asset/images/Main_logo.png')),
//               showActionIcon: true,
//             ),
//             body: ListView(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(10),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           GestureDetector(
//                             onLongPress: () {
//                               showDialog(
//                                 context: context,
//                                 builder: (BuildContext context) {
//                                   return BackdropFilter(
//                                     filter: ImageFilter.blur(
//                                         sigmaX: 9.0, sigmaY: 9.0),
//                                     child: ImageDialog(
//                                       imageUrl: userData['photoUrl'],
//                                     ),
//                                   );
//                                 },
//                               );
//                               Future.delayed(Duration(seconds: 2), () {
//                                 Navigator.pop(context);
//                               });
//                             },
//                             child: CircleAvatar(
//                               backgroundColor: greyDark,
//                               backgroundImage: NetworkImage(
//                                 userData['photoUrl'],
//                               ),
//                               radius: 60,
//                             ),
//                           ),
//                           Expanded(
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 15),
//                               child: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   sizeTen,
//                                   Text(
//                                     userData['username'],
//                                     style: const TextStyle(
//                                         fontWeight: FontWeight.w600,
//                                         fontSize: 18),
//                                   ),
//                                   sizeEight,
//                                   Text(userData['about']),
//                                   FirebaseAuth.instance.currentUser!.uid ==
//                                           widget.uid
//                                       ? EditProfileButton(
//                                           onTap: () {
                                           
//                                           },
//                                           text: 'Edit Profile',
//                                           size: 30,
//                                         )
//                                       : Consumer<UserDataProvider>(builder:
//                                           (context, followValue, child) {
//                                           return isFollowing
//                                               ? EditProfileButton(
//                                                   onTap: () async {
//                                                     followValue.followUsers(
//                                                         uid: FirebaseAuth
//                                                             .instance
//                                                             .currentUser!
//                                                             .uid,
//                                                         followId:
//                                                             userData['uid']);
                                                  
//                                                     setState(() {
//                                                       isFollowing = false;
//                                                       //   followers--;
//                                                     });
//                                                   },
//                                                   text: 'Unfollow',
//                                                   size: 30,
//                                                 )
//                                               : EditProfileButton(
//                                                   onTap: () async {
//                                                     followValue.followUsers(
//                                                         uid: FirebaseAuth
//                                                             .instance
//                                                             .currentUser!
//                                                             .uid,
//                                                         followId:
//                                                             userData['uid']);
                                                   
//                                                     setState(() {
//                                                       isFollowing = true;
//                                                       //followers++;
//                                                     });
//                                                   },
//                                                   text: 'Follow',
//                                                   size: 30,
//                                                 );
//                                         })
//                                 ],
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                       // ... (Your existing code for displaying user details)

//                       // Example of using StreamBuilder for real-time updates
//                       StreamBuilder<DocumentSnapshot>(
//                         stream: FirebaseFirestore.instance
//                             .collection('users')
//                             .doc(widget.uid)
//                             .snapshots(),
//                         builder: (context, snapshot) {
//                           if (!snapshot.hasData) {
//                             return CircularProgressIndicator();
//                           }

//                           // Access real-time data using snapshot
//                           var updatedFollowers =
//                               snapshot.data!['followers'].length;
//                           var updatedFollowing =
//                               snapshot.data!['following'].length;

//                           return SizedBox(
//                             width: double.infinity,
//                             child: Padding(
//                               padding: const EdgeInsets.only(left: 10),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   buildStatColumn(postLength, "Posts"),
//                                   buildStatColumn(updatedFollowers, "Followers"),
//                                   buildStatColumn(updatedFollowing, "Following"),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//                 const Divider(),
//                  ProfilePostGrid(widget: widget as dynamic)
//               ],
//             ),
//           );
//   }

//   Column buildStatColumn(int? users, String label) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Consumer<UserDataProvider>(builder: (context, value, child) {
//           return Text(
//             users.toString(),
//             style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//           );
//         }),
//         Text(
//           label,
//           style: const TextStyle(
//               fontSize: 15, fontWeight: FontWeight.w400, color: Colors.grey),
//         )
//       ],
//     );
//   }
// }
