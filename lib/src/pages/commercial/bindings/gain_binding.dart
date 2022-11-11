import 'package:get/get.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/gains/gain_controller.dart'; 

class GainBinding extends Bindings {
  @override
  void dependencies() {
      Get.lazyPut<GainController>(() => GainController());
  }
  
}