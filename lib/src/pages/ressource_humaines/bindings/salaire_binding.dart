import 'package:get/get.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/salaires/salaire_controller.dart';

class SalaireBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SalaireController>(SalaireController());
  }
}
