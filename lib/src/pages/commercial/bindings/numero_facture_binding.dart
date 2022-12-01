import 'package:get/get.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/factures/numero_facture_controller.dart';

class NumeroFactureBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<NumeroFactureController>(NumeroFactureController());
  }
}
