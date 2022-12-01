import 'package:get/get.dart';
import 'package:wm_solution/src/pages/auth/controller/forgot_controller.dart';

class ForgotPaswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ForgotPasswordController>(ForgotPasswordController());
  }
}
