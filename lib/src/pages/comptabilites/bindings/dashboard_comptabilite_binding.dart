import 'package:get/get.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/dahsboard/dashboard_comptabilite_controller.dart';

class DashboardComptabiliteBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DashboardComptabiliteController>(
       DashboardComptabiliteController());
  }
}
