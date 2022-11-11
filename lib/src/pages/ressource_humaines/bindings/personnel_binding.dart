import 'package:get/get.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/personnels/personnels_controller.dart'; 

class PersonnelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonnelsController>(() => PersonnelsController());
  }
  
}