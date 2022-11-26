import 'package:get/get.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/gains/gain_controller.dart'; 

class GainCartBinding extends Bindings {
  @override
  void dependencies() {
      Get.lazyPut<GainCartController>(() => GainCartController());
  }
  
}