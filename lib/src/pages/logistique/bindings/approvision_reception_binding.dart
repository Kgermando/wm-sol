import 'package:get/get.dart';
import 'package:wm_solution/src/pages/logistique/controller/approvisions/approvision_reception_controller.dart';

class ApprovisionReceptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ApprovisionReceptionController>(
        ApprovisionReceptionController());
  }
}
