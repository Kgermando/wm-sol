import 'package:get/get.dart';
import 'package:wm_solution/src/pages/logistique/controller/etat_materiel/etat_materiel_controller.dart';

class EtatMaterielBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<EtatMaterielController>(EtatMaterielController());
  }
}
