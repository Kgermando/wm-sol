import 'package:get/get.dart';
import 'package:wm_solution/src/pages/administration/controller/admin_dashboard_controller.dart';

class AdminDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AdminDashboardController>(AdminDashboardController());
  }
}
