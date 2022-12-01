import 'package:get/get.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/transport_rest/transport_rest_controller.dart';

class TransportRestBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<TransportRestController>(TransportRestController());
  }
}
