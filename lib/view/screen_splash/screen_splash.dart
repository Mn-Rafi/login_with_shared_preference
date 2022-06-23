import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:pullrequests_projectct/view/screen_dash/screen_dash.dart';
import 'package:pullrequests_projectct/view/screen_login/screen_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({Key? key}) : super(key: key);

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  void navigate() async {
    final sharedprefs = await SharedPreferences.getInstance();
    final bool? isLoggedIn = sharedprefs.getBool('isLoggedIn');
    if (isLoggedIn != null && isLoggedIn) {
      Timer(Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ScreenDash(),
        ));
      });
    } else {
      Timer(Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ScreenLogin(),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Pulse(
          child: AnimatedTextKit(animatedTexts: [
            ColorizeAnimatedText('Welcome',
                textAlign: TextAlign.center,
                speed: const Duration(milliseconds: 2000),
                textStyle: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink[50]),
                colors: [
                  Colors.pink[300]!,
                  Colors.red,
                  Colors.yellow,
                  Colors.green,
                  Colors.green,
                  Colors.blue
                ]),
          ]),
        ),
      ),
    );
  }
}
