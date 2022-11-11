import 'package:get/get.dart';
import 'package:wm_solution/src/pages/marketing/controller/annuaire/annuaire_controller.dart'; 

class AnnuaireBinding extends Bindings {
  @override
  void dependencies() {
   Get.lazyPut<AnnuaireController>(() => AnnuaireController());  
  }
  
}