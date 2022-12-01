import 'package:get/get.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/compte_resultat/compte_resultat_controller.dart';

class CompteResultatBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CompteResultatController>(CompteResultatController());
  }
}
