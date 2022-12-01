import 'package:get/get.dart';
import 'package:wm_solution/src/pages/budgets/controller/budget_previsionnel_controller.dart';

class BudgetPrevisionnelBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<BudgetPrevisionnelController>(BudgetPrevisionnelController());
  }
}
