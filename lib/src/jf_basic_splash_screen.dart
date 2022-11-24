import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jf_animated_splash/jf_animated_splash.dart';
import 'package:jf_animated_splash/src/controller/networkcontroller.dart';

import 'app_description_widget.dart';
import 'app_name_widget.dart';
import 'basic_info_detail_widget.dart';
import 'logo_widget.dart';

class JfBasicSplashScreen extends StatefulWidget {
  const JfBasicSplashScreen({
    super.key,
    required this.appLogoURL,
    this.logoColor,
    required this.title1,
    this.title2,
    this.title3,
    this.title4,
    this.title5,
    // this.bottomWidget,
    required this.backgroundColor,
    this.logoStopDuration,
    this.logoFadeDuration,
    this.transitionDuration,
    this.initFunctions,
    required this.navigationScreen,
    this.requiredInternet,
  }) : bottomWidget = null;

  const JfBasicSplashScreen.customBottom({
    super.key,
    required this.appLogoURL,
    this.logoColor,
    required this.title1,
    this.title2,
    // this.title3,
    // this.title4,
    // this.title5,
    this.bottomWidget,
    required this.backgroundColor,
    this.logoStopDuration,
    this.logoFadeDuration,
    this.transitionDuration,
    this.initFunctions,
    required this.navigationScreen,
    this.requiredInternet,
  })  : title3 = null,
        title4 = null,
        title5 = null;

  /// Add image path of your image from assets
  final String appLogoURL;

  /// True - It will check first internet connection, if internet will available then only app will start.
  ///
  /// False - The app will start whether internet connection is available or not.
  final bool? requiredInternet;

  /// If non-null, this color is blended with each image pixel using [colorBlendMode].
  final Color? logoColor;

  /// Add the text widget to show the name of your application
  final Text title1;

  /// Add the  text widget to show the basic description of your application
  final Text? title2;

  /// Add the  text widget to show the version of your application
  final Text? title3;

  /// Add the text widget to show the name of your company
  final Text? title4;

  /// Add the text widget to show the  Country of origin
  final Text? title5;

  /// Add bottom widget like your company name, country of origin, app version etc.
  final Widget? bottomWidget;

  /// Add the background colour of your animation screen
  final Color backgroundColor;

  /// Add the duration time of fade which use in logo
  final Duration? logoFadeDuration;

  /// Add the time of animation which use in all the positioned and opacity
  final Duration? transitionDuration;

  /// Add the time how long you have to stand when the logo is fully visible in the middle
  final Duration? logoStopDuration;

  /// If your App is having any intial Network calls or other processes,
  /// You can put it here so loading animation is show accornding to it &
  /// then navigate to the next screen which provided in the [navigationScreen]
  final Iterable<Future>? initFunctions;

  /// Add the Screen where you want to navigate after the spalsh Screen
  final Widget navigationScreen;

  @override
  JfBasicSplashScreenState createState() => JfBasicSplashScreenState();
}

class JfBasicSplashScreenState extends State<JfBasicSplashScreen>
    implements ConnectivityInterFace {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0), () {
      animationFunction();
      if (widget.requiredInternet == true) {
        kNetworkController.setConnectivityInterFace(this);
      }
    });
  }

  NetworkController kNetworkController = Get.put(NetworkController());

  bool isVersionCheck = true;

  onConnectionCall() async {
    if (widget.requiredInternet == true) {
      if (kNetworkController.connectionStatus.value != 0 && isVersionCheck) {
        isVersionCheck = false;
        if (!allAnimationDone) {
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => widget.navigationScreen,
              ),
            );
          });
        }
      } else if (kNetworkController.connectionStatus.value == 0) {
        isVersionCheck = true;
      }
    }
  }

  animationFunction() async {
    setState(() {
      isAnimate = !isAnimate;
    });
    Future.delayed(widget.logoFadeDuration ?? const Duration(seconds: 1), () {
      Future.delayed(widget.logoStopDuration ?? const Duration(seconds: 1), () {
        setState(() {
          isAnimateDone = !isAnimateDone;
        });
        Future.delayed(
            widget.transitionDuration ??
                const Duration(
                  seconds: 1,
                ), () {
          setState(() {
            allAnimationDone = !allAnimationDone;
          });
          widget.initFunctions != null
              ? kNetworkController.connectionStatus.value != 0
                  ? Future.wait(widget.initFunctions ?? []).then(
                      (value) => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => widget.navigationScreen,
                        ),
                        (route) => false,
                      ),
                    )
                  : () {}
              : kNetworkController.internetConnection.value ==
                          widget.requiredInternet ||
                      kNetworkController.connectionStatus.value != 0
                  ? Future.delayed(const Duration(seconds: 1), () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => widget.navigationScreen,
                        ),
                        (route) => false,
                      );
                    })
                  : () {};
        });
      });
    });
  }

  bool isAnimate = true;
  bool isAnimateDone = true;
  bool allAnimationDone = true;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var logoWidth = MediaQuery.of(context).size.width > 600
        ? MediaQuery.of(context).size.width / 5
        : MediaQuery.of(context).size.width / 3;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: widget.backgroundColor,
        body: Center(
          child: Stack(
            children: [
              Stack(
                children: [
                  AnimatedPositioned(
                    curve: Curves.fastLinearToSlowEaseIn,
                    top: isAnimateDone
                        ? height / 2 - logoWidth / 2
                        : (height / 2 - height * 0.22) - logoWidth / 2,
                    left: width / 2 - logoWidth / 2,
                    duration:
                        widget.transitionDuration ?? const Duration(seconds: 1),
                    child: LogoWidget(
                      imageLink: widget.appLogoURL,
                      logoColor: widget.logoColor,
                      scale: isAnimate ? 0.0 : 1.0,
                      width: logoWidth,
                      fadeDuration: widget.logoFadeDuration,
                    ),
                  ),
                  AnimatedPositioned(
                    curve: Curves.fastLinearToSlowEaseIn,
                    duration:
                        widget.transitionDuration ?? const Duration(seconds: 1),
                    top: isAnimateDone
                        ? height / 2 + logoWidth / 2 + 25
                        : (height / 2 - height * 0.22) + logoWidth / 2 + 35,
                    width: width,
                    child: AnimatedOpacity(
                      duration: widget.transitionDuration ??
                          const Duration(seconds: 1),
                      opacity: isAnimateDone ? 0 : 1,
                      child: Padding(
                        padding: EdgeInsets.zero,
                        child: Column(
                          children: [
                            AppName(
                              appTitle: widget.title1,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            AppDescription(
                              appDescription: widget.title2,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              AnimatedPositioned(
                curve: Curves.fastLinearToSlowEaseIn,
                duration:
                    widget.transitionDuration ?? const Duration(seconds: 1),
                bottom: 0,
                width: width,
                child: Container(
                  color: widget.backgroundColor,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: (height / 2 - height * (0.45)),
                    ),
                    child: AnimatedOpacity(
                      duration: widget.transitionDuration ??
                          const Duration(seconds: 1),
                      opacity: isAnimateDone ? 0 : 1,
                      child: Container(
                        color: widget.backgroundColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Obx(
                              () => AnimatedOpacity(
                                duration: widget.transitionDuration ??
                                    const Duration(seconds: 0),
                                opacity: allAnimationDone ? 0 : 1,
                                child: kNetworkController
                                            .internetConnection.value !=
                                        widget.requiredInternet
                                    ? kNetworkController
                                                .connectionStatus.value ==
                                            0
                                        ? const Text(
                                            'Please check your internet connection!',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.red,
                                            ),
                                          )
                                        : Container(
                                            color: widget.backgroundColor,
                                            child: Center(
                                                child: Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.grey,
                                                      blurRadius:
                                                          3 // Shadow position
                                                      ),
                                                ],
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(6.0),
                                                child: SizedBox(
                                                  height: 15.0,
                                                  width: 15.0,
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            )),
                                          )
                                    : Container(
                                        color: widget.backgroundColor,
                                        child: Center(
                                            child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey,
                                                  blurRadius:
                                                      3 // Shadow position
                                                  ),
                                            ],
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(6.0),
                                            child: SizedBox(
                                              height: 15.0,
                                              width: 15.0,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        )),
                                      ),
                              ),
                            ),
                            const SizedBox(
                              height: 28,
                            ),
                            BasicInfoDetailWidget(
                              bottomWidget: widget.bottomWidget,
                              version: widget.title3,
                              companyName: widget.title4,
                              appOrigin: widget.title5,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onConnection() {
    onConnectionCall();
  }
}
