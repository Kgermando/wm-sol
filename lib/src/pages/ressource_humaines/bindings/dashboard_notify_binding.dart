import 'package:get/get.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/notify/dashboard_rh_controller.dart';

class DashboardNotifyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DashobardRHController>(DashobardRHController());
  }
}
