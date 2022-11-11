import 'package:get/get.dart';
import 'package:wm_solution/src/pages/logistique/controller/entretiens/entretiens_controller.dart'; 

class EntretienBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EntretienController>(() => EntretienController()); 
  }
  
}