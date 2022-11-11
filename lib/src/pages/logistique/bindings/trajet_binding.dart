import 'package:get/get.dart';
import 'package:wm_solution/src/pages/logistique/controller/trajets/trajet_controller.dart'; 

class TrajetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrajetController>(() => TrajetController()); 
  }
  
}