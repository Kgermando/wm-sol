import 'package:get/get.dart';
import 'package:wm_solution/src/pages/logistique/controller/materiels/materiel_controller.dart'; 

class MaterielBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MaterielController>(() => MaterielController()); 
  }
  
}