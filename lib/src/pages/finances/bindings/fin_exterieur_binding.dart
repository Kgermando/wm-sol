import 'package:get/get.dart';
import 'package:wm_solution/src/pages/finances/controller/fin_exterieur/fin_exterieur_controller.dart';

class FinExterieurBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<FinExterieurController>(FinExterieurController());
  }
}
