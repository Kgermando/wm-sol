import 'package:get/get.dart';
import 'package:wm_solution/src/pages/taches/controller/taches_controller.dart'; 

class TacheBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TachesController>(() => TachesController());
  }
  
}