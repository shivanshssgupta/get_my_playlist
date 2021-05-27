import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../Screens/home_screen.dart';
import '../Screens/signup_screen.dart';
import '../Widgets/textfield_widget.dart';
import '../constraints.dart';
import '../Widgets/ls_background.dart';
import '../Models/EmailPasswordModel.dart';
import '../Widgets/fade_animation.dart';
import '../Widgets/rounded_button.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = "/logIn";
  int statusCode;
  final String apiUrl = "https://playlist-gene.herokuapp.com/api/Login";

  putUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("uid", 1);
  }


  @override
  Widget build(BuildContext context) {
    final model = Provider.of<EmailPasswordModel>(context, listen: false);
    TextEditingController emailController = new TextEditingController();
    TextEditingController passwordController = new TextEditingController();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                LSBackground(
                  text: "Login",
                ),
                Padding(
                  padding: EdgeInsets.all(size.height * 0.04),
                  child: Column(
                    children: [
                      FadeAnimation(
                        delay: 1.6,
                        child: Container(
                          //padding: EdgeInsets.only(left: size.width * 0.03,top: size.height*0.005,bottom: size.height*0.005),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(size.width * 0.02),
                              boxShadow: [
                                BoxShadow(
                                    color: primaryColor.withOpacity(0.8),
                                    blurRadius: size.height * 0.04,
                                    offset: Offset(0, size.height * 0.015))
                              ]),
                          child: Consumer<EmailPasswordModel>(
                            builder: (_, model, ___) {
                              return TextFieldWidget(
                                controller: emailController,
                                hintText: "Email",
                                prefixIcon: Icons.email_outlined,
                                suffixIcon: model.isValid ? Icons.check : null,
                                obscureText: false,
                                onChanged: (input) {
                                  model.isValidEmail(input);
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      FadeAnimation(
                        delay: 1.8,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(size.width * 0.02),
                              boxShadow: [
                                BoxShadow(
                                    color: primaryColor.withOpacity(0.8),
                                    blurRadius: size.height * 0.04,
                                    offset: Offset(0, size.height * 0.015))
                              ]),
                          child: Consumer<EmailPasswordModel>(
                            builder: (_, model, __) {
                              return TextFieldWidget(
                                controller: passwordController,
                                hintText: "Password",
                                prefixIcon: Icons.lock_outline,
                                suffixIcon: model.isHidden
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                obscureText: model.isHidden,
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      FadeAnimation(
                          delay: 1.9,
                          child: RoundedButton(
                            text: "Login",
                            onTap: () {
                              String email = emailController.text;
                              String password = passwordController.text;
                              if (email == "" || password == "")
                                Fluttertoast.showToast(
                                    msg: "Email/Password can't be blank!");
                              else {
                                var params = {
                                  "email": email,
                                  "password": password,
                                };
                                var apiUri = Uri.parse(apiUrl);
                                http
                                    .post(apiUri, body: json.encode(params))
                                    .then((response) {
                                  statusCode = response.statusCode;
                                  if (statusCode == 200) {
                                    Fluttertoast.showToast(
                                        msg: "Logged In successfully");
                                    putUid();
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            HomeScreen.routeName,
                                            (Route<dynamic> route) => false);
                                  } else if (statusCode == 401) {
                                    Fluttertoast.showToast(
                                        msg: "Incorrect Email/Password");
                                  } else {
                                    Fluttertoast.showToast(
                                        msg:
                                            "There is some unknown error. Please check your internet connection",
                                        toastLength: Toast.LENGTH_LONG);
                                  }
                                });
                              }
                            },
                          )),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      FadeAnimation(
                        delay: 2.0,
                        child: TextButton(
                          child: Text(
                            "Don't have an account? Sign Up!",
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: size.width * 0.045),
                          ),
                          onPressed: () {
                            model.isHiddenP(true);
                            model.setValid(false);
                            Navigator.of(context)
                                .pushReplacementNamed(SignUpScreen.routeName);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
