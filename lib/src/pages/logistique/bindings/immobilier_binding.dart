import 'package:get/get.dart';
import 'package:wm_solution/src/pages/logistique/controller/immobiliers/immobilier_controller.dart'; 

class ImmobilierBinding extends Bindings {
  @override
  void dependencies() {
  Get.lazyPut<ImmobilierController>(() => ImmobilierController());   
  }
  
}