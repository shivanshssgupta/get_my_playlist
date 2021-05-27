import 'package:flutter/material.dart';
import '../constraints.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final onTap;

  RoundedButton({this.text,this.onTap});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: size.height * 0.06,
        width: size.width * 0.8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient:
                LinearGradient(colors: [primaryColor, transPrimaryColor])),
        child: Text(
          text,
          style: TextStyle(fontSize: 18,fontFamily: "Raleway",color: Colors.white,fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
