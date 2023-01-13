import 'package:get/get.dart';
import 'package:wm_solution/src/pages/commercial/controller/dashboard/dashboard_com_controller.dart';

class DashboardComBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DashboardComController>(DashboardComController());
  }
}
