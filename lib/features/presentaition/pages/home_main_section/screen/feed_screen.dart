import 'package:flutter/material.dart';
import 'package:matrix_app_project/features/presentaition/pages/home_main_section/widgets/postcard_stream.dart';
import 'package:matrix_app_project/features/presentaition/statemanagement/provider/user_provider.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    addData();
  }

  // here we also added the refreshUser
  Future<void> addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      // appBar:const CostumAppBarWidget(
      //   title: 'MATRIX',
      //   titleAlign: false,
      //   leading: Image(image: AssetImage('asset/images/Main_logo.png')),
      // ),
      // body:const PostCardStream(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            floating: true,
            snap: true,
            title: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                "MATRIX",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
        body: const PostCardStream(),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
