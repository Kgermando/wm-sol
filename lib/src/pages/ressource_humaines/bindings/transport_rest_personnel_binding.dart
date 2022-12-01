import 'package:get/get.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/transport_rest/transport_rest_person_controller.dart';

class TransportRestPersonnelBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<TransportRestPersonnelsController>(
        TransportRestPersonnelsController());
  }
}
