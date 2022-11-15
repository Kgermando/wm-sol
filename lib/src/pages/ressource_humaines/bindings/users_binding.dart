import 'package:get/get.dart'; 
import 'package:wm_solution/src/pages/ressource_humaines/controller/personnels/user_actif_controller.dart'; 

class UsersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UsersController>(() => UsersController());
  }
  
}