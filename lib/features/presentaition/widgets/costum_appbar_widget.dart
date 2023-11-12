import 'package:flutter/material.dart';
import 'package:matrix_app_project/core/usecases/colors.dart';
import 'package:matrix_app_project/features/presentaition/pages/logout_page.dart';
import 'package:matrix_app_project/features/presentaition/widgets/shimmer.dart';

class CostumAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final bool showActionIcon;
  final VoidCallback? onMenuAction;

  const CostumAppBarWidget({
    super.key,
    this.title = '',
    this.leading,
    this.showActionIcon = false,
    this.onMenuAction,
  });

  @override
   Widget build(BuildContext context) {
    return Material(
      color: scffoldBackgroundClr,
      elevation: 1.0,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 25 / 2.5,
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: blackClr,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  leading ??
                      Transform.translate(
                        offset: Offset(1, 0),
                        child: const BackButton(),
                      ),
                  if (showActionIcon)
                    Transform.translate(
                      offset: const Offset(5, 0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LogOutPage(),));
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(Icons.menu),
                        ),
                      ),
                    )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(double.maxFinite, 80);
}
