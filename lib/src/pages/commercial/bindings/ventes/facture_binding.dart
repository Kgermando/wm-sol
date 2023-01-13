import 'package:get/get.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/factures/facture_controller.dart';

class FactureBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<FactureController>(FactureController());
  }
}
