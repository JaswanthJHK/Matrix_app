import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:matrix_app_project/core/usecases/colors.dart';
import 'package:matrix_app_project/features/presentaition/pages/comment_section/screen/comment_screen.dart';
import 'package:matrix_app_project/features/presentaition/pages/comment_section/widgets/comment_card.dart';

class CommentStreambuilder extends StatelessWidget {
  const CommentStreambuilder({
    super.key,
    required this.widget,
  });

  final CommentScreen widget;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap['postId'])
          .collection('comments')
          .orderBy(
            'timestamp',
            descending: true,
          )
          .snapshots(),
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text(
              'No comments',
              style: TextStyle(
                  color: greyDark, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) => CommentCard(
            snap: snapshot.data!.docs[index].data(),
          ),
        );
      },
    );
  }
}