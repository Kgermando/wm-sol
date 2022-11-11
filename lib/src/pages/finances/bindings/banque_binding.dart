import 'package:get/get.dart';
import 'package:wm_solution/src/pages/finances/controller/banques/banque_controller.dart'; 

class BanqueBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BanqueController>(() => BanqueController());  
  }
  
}