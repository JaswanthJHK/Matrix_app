import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:matrix_app_project/core/usecases/colors.dart';
import 'package:matrix_app_project/features/presentaition/pages/profile_section/screen/profile_page.dart';
import 'package:matrix_app_project/features/presentaition/pages/profile_section/widgets/profile_posted_images_card.dart';
import 'package:matrix_app_project/features/presentaition/widgets/global/costum_appbar_widget.dart';

class ProfilePostedImages extends StatelessWidget {
  const ProfilePostedImages({
    super.key,
    required this.widget,
  });

  final ProfilPage widget;

  @override
  // Widget build(BuildContext context) {
  //   return FutureBuilder(
  //     future: FirebaseFirestore.instance
  //         .collection('posts')
  //         .where('uid', isEqualTo: widget.uid)
  //         .get(),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return const Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       }
  //     return ListView.builder(
  //         shrinkWrap: true,
  //         itemCount: (snapshot.data! as dynamic).docs.length,
       
  //         itemBuilder: (context, index) {
  //           DocumentSnapshot snap = (snapshot.data! as dynamic).docs[index];
  //           return PostCard(
  //             snap: snap,
  //           );
  //         },
  //       );
  //     },
  //   );
  // }
   Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: scffoldBackgroundClr,
        appBar: const CostumAppBarWidget(
          title: 'Posts',
          
        ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .where('uid', isEqualTo: widget.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
    
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data?.docs.length ?? 0,
            itemBuilder: (context, index) {
              DocumentSnapshot snap = snapshot.data!.docs[index];
              return ProfilePostedCard(
                snap: snap,
              );
            },
          );
        },
      ),
    );
  }


}
