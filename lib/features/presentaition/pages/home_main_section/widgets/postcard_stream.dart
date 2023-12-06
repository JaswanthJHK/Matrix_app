import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:matrix_app_project/features/presentaition/pages/home_main_section/widgets/post_card.dart';

class PostCardStream extends StatelessWidget {
  const PostCardStream({super.key});

    @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      // listern stream of data from firestore collection and rebuilds the ui when data get
      stream: FirebaseFirestore.instance
          .collection('posts')
          .orderBy(
            'datePublished',
            descending: true,
          )
          .snapshots(),
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapshot.hasData) {
          return Text('No data');
        }
       
        return ListView.builder(
  itemCount: snapshot.data?.docs.length ?? 0,
  itemBuilder: (context, index) {
    if (snapshot.data == null) {
      return const SizedBox(); // Return an empty container if snapshot is null
    }
    final data = snapshot.data!.docs[index].data();
    
    return PostCard(snap: data);
  },
);
      },
    );
  }
}