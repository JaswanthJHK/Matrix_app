import 'package:flutter/material.dart';
import 'package:matrix_app_project/core/usecases/colors.dart';

class MyButton extends StatelessWidget {
  final Function onTap;
  final bool isLogin;

  const MyButton({super.key, required this.onTap, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 65,
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: ElevatedButton(
          onPressed: () {
            onTap();
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith((states) {
                if (states.contains(MaterialState.pressed)) {
                  return scffoldBackgroundClr;
                }
                return blackClr;
              }),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)))),
          child: Text(
            isLogin ? 'LOG IN' : 'SIGN UP',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

class MyNormalButton extends StatelessWidget {
  final Function onTap;
  final String text;
  final double size;

  const MyNormalButton(
      {super.key, required this.onTap, required this.text, required this.size});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: size,
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: ElevatedButton(
          onPressed: () {
            onTap();
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith((states) {
                if (states.contains(MaterialState.pressed)) {
                  return scffoldBackgroundClr;
                }
                return blackClr;
              }),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)))),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

class EditProfileButton extends StatelessWidget {
  final Function onTap;
  final String text;
  final double size;

  const EditProfileButton(
      {super.key, required this.onTap, required this.text, required this.size});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: size,
        margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: ElevatedButton(
          onPressed: () {
            onTap();
          },
          style: ButtonStyle(
              backgroundColor: WidgetStateColor.resolveWith((states) {
                if (states.contains(WidgetState.pressed)) {
                  return scffoldBackgroundClr;
                }
                return Theme.of(context).colorScheme.inversePrimary;
              }),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)))),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
