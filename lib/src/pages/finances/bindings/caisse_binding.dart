import 'package:get/get.dart';
import 'package:wm_solution/src/pages/finances/controller/caisses/caisse_controller.dart'; 

class CaisseBinding extends Bindings {
  @override
  void dependencies() {
   Get.lazyPut<CaisseController>(() => CaisseController());  
  }
  
}