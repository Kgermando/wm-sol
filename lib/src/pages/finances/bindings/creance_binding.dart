import 'package:get/get.dart';
import 'package:wm_solution/src/pages/finances/controller/creances/creance_controller.dart'; 

class CreanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreanceController>(() => CreanceController()); 
  }
  
}