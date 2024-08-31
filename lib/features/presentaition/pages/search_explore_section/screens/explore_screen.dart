import 'package:flutter/material.dart';
import 'package:matrix_app_project/core/usecases/colors.dart';
import 'package:matrix_app_project/features/presentaition/pages/home_main_section/widgets/postcard_stream.dart';
import 'package:matrix_app_project/features/presentaition/widgets/global/costum_appbar_widget.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: scffoldBackgroundClr,
      appBar: CostumAppBarWidget(
        title: "Explore",
        titleAlign: false,
      ),
      body: PostCardStream() ,
    );
  }
}