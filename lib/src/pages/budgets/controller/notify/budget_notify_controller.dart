import 'package:get/get.dart';
import 'package:wm_solution/src/api/notifications/departements/budget_departement.dart';
import 'package:wm_solution/src/models/notify/notify_sum_model.dart';

class BudgetNotifyController extends GetxController {
  BudgetDepartementNotifyApi budgetDepartementNotifyApi =
      BudgetDepartementNotifyApi();

  final _itemCount = '0'.obs;
  String get itemCount => _itemCount.value;

    @override
  void onInit() {
    super.onInit();
    getCountBudget(); 
  }


  void getCountBudget() async {
    NotifySumModel notifySum = await budgetDepartementNotifyApi.getCountBudget();
    _itemCount.value = notifySum.sum;
  }
}
