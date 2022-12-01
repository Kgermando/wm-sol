import 'package:get/get.dart';
import 'package:wm_solution/src/pages/auth/controller/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController());
  }
}
