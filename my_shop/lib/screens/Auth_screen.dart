import 'package:flutter/material.dart';
import 'package:my_shop/widgets/auth_screen_widgets/auth_background.dart';
import 'package:my_shop/widgets/auth_screen_widgets/auth_title.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool hidePassword, hideConfirmPassword, loginMode, resetPassword;
  GlobalKey fieldKey;
  double height;
  @override
  void initState() {
    super.initState();
    hidePassword = hideConfirmPassword = loginMode = true;
    resetPassword = false;
    height = 0;
    fieldKey = GlobalKey();
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
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AuthTitle(UniqueKey(), 'Reset password of'),
                      Form(
                        child: Column(
                          children: [
                            TextFormField(
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                hintText: 'example@abc.com',
                                labelText: 'Email',
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 3),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.05),
                        child: RaisedButton(
                          shape: StadiumBorder(),
                          child: Text(
                            'Reset Password',
                            key: UniqueKey(),
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          color: Theme.of(context).accentColor,
                          onPressed: () {},
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: FlatButton(
                          padding: EdgeInsets.zero,
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              resetPassword = false;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            curve: Curves.decelerate,
            left: (!resetPassword) ? 0 : -MediaQuery.of(context).size.width,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedSwitcher(
                        duration: Duration(milliseconds: 400),
                        child: (loginMode)
                            ? AuthTitle(UniqueKey(), 'Log into')
                            : AuthTitle(UniqueKey(), 'Create'),
                      ),
                      Form(
                        child: Column(
                          children: [
                            TextFormField(
                              key: fieldKey,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                hintText: 'example@abc.com',
                                labelText: 'Email',
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 3),
                                ),
                              ),
                            ),
                            TextFormField(
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              obscureText: hidePassword,
                              decoration: InputDecoration(
                                hintText: '••••••••',
                                labelText: 'Password',
                                suffix: InkWell(
                                  onTap: () {
                                    setState(() {
                                      hidePassword = !hidePassword;
                                    });
                                  },
                                  child: Icon(
                                    (hidePassword)
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.white,
                                  ),
                                ),
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 3),
                                ),
                              ),
                            ),
                            AnimatedContainer(
                              duration: Duration(seconds: 1),
                              curve: Curves.bounceOut,
                              height: height,
                              child: AnimatedOpacity(
                                duration: Duration(milliseconds: 500),
                                opacity: (loginMode) ? 0 : 1,
                                child: TextFormField(
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  obscureText: hideConfirmPassword,
                                  decoration: InputDecoration(
                                    hintText: '••••••••',
                                    labelText: 'Confirm Password',
                                    suffix: InkWell(
                                      onTap: () {
                                        setState(() {
                                          hideConfirmPassword =
                                              !hideConfirmPassword;
                                        });
                                      },
                                      child: Icon(
                                        (hideConfirmPassword)
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.white,
                                      ),
                                    ),
                                    hintStyle: TextStyle(
                                      color: Colors.white,
                                    ),
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 3),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                          padding: EdgeInsets.zero,
                          child: Text(
                            'Reset Password',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              resetPassword = true;
                            });
                          },
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: RaisedButton(
                          shape: StadiumBorder(),
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 400),
                            child: (loginMode)
                                ? Text(
                                    'Login',
                                    key: UniqueKey(),
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  )
                                : Text(
                                    'Register',
                                    key: UniqueKey(),
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                          ),
                          color: Theme.of(context).accentColor,
                          onPressed: () {},
                        ),
                      ),
                      AnimatedSwitcher(
                        duration: Duration(milliseconds: 400),
                        child: (loginMode)
                            ? Row(
                                key: UniqueKey(),
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Don\'t have an account?',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  FlatButton(
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    onPressed: () {
                                      final ctx = fieldKey.currentContext;
                                      final box =
                                          ctx.findRenderObject() as RenderBox;
                                      setState(() {
                                        height = box.size.height;
                                        loginMode = false;
                                      });
                                    },
                                  ),
                                ],
                              )
                            : Row(
                                key: UniqueKey(),
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Already have an account?',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  FlatButton(
                                    child: Text(
                                      'Sign In',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        height = 0;
                                        loginMode = true;
                                      });
                                    },
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
