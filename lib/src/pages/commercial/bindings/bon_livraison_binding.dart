import 'package:get/get.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/bon_livraison/bon_livraison_controller.dart'; 

class BonLivraisonBinding extends Bindings {
  @override
  void dependencies() {
     Get.lazyPut<BonLivraisonController>(() => BonLivraisonController());
  }
  
}