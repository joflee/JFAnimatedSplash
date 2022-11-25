import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jf_animated_splash/jf_animated_splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(context) {
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
            requiredInternet: true,
            title5: const Text("Made with  \u2764  in India",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
            title3: const Text("v1.0.8(265)",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue)),
            title4: Text("JoFlee's Product",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.deepPurple[400])),

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
            navigationFunction: () {
              Future.delayed(const Duration(seconds: 5))
                  .then((value) => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const MyHomePage()),
                      ));
              log("my name is krutik");
            },
          );
        }));
  }
}
