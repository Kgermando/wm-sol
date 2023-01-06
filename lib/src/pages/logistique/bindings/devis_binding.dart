import 'package:get/get.dart';
import 'package:wm_solution/src/pages/logistique/controller/devis/devis_controller.dart';

class DevisBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DevisController>(DevisController());
  }
}
