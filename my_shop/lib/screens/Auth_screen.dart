import 'package:flutter/material.dart';
import 'package:my_shop/widgets/auth_screen_widgets/auth_background.dart';
import 'package:my_shop/widgets/auth_screen_widgets/auth_form.dart';
import 'package:my_shop/widgets/auth_screen_widgets/auth_reset_password.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth-screen';
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool resetPassword;
  GlobalKey fieldKey;
  double height;
  @override
  void initState() {
    super.initState();
    resetPassword = false;
  }

  void toggleResetPassword() {
    setState(() {
      resetPassword = !resetPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AuthBackground(),
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            curve: Curves.decelerate,
            right: (resetPassword) ? 0 : -MediaQuery.of(context).size.width,
            child: AuthResetPassword(toggleResetPassword),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            curve: Curves.decelerate,
            left: (!resetPassword) ? 0 : -MediaQuery.of(context).size.width,
            child: AuthForm(toggleResetPassword),
          )
        ],
      ),
    );
  }
}
