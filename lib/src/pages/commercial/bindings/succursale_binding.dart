import 'package:get/get.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/succursale/succursale_controller.dart'; 

class SuccursaleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SuccursaleController>(() => SuccursaleController()); 
  }
  
}