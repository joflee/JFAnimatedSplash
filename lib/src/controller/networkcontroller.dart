import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../listener/ConnectivityInterface.dart';

class NetworkController extends GetxController {
  var connectionStatus = 0.obs;
  RxBool internetConnection = false.obs;
  final Connectivity connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  late ConnectivityResult result;
  ConnectivityInterFace? connectivityInterFace;

  setConnectivityInterFace(ConnectivityInterFace? connectivityInterFace) {
    this.connectivityInterFace = connectivityInterFace;
  }

  NetworkController() {
    initconnectivity();
    _connectivitySubscription =
        connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> initconnectivity() async {
    late ConnectivityResult result;
    try {
      result = await connectivity.checkConnectivity();
      // ignore: empty_catches
    } on PlatformException {}
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        connectionStatus.value = 1;
        break;
      case ConnectivityResult.mobile:
        connectionStatus.value = 2;
        break;
      case ConnectivityResult.none:
        connectionStatus.value = 0;
        break;
      default:
        break;
    }
    if (connectivityInterFace != null) {
      connectivityInterFace!.onConnection();
    }
  }

  @override
  void onClose() {
    super.onClose();
    _connectivitySubscription.cancel();
  }
}
