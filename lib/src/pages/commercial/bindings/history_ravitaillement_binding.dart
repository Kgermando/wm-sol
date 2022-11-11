import 'package:get/get.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/history/history_ravitaillement_controller.dart'; 

class HistoryRavitaillementBinding extends Bindings {
  @override
  void dependencies() {
         Get.lazyPut<HistoryRavitaillementController>(
        () => HistoryRavitaillementController());
  }
  
}