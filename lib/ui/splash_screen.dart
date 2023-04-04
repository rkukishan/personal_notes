import 'dart:async';

import 'package:flutter/material.dart';
import 'package:personal_notes/ui/home_page_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(const Duration(seconds: 2), (timer) {
      if (mounted) {
        /*Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePageScreen(),
            )); */

        Navigator.pushReplacementNamed(context, "homepagescreen");
        
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset("assets/icon/app_icon.png"),
      ),
    );
  }
}
