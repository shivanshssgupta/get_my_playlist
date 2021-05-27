import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/EmailPasswordModel.dart';
import '../constraints.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final IconData suffixIcon;
  final onChanged;
  final bool obscureText;
  final TextEditingController controller;

  TextFieldWidget({
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.obscureText,
    this.controller,
  });


  @override
  Widget build(BuildContext context) {
    final model = Provider.of<EmailPasswordModel>(context,listen: false);
    Size size = MediaQuery.of(context).size;
    return TextField(
      style: TextStyle(
          fontSize: size.height * 0.0225, color: primaryColor.withBlue(255)),
      onChanged: onChanged,
      controller: controller,
      obscureText: obscureText,
      cursorColor: primaryColor,
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(size.width * 0.02),
          borderSide: BorderSide(color: primaryColor),
        ),
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(size.width * 0.02),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(
          prefixIcon,
          size: size.height * 0.028,
          color: primaryColor,
        ),
        suffixIcon: suffixIcon == Icons.check
            ? Icon(
                suffixIcon,
                size: size.height * 0.028,
                color: primaryColor,
              )
            : GestureDetector(
                onTap: () {
                  model.isHiddenP(!model.isHidden);
                },
                child: Icon(
                  suffixIcon,
                  size: size.height * 0.028,
                  color: primaryColor,
                ),
              ),
        labelStyle: TextStyle(
            fontFamily: 'RobotoCondensed',
            color: primaryColor,
            fontSize: size.height * 0.02),
        focusColor: primaryColor,
        labelText: hintText,
      ),
    );
  }
}
