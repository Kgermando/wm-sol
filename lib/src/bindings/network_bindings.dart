import 'package:get/get.dart';
import 'package:wm_solution/src/controllers/network_controller.dart';

class NetworkBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<NetworkController>(NetworkController());
  }


}
