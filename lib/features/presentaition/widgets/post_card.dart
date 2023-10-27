import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:matrix_app_project/core/usecases/colors.dart';
import 'package:matrix_app_project/features/data/data_sources/firestore_methodes.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({super.key, required this.snap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          // HEADER SECTION ----------------------------
          // FutureBuilder(
          //   future: Provider.of<AuthMethods>(context)
          //       .getUserDetails(), // here was parameter before when we changed from authmethod getuser function
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     }
          // return UserListContainer(

          //     userName: snapshot.data!.username,
          //     profImage: snapshot.data!.photoUrl);
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
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
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
                                  builder: ( innerContext) {
                                    return AlertDialog(
                                      title: const Text("Confirm Delete"),
                                      content: const Text(
                                          "Are you sure you want to delete this post"),
                                      actions: [
                                        TextButton(
                                          onPressed: () async {
                                            FirestoreMethodes().deletePost(
                                                widget.snap['postId']);
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
                              onPressed: () async {},
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
                      },
                    );
                  },
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
          ),

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: Image.network(
              // imgUrl,
              widget.snap['postUrl'],
              fit: BoxFit.cover,
            ),
          ),

          // like and comment section

          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 30,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.comment_outlined,
                  size: 30,
                ),
              ),
            ],
          ),

          // DESCRIPTION AND NUMBER OF COMMENT AND LIKES
          Container(
            //  color: Colors.amberAccent,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 8),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: blackClr),
                      children: [
                        TextSpan(
                          text: widget.snap['username'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        TextSpan(
                            text: '  ${widget.snap['description']}',
                            style: const TextStyle(
                                color: Color.fromARGB(255, 58, 58, 58)))
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    DateFormat.yMMMd().format(
                      widget.snap['datePublished'].toDate(),
                    ),
                    style: const TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

// class UserListContainer extends StatelessWidget {
//   final String profImage;
//   final String userName;
 
//   const UserListContainer({
//     required this.profImage,
//     required this.userName,
   
//     super.key,
//   });

//   // @override
//   // Widget build(BuildContext context) {
//   //   return 
//   // }
// }
