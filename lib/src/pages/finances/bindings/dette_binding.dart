import 'package:get/get.dart';
import 'package:wm_solution/src/pages/finances/controller/dettes/dette_controller.dart'; 

class DetteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetteController>(() => DetteController());
  }
  
}