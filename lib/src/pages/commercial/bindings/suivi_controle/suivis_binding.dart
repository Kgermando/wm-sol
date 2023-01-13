import 'package:get/get.dart'; 
import 'package:wm_solution/src/pages/commercial/controller/suivi_controle/suivis_controller.dart';

class SuivisBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SuivisController>(SuivisController());
  }
}
