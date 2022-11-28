import 'package:get/get.dart';
import 'package:wm_solution/src/pages/screens/controller/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
  }
}
