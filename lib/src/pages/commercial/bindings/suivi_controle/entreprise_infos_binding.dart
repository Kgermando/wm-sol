import 'package:get/get.dart'; 
import 'package:wm_solution/src/pages/commercial/controller/suivi_controle/entreprise_infos_controller.dart';

class EnntrepriseInfosBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<EntrepriseInfosController>(EntrepriseInfosController());
  }
}
