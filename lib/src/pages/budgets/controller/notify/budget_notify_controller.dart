// import 'package:get/get.dart';
// import 'package:wm_solution/src/api/notifications/budgets/budget_notify_api.dart';
// import 'package:wm_solution/src/api/notifications/departements/budget_departement.dart';
// import 'package:wm_solution/src/models/notify/notify_model.dart';
// import 'package:wm_solution/src/models/notify/notify_sum_model.dart';

// class BudgetNotifyController extends GetxController {
//   BudgetDepartementNotifyApi budgetDepartementNotifyApi =
//       BudgetDepartementNotifyApi();
//   BudgetNotifyApi budgetNotifyApi = BudgetNotifyApi();

//   final _itemCount = '0'.obs;
//   String get itemCount => _itemCount.value;

//   final _itemCountDG = 0.obs;
//   int get itemCountDG => _itemCountDG.value;

//   final _itemCountDD = 0.obs;
//   int get itemCountDD => _itemCountDD.value;

//   @override
//   void onInit() {
//     super.onInit();
//     getBudgetCountBudget();
//     getBudgetCountDG();
//     getBudgetCountDD();
//   }

//   void getBudgetCountBudget() async {
//     NotifySumModel notifySum =
//         await budgetDepartementNotifyApi.getCountBudget();
//     _itemCount.value = notifySum.sum;
//     update();
//   }

//   void getBudgetCountDG() async {
//     NotifyModel notifySum = await budgetNotifyApi.getCountDG();
//     _itemCountDG.value = notifySum.count;
//     update();
//   }

//   void getBudgetCountDD() async {
//     NotifyModel notifySum = await budgetNotifyApi.getCountDD();
//     _itemCountDD.value = notifySum.count;
//     update();
//   }
// }
