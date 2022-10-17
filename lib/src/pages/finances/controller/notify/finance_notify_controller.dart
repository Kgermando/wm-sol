import 'package:get/get.dart';
import 'package:wm_solution/src/api/notifications/departements/finance_departement.dart';
import 'package:wm_solution/src/api/notifications/finances/creance_notify_api.dart';
import 'package:wm_solution/src/api/notifications/finances/dette_notify_api.dart';
import 'package:wm_solution/src/models/notify/notify_model.dart';
import 'package:wm_solution/src/models/notify/notify_sum_model.dart';

class FinanceNotifyController extends GetxController {
  FinanceDepartementNotifyApi financeDepartementNotifyApi =
      FinanceDepartementNotifyApi();
  CreanceNotifyApi creanceNotifyApi = CreanceNotifyApi();
  DetteNotifyApi detteNotifyApi = DetteNotifyApi();

  final _itemCount = '0'.obs;
  String get itemCount => _itemCount.value;
  final _itemCountObs = '0'.obs;
  String get itemCountObs => _itemCountObs.value;

  final _creanceCount = 0.obs;
  int get creanceCount => _creanceCount.value;
  final _detteCount = 0.obs;
  int get detteCount => _detteCount.value;

  @override
  void onInit() {
    super.onInit();
    getCountDD();
    getCountObs();
    getCountCreance();
    getCountDette();
  }

  @override
  void refresh() {
    getCountDD();
    getCountObs();
    getCountCreance();
    getCountDette();
    super.refresh();
  }

  void getCountDD() async {
    NotifySumModel notifySum =
        await financeDepartementNotifyApi.getCountFinanceDD();
    _itemCount.value = notifySum.sum;
  }

  void getCountObs() async {
    NotifySumModel notifySum =
        await financeDepartementNotifyApi.getCountFinanceDD();
    _itemCountObs.value = notifySum.sum;
  }

  void getCountCreance() async {
    NotifyModel notifySum =
        await creanceNotifyApi.getCountDD();
    _creanceCount.value = notifySum.count;
  }

  void getCountDette() async {
    NotifyModel notifySum =
        await detteNotifyApi.getCountDD();
    _detteCount.value = notifySum.count;
  }
}
