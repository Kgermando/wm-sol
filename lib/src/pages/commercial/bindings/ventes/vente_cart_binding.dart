import 'package:get/get.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/history/history_vente_controller.dart';

class VenteCartBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<VenteCartController>(VenteCartController());
  }
}
