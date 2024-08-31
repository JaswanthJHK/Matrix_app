import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:matrix_app_project/core/usecases/colors.dart';
import 'package:matrix_app_project/features/presentaition/pages/add_post_section/screen/add_post_page.dart';
import 'package:matrix_app_project/features/presentaition/pages/home_main_section/screen/feed_screen.dart';
import 'package:matrix_app_project/features/presentaition/pages/chat_section/screen/message.dart';
import 'package:matrix_app_project/features/presentaition/pages/profile_section/screen/profile_page.dart';
import 'package:matrix_app_project/features/presentaition/pages/search_explore_section/screens/search_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  // void _navigateBottomBar(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  final List<Widget> _screens = <Widget>[
    const FeedScreen(),
    const SearchScreen(),
    const AddPostScreen(),
    const MessagePage(),
    ProfilPage(
      uid: FirebaseAuth.instance.currentUser!.uid,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: _screens.elementAt(_selectedIndex),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 3,
        ),
        child: GNav(
          backgroundColor: Theme.of(context).colorScheme.primary,
          //color: scffoldBackgroundClr,
          duration: const Duration(milliseconds: 900),
          rippleColor: Theme.of(context).colorScheme.primaryContainer ,
          gap: 5,
          padding: const EdgeInsets.all(16),
          tabBackgroundColor: Theme.of(context).colorScheme.primaryContainer,
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.search,
              text: 'Search',
            ),
            GButton(
              icon: Icons.add,
              text: 'Add post',
            ),
            GButton(
              icon: Icons.message_outlined,
              text: 'Messeges',
            ),
            GButton(
              icon: Icons.person_2,
              text: 'Profile',
            ),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (Index) {
            setState(() {
              _selectedIndex = Index;
            });
          },
        ),
      ),
    );
  }
}
