import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './views/pages.dart';
import 'package:powerpal/firebase_options.dart';
import 'package:powerpal/splash_screen.dart';
import 'loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool? seenOnboard;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //show status bar
  SystemChrome.setEnabledSystemUIOverlays(
      [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  // load splash screen for the first time.
  SharedPreferences pref = await SharedPreferences.getInstance();
  seenOnboard = pref.getBool('seenOnboard') ?? false;
  //if null set to false

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "PowerPal",
      home: AnimatedSplashScreen(
        backgroundColor: Color(0xff006156),
        splash: Image.asset(
          'assets/images/logo.png',
          height: 400,
          width: 400,
        ),
        duration: 3000,
        splashTransition: SplashTransition.fadeTransition,
        nextScreen: seenOnboard == true ? SignUpPage() : OnBoardingPage(),
      ),
    );
  }
}
