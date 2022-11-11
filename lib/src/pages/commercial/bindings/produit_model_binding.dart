import 'package:get/get.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/produit_model/produit_model_controller.dart'; 

class ProduitModelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProduitModelController>(() => ProduitModelController()); 
  }
  
}