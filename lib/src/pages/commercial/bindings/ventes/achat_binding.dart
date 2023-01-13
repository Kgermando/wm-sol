import 'package:get/get.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/achats/achat_controller.dart';

class AchatBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AchatController>(AchatController());
  }
}
