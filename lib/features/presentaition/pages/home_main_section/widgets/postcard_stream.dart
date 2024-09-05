import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:matrix_app_project/features/presentaition/pages/home_main_section/widgets/post_card.dart';

// class PostCardStream extends StatefulWidget {
//   const PostCardStream({super.key});

//   @override
//   State<PostCardStream> createState() => _PostCardStreamState();
// }

// class _PostCardStreamState extends State<PostCardStream> {
//   @override
//   Widget build(BuildContext context) {
//     return
//      StreamBuilder(
//       // listern stream of data from firestore collection and rebuilds the ui when data get
//       stream: FirebaseFirestore.instance
//           .collection('posts')
//           .orderBy(
//             'datePublished',
//             descending: true,
//           )
//           .snapshots(),
//       builder: (context,
//           AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//         if (!snapshot.hasData) {
//           return const Text('No data');
//         }

//         return ListView.builder(
//           itemCount: snapshot.data?.docs.length ?? 0,
//           itemBuilder: (context, index) {
//             if (snapshot.data == null) {
//               return const SizedBox(); // Return an empty container if snapshot is null
//             }
//             final data = snapshot.data!.docs[index].data();

//             return PostCard(snap: data);
//           },
//         );
//       },
//     );
//   }
// }


class PostCardStream extends StatefulWidget {
  const PostCardStream({super.key});

  @override
  State<PostCardStream> createState() => _PostCardStreamState();
}

class _PostCardStreamState extends State<PostCardStream> with AutomaticKeepAliveClientMixin {
  List<Map<String, dynamic>>? postData;
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    // If postData is null, we fetch data from the StreamBuilder... 
    if (postData == null) {
      fetchData();
    }
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
      errorMessage = null; // Reset any previous errors
    });

    try {
      // Fetch data from Firestore
      final snapshot = await FirebaseFirestore.instance
          .collection('posts')
          .orderBy('datePublished', descending: true)
          .get();

      setState(() {
        postData = snapshot.docs.map((doc) => doc.data()).toList();
      });
    } catch (e) {
      // Handle any errors that occur during the fetch
      setState(() {
        errorMessage = 'Failed to load posts. Please try again later.';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(child: Text(errorMessage!));
    }

    return postData == null
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: postData?.length ?? 0,
            itemBuilder: (context, index) {
              final data = postData![index];
              return PostCard(snap: data);
            },
          );
  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
