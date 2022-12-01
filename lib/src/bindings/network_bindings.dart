import 'package:get/get.dart';
import 'package:wm_solution/src/helpers/network_controller.dart';

class NetworkBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<NetworkController>(NetworkController());
  }
}
