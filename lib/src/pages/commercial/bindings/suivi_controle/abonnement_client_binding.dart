import 'package:get/get.dart'; 
import 'package:wm_solution/src/pages/commercial/controller/suivi_controle/abonnement_client_controller.dart';

class AbonnementClientBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AbonnementClientController>(AbonnementClientController());
  }
}
