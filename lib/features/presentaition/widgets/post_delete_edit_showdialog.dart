import 'package:flutter/material.dart';
import 'package:matrix_app_project/features/data/data_sources/firestore_methodes.dart';
import 'package:matrix_app_project/features/presentaition/pages/edit_page.dart';
import 'package:matrix_app_project/features/presentaition/widgets/post_card.dart';

class PostDeleteAndEdit extends StatelessWidget {final String postId;
  const PostDeleteAndEdit({
    super.key,
    required this.widget,required this.postId
  });

  final PostCard widget;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      //  title: const Text("Create a post"),
      children: [
        SimpleDialogOption(
          padding: const EdgeInsets.all(20),
          child: const Text("Delete"),
          onPressed: () async {
            Navigator.of(context).pop();
            showDialog(
              context: context,
              builder: (innerContext) {
                return AlertDialog(
                  title: const Text("Confirm Delete"),
                  content:
                      const Text("Are you sure you want to delete this post"),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        FirestoreMethodes().deletePost(widget.snap['postId']);
                        Navigator.of(innerContext).pop();
                        Navigator.of(context).pop();
                      },
                      child: const Text("Yes"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(innerContext).pop();
                      },
                      child: const Text("No"),
                    ),
                  ],
                );
              },
            );
          },
        ),
        SimpleDialogOption(
          padding: const EdgeInsets.all(20),
          child: const Text("Edit"),
          onPressed: () async {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditPostPage(postId: postId,),
                ));
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
  }
}
