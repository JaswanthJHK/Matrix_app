import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:matrix_app_project/core/usecases/colors.dart';
import 'package:matrix_app_project/features/presentaition/statemanagement/provider/user_provider.dart';
import 'package:matrix_app_project/features/presentaition/widgets/costum_appbar_widget.dart';
import 'package:matrix_app_project/features/presentaition/widgets/post_card.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  // here we also added the refreshUser
  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: scffoldBackgroundClr,
        appBar: const CostumAppBarWidget(
          title: 'MATRIX',
          leading: Image(image: AssetImage('asset/images/Main_logo.png')),
        ),
        body: StreamBuilder(
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
    if (data == null) {
      return const SizedBox(); // Return an empty container if data is null
    }
    return PostCard(snap: data);
  },
);
          },
        ));
  }
}
