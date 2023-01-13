import 'package:get/get.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/stock_global/livraison_controller.dart';

class LivraisonBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LivraisonController>(LivraisonController());
  }
}
