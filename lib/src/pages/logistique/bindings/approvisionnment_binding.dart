import 'package:get/get.dart';
import 'package:wm_solution/src/pages/logistique/controller/approvisions/approvisionnement_controller.dart'; 

class ApprovisionnementBinding extends Bindings {
  @override
  void dependencies() {
         Get.lazyPut<ApprovisionnementController>(
        () => ApprovisionnementController());
  }
  
}