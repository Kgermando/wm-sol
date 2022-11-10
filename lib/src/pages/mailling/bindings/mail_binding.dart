import 'package:get/get.dart';
import 'package:wm_solution/src/pages/mailling/controller/mailling_controller.dart'; 

class MailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MaillingController>(() => MaillingController());
  }
  
}