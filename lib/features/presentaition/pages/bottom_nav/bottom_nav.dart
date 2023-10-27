import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:matrix_app_project/core/usecases/colors.dart';
import 'package:matrix_app_project/features/presentaition/pages/add_post_page.dart';
import 'package:matrix_app_project/features/presentaition/pages/feed_screen.dart';
import 'package:matrix_app_project/features/presentaition/pages/logout_page.dart';
import 'package:matrix_app_project/features/presentaition/pages/profile_page.dart';

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
    const LogOutPage(),
    const AddPostScreen(),
     ProfilPage(uid: FirebaseAuth.instance.currentUser!.uid,),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: scffoldBackgroundClr,
      body: _screens.elementAt(_selectedIndex),
      
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10,),
        child: GNav(
          backgroundColor: scffoldBackgroundClr,
          //color: scffoldBackgroundClr,
          duration: const Duration(milliseconds: 900),
          rippleColor: const Color.fromARGB(255, 143, 143, 143),
          gap: 5,
          padding: const EdgeInsets.all(16),
          tabBackgroundColor: const Color.fromARGB(255, 194, 194, 194),
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.logout,
              text: 'LogOut',
            ),
            GButton(
              icon: Icons.add,
              text: 'Add post',
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
