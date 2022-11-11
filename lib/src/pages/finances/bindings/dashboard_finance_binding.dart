import 'package:get/get.dart';
import 'package:wm_solution/src/pages/finances/controller/dahboard/dashboard_finance_controller.dart'; 

class DashboardFinanceBinding extends Bindings {
  @override
  void dependencies() {
   Get.lazyPut<DashboardFinanceController>(() => DashboardFinanceController());  
  }
  
}