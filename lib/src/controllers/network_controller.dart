
import 'dart:async';

import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkController extends GetxController {
  static NetworkController to = Get.find();

  //Stream to keep listening to network change state
  late StreamSubscription _streamSubscription;

  final _connectionStatus = 1.obs;
  int get connectionStatus => _connectionStatus.value;

  late StreamSubscription<InternetConnectionStatus> _listener;

  @override
  void onInit() {
    super.onInit();

    _listener = InternetConnectionChecker()
        .onStatusChange
        .listen((InternetConnectionStatus status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          _connectionStatus.value = 1;
          break;
        case InternetConnectionStatus.disconnected:
          _connectionStatus.value = 0;
          break;
      }
    });
  }

  @override
  void onClose() {
    //stop listening to network state when app is closed
    _streamSubscription.cancel();
    _listener.cancel();
    super.onClose();
  }
}
