import 'package:get/get.dart';
import 'package:wm_solution/src/pages/logistique/controller/mobiliers/mobilier_controller.dart';

class MobilierBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MobilierController>(MobilierController());
  }
}
