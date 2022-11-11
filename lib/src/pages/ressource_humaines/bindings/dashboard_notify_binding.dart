import 'package:get/get.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/notify/dashboard_notify_controller.dart'; 

class DashboardNotifyBinding extends Bindings {
  @override
  void dependencies() {
     Get.lazyPut<DashobardNotifyController>(() => DashobardNotifyController());
  }
  
}