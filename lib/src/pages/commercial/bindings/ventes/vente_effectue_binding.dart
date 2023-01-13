import 'package:get/get.dart'; 
import 'package:wm_solution/src/pages/commercial/controller/commercials/vente_effectue/ventes_effectue_controller.dart';

class VenteEffectueBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<VenteEffectueController>(VenteEffectueController());
  }
}
