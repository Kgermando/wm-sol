import 'package:get/get.dart';
import 'package:wm_solution/src/pages/budgets/controller/dashboard_budget_controller.dart'; 

class DashboardBudgetBinding extends Bindings {
  @override
  void dependencies() {
     Get.lazyPut<DashboardBudgetController>(() => DashboardBudgetController());
  }
  
}