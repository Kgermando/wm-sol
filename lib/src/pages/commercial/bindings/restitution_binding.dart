import 'package:get/get.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/restitution/restitution_controller.dart'; 

class RestitutionBinding extends Bindings {
  @override
  void dependencies() {
         Get.lazyPut<RestitutionController>(() => RestitutionController());
  }
  
}