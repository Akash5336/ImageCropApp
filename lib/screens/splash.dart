import 'package:flutter/material.dart';

import 'home_screen.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigateHome();
  }

  _navigateHome() async {
    await Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (ctx) => const HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final pageHeight = MediaQuery.of(context).size.height;
    final pageWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        height: pageHeight,
        width: pageWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: pageWidth * 0.5,
              height: pageHeight * 0.2,
              child: Image.asset("assets/pics/splash_image.png"),
            ),
            Text(
              "Celebrare",
              style: TextStyle(
                fontFamily: "Watermelon",
                color: Colors.black.withOpacity(0.45),
                fontSize: pageHeight * 0.06,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: pageWidth * 0.15),
              child: Text(
                "Digital Invitations",
                style: TextStyle(
                  fontSize: pageHeight * 0.01,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
