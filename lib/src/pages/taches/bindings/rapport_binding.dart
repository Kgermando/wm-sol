import 'package:get/get.dart';
import 'package:wm_solution/src/pages/taches/controller/rapport_controller.dart';

class RapportBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<RapportController>(RapportController());
  }
}
