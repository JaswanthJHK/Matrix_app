import 'package:flutter/material.dart';
import 'package:matrix_app_project/core/usecases/colors.dart';
import 'package:matrix_app_project/core/usecases/constants.dart';
import 'package:matrix_app_project/core/util/utils.dart';
import 'package:matrix_app_project/features/presentaition/pages/bottom_nav/bottom_nav.dart';
import 'package:matrix_app_project/features/auth/sign_in_page.dart';
import 'package:matrix_app_project/features/presentaition/statemanagement/login_auth_methods.dart';
import 'package:matrix_app_project/features/presentaition/widgets/global/costum_button.dart';
import 'package:matrix_app_project/features/presentaition/widgets/feature_widgets/textfieled_widget.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginAuth>(
      builder: (context, loginAuthProviderModel, child) => Scaffold(
        backgroundColor: scffoldBackgroundClr,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  sizeTwentyFive,

                  //logo Image

                  Image.asset(
                    'asset/images/Main_logo.png',
                    height: 150,
                  ),

                  sizeTwentyFive,

                  const Text(
                    "Welcome back you've been missed",
                    style: TextStyle(color: authScreenTextClr, fontSize: 16),
                  ),

                  sizeTwentyFive,

                  // textfield area

                  MyTextfieled(
                    controller: loginAuthProviderModel.emailTextController,
                    hintText: 'Email',
                    isPasswordType: false,
                    icon: Icons.person,
                  ),

                  sizeTen,

                  MyTextfieled(
                    controller: loginAuthProviderModel.passwordController,
                    hintText: 'password',
                    isPasswordType: true,
                    icon: Icons.lock,
                  ),

                  sizeTen,

                  Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),

                  sizeTwentyFive,

                  // login button

                  MyButton(
                    //  onTap: () => loginAuthProviderModel.handleLogin(context),
                    onTap: () async {
                      String res = await LoginAuth().loginUser(
                          email:
                              loginAuthProviderModel.emailTextController.text,
                          password:
                              loginAuthProviderModel.passwordController.text);
                      if (res == 'Success') {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const BottomNavBar(), // prevous homescreen
                            ));
                      } else {
                        showSnackBarMethod(res, context);
                      }
                    
                    },
                    isLogin: true,
                  ),

                  sizeTen,

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: blackClr,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: Text(
                            "Don't have an account?",
                            style: TextStyle(color: authScreenTextClr),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignInPage(),
                                ));
                          },
                          child: const Text(
                            "Sign UP",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: blackClr,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
