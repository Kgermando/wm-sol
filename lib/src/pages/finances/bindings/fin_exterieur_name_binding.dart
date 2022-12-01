import 'package:get/get.dart';
import 'package:wm_solution/src/pages/finances/controller/fin_exterieur/fin_exterieur_name_controller.dart';

class FinExterieurNameBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<FinExterieurNameController>(FinExterieurNameController());
  }
}
