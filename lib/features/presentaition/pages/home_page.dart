import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   addData();
  // }
                                                                              
  // addData() async {
  //   UserProvider _userProvider = Provider.of(context, listen: false);
  //   await _userProvider.refreshUser();
  // }

 

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      body: Center(
        child: Text('nothing'), 
      ),
    );
  }
}
