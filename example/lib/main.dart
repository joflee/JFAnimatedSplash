import 'package:animation_package/animation_package.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Joflee Splash',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Builder(builder: (context) {
        return JfBasicSplashScreen(
          // bottomWidget: Text(
          //   "Krutik",
          //   style: TextStyle(
          //       fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          // ),
          requiredInternet: false,
          // title5: Text("Made with  \u2764  in India",
          //     style: TextStyle(
          //         fontSize: 14,
          //         fontWeight: FontWeight.w500,
          //         color: Colors.black)),
          // title3: Text("v1.0.8(265)",
          //     style: TextStyle(
          //         fontSize: 14,
          //         fontWeight: FontWeight.w500,
          //         color: Colors.blue)),
          // title4: Text("JoFlee's Product",
          //     style: TextStyle(
          //         fontSize: 14,
          //         fontWeight: FontWeight.w500,
          //         color: Colors.deepPurple[400])),

          title1: const Text(
            "Money Manager",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
          title2: const Text(
            "Your Go To Expense Tracker and Budgets",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          appLogoURL: "assets/ic_logo.png",
          logoStopDuration: const Duration(seconds: 0),
          logoFadeDuration: const Duration(seconds: 1),
          transitionDuration: const Duration(seconds: 1),
          initFunctions: [
            Future.delayed(
              const Duration(seconds: 10),
            ),
          ],
          navigationScreen: const MyHomePage(),
        );
      }),
    );
  }
}
