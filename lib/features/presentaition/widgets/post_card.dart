// ignore_for_file: unnecessary_nullable_for_final_variable_declarations

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:matrix_app_project/core/util/utils.dart';
import 'package:matrix_app_project/features/data/data_sources/firestore_methodes.dart';
import 'package:matrix_app_project/features/data/models/user.dart' as model;
import 'package:matrix_app_project/features/presentaition/statemanagement/provider/user_provider.dart';
import 'package:matrix_app_project/features/presentaition/widgets/description_area.dart';
import 'package:matrix_app_project/features/presentaition/widgets/like_and_comment.dart';
import 'package:matrix_app_project/features/presentaition/widgets/like_animation.dart';
import 'package:matrix_app_project/features/presentaition/widgets/post_delete_edit_showdialog.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({super.key, required this.snap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;
  int commentLength = 0;

  @override
  void initState() {
    super.initState();
    getCommentLen();
  }

  void getCommentLen() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap['postId'])
          .collection('comments')
          .get();

      commentLength = snap.docs.length;
    } catch (e) {
      showSnackBarMethod(e.toString(), context);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                .copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(
                    widget.snap['profImage'],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.snap['username'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                widget.snap['uid'] == FirebaseAuth.instance.currentUser?.uid // null changed
                    ? IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              // POST EDIT DELETE SHOWDIALOG AREA ------------------------
                              return BackdropFilter(
                                 filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                                child: PostDeleteAndEdit(
                                  widget: widget,
                                  postId: widget.snap['postId'],
                                ),
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.more_vert),
                      )
                    : const SizedBox()
              ],
            ),
          ),
          // IMAGE SECTION
          GestureDetector(
            onDoubleTap: () async {
              await FirestoreMethodes().likePost(
                widget.snap['postId'],
                user.uid,
                widget.snap['likes'],
              );
              setState(() {
                isLikeAnimating = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.40,
                  width: double.infinity,
                  child: Image.network(
                    // imgUrl,
                    widget.snap['postUrl'],
                    fit: BoxFit.cover,
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isLikeAnimating ? 1 : 0,
                  child: LikeAnimation(
                    child: Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 110,
                    ),
                    isAnimating: isLikeAnimating,
                    duration: const Duration(
                      milliseconds: 400,
                    ),
                    onEnd: () {
                      setState(() {
                        isLikeAnimating = false;
                      });
                    },
                  ),
                )
              ],
            ),
          ),

          // like and comment section

          LikeAndComment(
            widget: widget,
            user: user,
          ),

          // DESCRIPTION AND NUMBER OF COMMENT AND LIKES
          DescriptionArea(
            widget: widget,
            commentLength: commentLength,
          )
        ],
      ),
    );
  }
}
