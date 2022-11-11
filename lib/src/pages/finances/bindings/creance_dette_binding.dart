import 'package:get/get.dart';
import 'package:wm_solution/src/pages/finances/controller/creance_dettes/creance_dette_controller.dart'; 

class CreanceDetteBinding extends Bindings {
  @override
  void dependencies() {
   Get.lazyPut<CreanceDetteController>(() => CreanceDetteController());  
  }
  
}