import 'dart:async';

// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkController extends GetxController {
  // static NetworkController to = Get.find();

  // // this variable 0 = No Internet, 1 = connected to WIFI ,2 = connected to Mobile Data.
  // // Instance of Flutter Connectivity

  // int connectionType = 0;
  // final Connectivity _connectivity = Connectivity();
  // //Stream to keep listening to network change state
  // late StreamSubscription _streamSubscription;

  // final _connectionStatus = 0.obs;
  // int get connectionStatus => _connectionStatus.value;

  // late StreamSubscription<InternetConnectionStatus> _listener;

  // @override
  // void onInit() {
  //   super.onInit();
  //   _getConnectionType();
  //   _streamSubscription =
  //       _connectivity.onConnectivityChanged.listen(_updateState);

  //   _listener = InternetConnectionChecker()
  //       .onStatusChange
  //       .listen((InternetConnectionStatus status) {
  //     switch (status) {
  //       case InternetConnectionStatus.connected:
  //         _connectionStatus.value = 1;
  //         break;
  //       case InternetConnectionStatus.disconnected:
  //         _connectionStatus.value = 0;
  //         break;
  //     }
  //   });
  // }

  // // a method to get which connection result, if you we connected to internet or no if yes then which network
  // Future<void> _getConnectionType() async {
  //   ConnectivityResult? connectivityResult;
  //   try {
  //     connectivityResult = await (_connectivity.checkConnectivity());
  //   } on PlatformException catch (e) {
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //   }
  //   return _updateState(connectivityResult!);
  // }

  // // state update, of network, if you are connected to WIFI connectionType will get set to 1,
  // // and update the state to the consumer of that variable.
  // _updateState(ConnectivityResult result) {
  //   switch (result) {
  //     case ConnectivityResult.wifi:
  //       connectionType = 1;
  //       update();
  //       break;
  //     case ConnectivityResult.mobile:
  //       connectionType = 2;
  //       update();
  //       break;
  //     case ConnectivityResult.none:
  //       connectionType = 0;
  //       update();
  //       break;
  //     default:
  //       Get.snackbar('Network Error', 'Failed to get Network Status');
  //       break;
  //   }
  // }

  // @override
  // void onClose() {
  //   //stop listening to network state when app is closed
  //   _streamSubscription.cancel();
  //   _listener.cancel();
  //   super.onClose();
  // }
}
