import 'package:get/get.dart';
import 'package:wm_solution/src/pages/devis/controller/devis_list_objet_controller.dart';

class DevisListObjetBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DevisListObjetController>(DevisListObjetController());
  }
}
