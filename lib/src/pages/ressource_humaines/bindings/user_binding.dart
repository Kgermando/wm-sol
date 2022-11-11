import 'package:get/get.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/performences/performence_controller.dart'; 

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PerformenceController>(() => PerformenceController());
  }
  
}