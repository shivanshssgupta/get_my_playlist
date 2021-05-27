import 'package:flutter/material.dart';

import './fade_animation.dart';

class LSBackground extends StatelessWidget {
  final String text;

  LSBackground({this.text});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.45,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/background_ls.png'),
            fit: BoxFit.fill),
      ),
      child: Stack(
        children: [
          Positioned(
            left: size.width * 0.05,
            height: size.height * 0.22,
            width: size.width * 0.2,
            child: FadeAnimation(
              delay:1.0,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/light-1.png'),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: size.width * 0.38,
            height: size.height * 0.18,
            width: size.width * 0.2,
            child: FadeAnimation(
              delay: 1.2,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/light-2.png'),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: size.width * 0.72,
            top: size.width * 0.07,
            height: size.height * 0.15,
            width: size.width * 0.13,
            child: FadeAnimation(
              delay: 1.4,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/clock.png'),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            child: FadeAnimation(
              delay: 1.4,
              child: Container(
                margin: EdgeInsets.only(top: size.height*0.005),
                child: Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.height*0.045,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
