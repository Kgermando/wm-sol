import 'package:get/get.dart';
import 'package:wm_solution/src/pages/logistique/controller/entretiens/objet_remplace_controller.dart';

class ObjetRemplaceBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ObjetRemplaceController>(ObjetRemplaceController());
  }
}
