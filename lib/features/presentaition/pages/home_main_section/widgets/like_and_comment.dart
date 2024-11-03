// import 'package:flutter/material.dart';
// import 'package:matrix_app_project/features/data/functions/firestore_methodes.dart';
// import 'package:matrix_app_project/features/data/models/user.dart';
// import 'package:matrix_app_project/features/presentaition/pages/comment_section/screen/comment_screen.dart';
// import 'package:matrix_app_project/features/presentaition/pages/home_main_section/widgets/like_animation.dart';
// import 'package:matrix_app_project/features/presentaition/pages/home_main_section/widgets/post_card.dart';

// class LikeAndComment extends StatelessWidget {
//   const LikeAndComment({
//     super.key,
//     required this.widget,
//     required this.user,
//   });

//   final PostCard widget;
//   final User? user; // before here there is no null aware    01/7/2024

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         LikeAnimation(
//           isAnimating: widget.snap['likes']
//               .contains(user?.uid), // added null aware   01/7/2024
//           smallLike: true,
//           child: IconButton(
//               onPressed: () async {
//                 await FirestoreMethodes().likePost(
//                   widget.snap['postId'],
//                   user?.uid
//                       as String, // here added null aware and type casitng  01/7/2024
//                   widget.snap['likes'],
//                 );
//               },
//               icon: widget.snap['likes'].contains(user?.uid
//               )
//                     //  .contains(user?.uid) // added null aware   01/7/2024
//                   ? const Icon(
//                       Icons.favorite,
//                       color: Colors.red,
//                       size: 30,
//                     )
//                   : Icon(
//                       Icons.favorite_border_outlined,
//                       size: 30,
//                       color: Theme.of(context).colorScheme.secondary,
//                     )),
//         ),
//         IconButton(
//           onPressed: () => Navigator.of(context).push(MaterialPageRoute(
//             builder: (context) => CommentScreen(
//               snap: widget.snap,
//             ),
//           )),
//           icon: Icon(
//             Icons.comment_outlined,
//             size: 30,
//             color: Theme.of(context).colorScheme.secondary,
//           ),
//         ),
//       ],
//     );
//   }
// }

//--------------------------------------------------------------------------------------------------


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:matrix_app_project/features/data/functions/firestore_methodes.dart';
import 'package:matrix_app_project/features/data/models/user.dart';
import 'package:matrix_app_project/features/presentaition/pages/comment_section/screen/comment_screen.dart';
import 'package:matrix_app_project/features/presentaition/pages/home_main_section/widgets/like_animation.dart';
import 'package:matrix_app_project/features/presentaition/pages/home_main_section/widgets/post_card.dart';

class LikeAndComment extends StatelessWidget {
  final PostCard widget;
  final User? user;

  const LikeAndComment({
    Key? key,
    required this.widget,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap['postId'])
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        var post = snapshot.data!;
        List likes = post['likes'];

        return Row(
          children: [
            LikeAnimation(
              isAnimating: likes.contains(user?.uid),
              smallLike: true,
              child: IconButton(
                  onPressed: () async {
                    await FirestoreMethodes().likePost(
                      widget.snap['postId'],
                      user?.uid as String,
                      likes,
                    );
                  },
                  icon: likes.contains(user?.uid)
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 30,
                        )
                      : Icon(
                          Icons.favorite_border_outlined,
                          size: 30,
                          color: Theme.of(context).colorScheme.secondary,
                        )),
            ),
            IconButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CommentScreen(
                  snap: widget.snap,
                ),
              )),
              icon: Icon(
                Icons.comment_outlined,
                size: 30,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        );
      },
    );
  }
}
