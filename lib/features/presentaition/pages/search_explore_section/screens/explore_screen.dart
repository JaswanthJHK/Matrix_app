import 'package:flutter/material.dart';
import 'package:matrix_app_project/features/presentaition/pages/home_main_section/widgets/postcard_stream.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      // appBar: CostumAppBarWidget(
      //   title: "Explore",
      //   titleAlign: false,
      // ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            floating: true,
            snap: true,
            title: Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Text(
                "E X P L O R E",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
        body: PostCardStream(),
      ),
    );
  }
}
