import 'package:flutter/material.dart';
import 'package:matrix_app_project/core/usecases/colors.dart';
import 'package:matrix_app_project/core/usecases/constants.dart';
import 'package:matrix_app_project/features/data/models/user.dart';

class CostumAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final bool? titleAlign;
  final Widget? leading;
  final bool showActionIcon;
  final VoidCallback? onMenuAction;

  const CostumAppBarWidget({
    super.key,
    this.title = '',
    required this.titleAlign,
    this.leading,
    this.showActionIcon = false,
    this.onMenuAction,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.primary,
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
                child: titleAlign == true
                    ? Padding(
                        padding: const EdgeInsets.only(left: 50, top: 5),
                        child: Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      )
                    : Center(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                            color: Theme.of(context).colorScheme.secondary,
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
                        offset: const Offset(1, 0),
                        child: const BackButton(),
                      ),
                  if (showActionIcon)
                    Transform.translate(
                      offset: const Offset(5, 0),
                      child: InkWell(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) =>HiddenDrawer(),
                          //     ));
                          Scaffold.of(context).openDrawer();
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
  Size get preferredSize => const Size(double.maxFinite, 80);
}

class ChatAppBar extends StatelessWidget {
  const ChatAppBar({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      foregroundColor: blackClr,
      backgroundColor: Colors.transparent,
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(user.photoUrl),
            radius: 20,
          ),
          sizeTen,
          Column(
            children: [
              Text(
                user.username,
                style: const TextStyle(
                    color: blackClr, fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}
