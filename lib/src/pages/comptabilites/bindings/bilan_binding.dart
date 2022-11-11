import 'package:get/get.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/bilans/bilan_controller.dart'; 

class BilanBinding extends Bindings {
  @override
  void dependencies() {
     Get.lazyPut<BilanController>(() => BilanController());
  }
  
}