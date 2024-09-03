import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:matrix_app_project/features/presentaition/pages/profile_section/screen/profile_page.dart';
import 'package:matrix_app_project/features/presentaition/pages/profile_section/widgets/profile_posted_images.dart';

class ProfilePostGrid extends StatelessWidget {
  const ProfilePostGrid({
    super.key,
    required this.widget,
  });

  final ProfilPage widget;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: widget.uid)
          .orderBy('datePublished', descending: true)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          // return Center(
          //   child: Text('Error: ${snapshot.error}-------------==+++++++++'),
          // );
          print('Error: ${snapshot.error}-------------==+++++++++');
        }
        if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No posts available.'),
          );
        }
        return GridView.builder(
          shrinkWrap: true,
          itemCount: (snapshot.data! as dynamic).docs.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            DocumentSnapshot snap = (snapshot.data! as dynamic).docs[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePostedImages(widget: widget,initialIndex: index,snaps: snapshot.data!.docs,),
                    ));
              },
              child: Image(
                image: NetworkImage(
                  snap['postUrl'],
                ),
                fit: BoxFit.cover,
              ),
            );
          },
        );
      },
    );
  }
}
