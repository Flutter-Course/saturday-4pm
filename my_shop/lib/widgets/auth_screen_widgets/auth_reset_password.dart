import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/widgets/auth_screen_widgets/auth_title.dart';

class AuthResetPassword extends StatefulWidget {
  final Function toggleResetPassword;
  AuthResetPassword(this.toggleResetPassword);
  @override
  _AuthResetPasswordState createState() => _AuthResetPasswordState();
}

class _AuthResetPasswordState extends State<AuthResetPassword> {
  GlobalKey<FormState> form;
  String email;
  bool loading;
  @override
  void initState() {
    super.initState();
    form = GlobalKey<FormState>();
    loading = false;
  }

  void showError(String error) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
        backgroundColor: Colors.red[900],
      ),
    );
  }

  void resetPassword() async {
    if (form.currentState.validate()) {
      try {
        setState(() {
          loading = true;
        });
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Email has been sent'),
          backgroundColor: Colors.green[900],
        ));
      } catch (e) {
        print(e);
        showError('Error has occurred');
      }

      setState(() {
        loading = false;
      });
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
              AuthTitle(UniqueKey(), 'Reset password of'),
              Form(
                key: form,
                child: Column(
                  children: [
                    TextFormField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      validator: (value) {
                        setState(() {
                          email = value;
                        });
                        if (EmailValidator.validate(value)) {
                          return null;
                        }
                        return 'Please enter your email address';
                      },
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
                          borderSide: BorderSide(color: Colors.white, width: 3),
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
                child: (loading)
                    ? Center(child: CircularProgressIndicator())
                    : RaisedButton(
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
                        onPressed: () {
                          resetPassword();
                        },
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
                    widget.toggleResetPassword();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
