import 'package:get/get.dart';
import 'package:wm_solution/src/pages/logistique/controller/dashboard/dashboard_log_controller.dart';

class DashboardLogBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DashboardLogController>(DashboardLogController());
  }
}
