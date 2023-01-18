import 'package:get/get.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart'; 

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MonnaieStorage>(MonnaieStorage());
  }
}
