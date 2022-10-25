import 'package:get/get.dart';
import 'package:wm_solution/src/api/notifications/budgets/budget_notify_api.dart';
import 'package:wm_solution/src/api/notifications/departements/budget_departement.dart';
import 'package:wm_solution/src/models/notify/notify_model.dart';
import 'package:wm_solution/src/models/notify/notify_sum_model.dart';

class BudgetNotifyController extends GetxController {
  BudgetDepartementNotifyApi budgetDepartementNotifyApi =
      BudgetDepartementNotifyApi();
  BudgetNotifyApi budgetNotifyApi = BudgetNotifyApi();

  final _itemCount = '0'.obs;
  String get itemCount => _itemCount.value;

  final _itemCountDG = 0.obs;
  int get itemCountDG => _itemCountDG.value;


  @override
  void onInit() {
    super.onInit();
    getCountBudget();
  }

  @override
  void refresh() {
    getCountBudget();
    super.refresh();
  }

  void getCountBudget() async {
    NotifySumModel notifySum =
        await budgetDepartementNotifyApi.getCountBudget();
    _itemCount.value = notifySum.sum;
  }

  void getCountDG() async {
    NotifyModel notifySum = await budgetNotifyApi.getCountDG();
    _itemCountDG.value = notifySum.count;
  }
}
