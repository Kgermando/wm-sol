import 'package:get/get.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/stock_global/ravitaillement_controller.dart'; 

class RavitaillementBinding extends Bindings {
  @override
  void dependencies() {
  Get.lazyPut<RavitaillementController>(() => RavitaillementController());   
  }
  
}