import 'package:get/get.dart';
import 'package:wm_solution/src/pages/budgets/controller/ligne_budgetaire_controller.dart'; 

class LignBudgetaireBinding extends Bindings {
  @override
  void dependencies() {
     Get.lazyPut<LignBudgetaireController>(() => LignBudgetaireController());
  }
  
}