import 'package:get/get.dart';
import 'package:wm_solution/src/pages/finances/controller/banques/banque_name_controller.dart';

class BanqueNameBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<BanqueNameController>(BanqueNameController());
  }
}
