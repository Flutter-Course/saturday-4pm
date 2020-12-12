import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/screens/home_screen.dart';
import 'package:my_shop/widgets/auth_screen_widgets/auth_title.dart';

class AuthForm extends StatefulWidget {
  final Function toggleResetPassword;
  AuthForm(this.toggleResetPassword);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool hidePassword, hideConfirmPassword, loginMode, loading;
  String email, password, confirmPassword;
  GlobalKey<FormState> form;
  FocusNode passwordNode, confirmPasswordNode;

  GlobalKey fieldKey;
  double height;
  @override
  void initState() {
    super.initState();
    hidePassword = hideConfirmPassword = loginMode = true;
    height = 0;
    fieldKey = GlobalKey();
    form = GlobalKey<FormState>();
    loading = false;
    passwordNode = FocusNode();
    confirmPasswordNode = FocusNode();
  }

  void showError(String error) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
        backgroundColor: Colors.red[900],
      ),
    );
  }

  void validateThenLogin() async {
    if (form.currentState.validate()) {
      try {
        setState(() {
          loading = true;
        });
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      } on FirebaseAuthException catch (e) {
        setState(() {
          loading = false;
        });
        switch (e.code) {
          case 'invalid-email':
            showError('Invalid email or password.');
            break;
          case 'wrong-password':
            showError('Invalid email or password.');
            break;
          case 'user-disabled':
            showError('This user has been disabled');
            break;
          default:
            showError('No user with this email address.');
        }
      } on SocketException {
        setState(() {
          loading = false;
        });
        showError('Network error.');
      }
    }
  }

  void validateThenRegister() async {
    if (form.currentState.validate()) {
      try {
        setState(() {
          loading = true;
        });
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      } on FirebaseAuthException catch (e) {
        setState(() {
          loading = false;
        });
        switch (e.code) {
          case 'email-already-in-use':
            showError('This email is already in use.');
            break;
          case 'invalid-email':
            showError('This email is invalid.');
            break;
          default:
            showError('Weak password.');
        }
      } on SocketException {
        setState(() {
          loading = false;
        });
        showError('Network error.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                key: form,
                child: Column(
                  children: [
                    TextFormField(
                      key: fieldKey,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      validator: (value) {
                        setState(() {
                          email = value;
                        });

                        if (EmailValidator.validate(email)) {
                          return null;
                        }

                        return 'Invalid email address';
                      },
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        passwordNode.requestFocus();
                      },
                      decoration: InputDecoration(
                        hintText: 'example@abc.com',
                        labelText: 'Email',
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        errorStyle: TextStyle(
                          color: Colors.redAccent,
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.redAccent,
                          ),
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
                          borderSide: BorderSide(color: Colors.white, width: 3),
                        ),
                      ),
                    ),
                    TextFormField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      obscureText: hidePassword,
                      validator: (value) {
                        setState(() {
                          password = value;
                        });
                        if (value.length >= 6) {
                          return null;
                        }

                        return 'Password must contain 6 characters at least';
                      },
                      focusNode: passwordNode,
                      textInputAction: (loginMode)
                          ? TextInputAction.done
                          : TextInputAction.next,
                      onFieldSubmitted: (value) {
                        if (!loginMode) {
                          confirmPasswordNode.requestFocus();
                        }
                      },
                      decoration: InputDecoration(
                        hintText: '••••••••',
                        labelText: 'Password',
                        errorStyle: TextStyle(
                          color: Colors.redAccent,
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.redAccent,
                          ),
                        ),
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
                          borderSide: BorderSide(color: Colors.white, width: 3),
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
                          validator: (value) {
                            setState(() {
                              confirmPassword = value;
                            });
                            if (loginMode || password == value) {
                              return null;
                            }

                            return 'Passwords don\'t match';
                          },
                          focusNode: confirmPasswordNode,
                          decoration: InputDecoration(
                            hintText: '••••••••',
                            labelText: 'Confirm Password',
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.redAccent,
                              ),
                            ),
                            suffix: InkWell(
                              onTap: () {
                                setState(() {
                                  hideConfirmPassword = !hideConfirmPassword;
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
                            errorStyle: TextStyle(
                              color: Colors.redAccent,
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
                    widget.toggleResetPassword();
                  },
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: (loading)
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : RaisedButton(
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
                        onPressed: () {
                          if (loginMode) {
                            validateThenLogin();
                          } else {
                            validateThenRegister();
                          }
                        },
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
                              final box = ctx.findRenderObject() as RenderBox;
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
    );
  }
}
