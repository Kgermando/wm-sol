import 'package:get/get.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/factures/facture_creance_controller.dart';

class FactureCreanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<FactureCreanceController>(FactureCreanceController());
  }
}
