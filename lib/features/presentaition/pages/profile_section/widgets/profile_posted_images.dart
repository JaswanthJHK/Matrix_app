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
    required this.initialIndex,
    required this.snaps,
  });

  final ProfilPage widget;
  final int initialIndex;
  final List<DocumentSnapshot> snaps;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: const CostumAppBarWidget(
        title: 'Posts',
        titleAlign: true,
      ),
      body:

      // commented are previous data its also working but not perfect
          //  StreamBuilder(
          //   stream: FirebaseFirestore.instance
          //       .collection('posts')
          //       .where('uid', isEqualTo: widget.uid)
          //       .orderBy('datePublished', descending: true)
          //       .snapshots(),
          //   builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     }

          //     return
          //      ListView.builder(

          //       shrinkWrap: true,
          //       itemCount: snapshot.data?.docs.length ?? 0,
          //       itemBuilder: (context, index) {
          //         DocumentSnapshot snap = snapshot.data!.docs[index];
          //         return ProfilePostedCard(
          //           snap: snap,
          //         );
          //       },
          //     );
          //   },
          // ),

          ListView.builder(
        controller: PageController(initialPage: initialIndex),
        itemCount: snaps.length,
        itemBuilder: (context, index) {
          return ProfilePostedCard(
            snap: snaps[index],
          );
        },
      ),
    );
  }
}
