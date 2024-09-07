import 'package:flutter/material.dart';
import 'package:matrix_app_project/core/usecases/colors.dart';
import 'package:matrix_app_project/core/usecases/constants.dart';
import 'package:matrix_app_project/features/presentaition/pages/bottom_nav/bottom_nav.dart';
import 'package:matrix_app_project/features/presentaition/statemanagement/provider/add_post/edit_post.dart';
import 'package:matrix_app_project/features/presentaition/widgets/global/costum_appbar_widget.dart';
import 'package:matrix_app_project/features/presentaition/widgets/global/costum_button.dart';
import 'package:matrix_app_project/features/presentaition/pages/home_main_section/widgets/post_card.dart';
import 'package:matrix_app_project/features/presentaition/widgets/feature_widgets/textfieled_widget.dart';
import 'package:provider/provider.dart';

class EditPostPage extends StatelessWidget {
  final String postId;
  final PostCard widget;

  const EditPostPage({required this.postId,required this.widget, super.key});

  @override
  Widget build(BuildContext context) {
    final editController = TextEditingController();
    var _mediaquery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: scffoldBackgroundClr,
      appBar: const CostumAppBarWidget(
        title: 'Edit post',
        titleAlign: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            sizeFifty,
            Container(
              width: _mediaquery.size.width * 0.87,
              height: _mediaquery.size.height * 0.4,
              decoration: BoxDecoration(
                  image:  DecorationImage(
                      image: NetworkImage(
                          widget.snap['postUrl'],),
                      fit: BoxFit.cover),
                  border: Border.all(color: Colors.grey, width: 2.0),
                  color: const Color.fromARGB(255, 164, 164, 164),
                  borderRadius: BorderRadius.circular(8)),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 0),
            ),
           sizeFifty,
            //sizeTwentyFive,
            MyTextfieled(
                controller: editController,
                hintText: widget.snap['description'],
                icon: Icons.abc_outlined),
           // sizeFifty,
           sizeTwentyFive,
            MyNormalButton(
              onTap: () {
                Provider.of<EditPostProvider>(context, listen: false)
                    .editPost(postId, editController.text);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BottomNavBar(),
                    ));
              },
              text: 'Upload!',
              size: 65,
            ),
          ],
        ),
      ),
    );
  }
}
