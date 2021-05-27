import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './Screens/login_screen.dart';
import './Screens/signup_screen.dart';
import './Screens/home_screen.dart';
import './constraints.dart';
import './Models/EmailPasswordModel.dart';
import './Screens/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await checkUid().then((value) {
    runApp(MyApp(
      initialRoute: value ? HomeScreen.routeName : WelcomeScreen.routeName,
    ));
  });
}

Future<bool> checkUid() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.containsKey("uid");
}

class MyApp extends StatelessWidget {
  final initialRoute;

  MyApp({this.initialRoute});

  var uid;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<EmailPasswordModel>(
            create: (_) => EmailPasswordModel())
      ],
      child: MaterialApp(
        title: 'Get My Playlist!',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFF8F94FB),
          canvasColor: Color.fromRGBO(255, 254, 240, 1),
          fontFamily: 'RobotoCondensed',
          textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(20, 51, 51, 1)),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: TextStyle(
                fontSize: 20,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
              )),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: initialRoute,
        routes: {
          WelcomeScreen.routeName: (_) => WelcomeScreen(),
          LoginScreen.routeName: (_) => LoginScreen(),
          SignUpScreen.routeName: (_) => SignUpScreen(),
          HomeScreen.routeName: (_) => HomeScreen(),
        },
      ),
    );
  }
}
