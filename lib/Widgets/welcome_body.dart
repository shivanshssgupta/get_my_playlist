import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Screens/signup_screen.dart';
import '../Screens/login_screen.dart';
import '../Widgets/rounded_button.dart';
import '../Models/EmailPasswordModel.dart';

class WelcomeBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<EmailPasswordModel>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return Container(
      //color: Colors.black26,
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              top: 0,
              left: 0,
              width: size.width * 0.3,
              child: Image.asset("assets/images/welcome_top.png")),
          Positioned(
              bottom: 0,
              left: 0,
              width: size.width * 0.2,
              child: Image.asset("assets/images/welcome_bottom.png")),
          Positioned(
              top: size.height * 0.2,
              child: Column(
                children: [
                  Image.asset(
                    "assets/icons/Getmyplaylist-02.png",
                    height: size.height * 0.325,
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(
                        size.width * 0.04,
                        0,
                        size.width * 0.03,
                        size.height * 0.02),
                    width: size.width,
                    child: Column(
                      children: [
                        Text(
                          "Hi there! Welcome to Get My Playlist!",
                          softWrap: true,
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF424242)),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Text(
                          "Give us some of your favourite "
                          "songs and we will generate a playlist just for you.",
                          style:
                              TextStyle(fontSize: 19, color: Color(0xFF424242)),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  RoundedButton(
                    text: "Login",
                    onTap: () {
                      model.isHiddenP(true);
                      model.setValid(false);
                      Navigator.of(context).pushNamed(LoginScreen.routeName);
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  RoundedButton(
                    text: "Sign Up",
                    onTap: () {
                      model.isHiddenP(true);
                      model.setValid(false);
                      Navigator.of(context).pushNamed(SignUpScreen.routeName);
                    },
                  )
                ],
              )),
        ],
      ),
    );
  }
}
