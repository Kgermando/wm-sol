import 'package:get/get.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart'; 

class ProfilBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfilController>(() => ProfilController());
  }
  
}