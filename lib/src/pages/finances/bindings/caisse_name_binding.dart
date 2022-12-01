import 'package:get/get.dart';
import 'package:wm_solution/src/pages/finances/controller/caisses/caisse_name_controller.dart';

class CaisseNameBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CaisseNameController>(CaisseNameController());
  }
}
