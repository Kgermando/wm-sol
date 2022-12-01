import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MonnaieStorage extends GetxController {
  static const _keyMonnaie = 'monnaie';
  GetStorage box = GetStorage();

  final _monney = '\$'.obs;
  String get monney => _monney.value;

  @override
  void onInit() {
    super.onInit();
    // getData();
  }


  getData() {
    final data = box.read(_keyMonnaie);
    _monney.value = json.decode(data);
  }

  setData(value) async {
    box.write(_keyMonnaie, json.encode(value));
  }

  removeData() async {
    await box.remove(_keyMonnaie);
  }

  
}
