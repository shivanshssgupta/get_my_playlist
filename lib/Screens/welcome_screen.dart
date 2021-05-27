import 'package:flutter/material.dart';

import '../Widgets/welcome_body.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = "/welcome";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WelcomeBody(),
      ),
    );
  }
}
