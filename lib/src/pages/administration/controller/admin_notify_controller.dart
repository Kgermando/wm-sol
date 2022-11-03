import 'package:get/get.dart';
import 'package:wm_solution/src/api/notifications/departements/admin_departement.dart';
import 'package:wm_solution/src/models/notify/notify_sum_model.dart';

class AdminNotifyController extends GetxController {
  AdminDepartementNotifyApi adminDepartementNotifyApi =
      AdminDepartementNotifyApi();

  final _budgetCount = 0.obs;
  int get budgetCount => _budgetCount.value;

  final _financeCount = 0.obs;
  int get financeCount => _financeCount.value;

  final _comptabiliteCount = 0.obs;
  int get comptabiliteCount => _comptabiliteCount.value;

  final _rhCount = 0.obs;
  int get rhCount => _rhCount.value;

  final _exploitationCount = 0.obs;
  int get exploitationCount => _exploitationCount.value;

  final _commMarketingCount = 0.obs;
  int get commMarketingCount => _commMarketingCount.value;

  final _logistiqueCount = 0.obs;
  int get logistiqueCount => _logistiqueCount.value;

  final _devisCount = 0.obs;
  int get devisCount => _devisCount.value;

  @override
  void onInit() {
    super.onInit();
    getCountBudget();
    getCountRh();
    getCountFinance();
    getCountComptabilite();
    getCountExploitation();
    getCountcom();
    getCountLogistique();
    getCountDevis();
  }

  @override
  void refresh() {
    getCountBudget();
    getCountRh();
    getCountFinance();
    getCountComptabilite();
    getCountExploitation();
    getCountcom();
    getCountLogistique();
    getCountDevis();
    super.refresh();
  }

  void getCountBudget() async {
    NotifySumModel notifySum = await adminDepartementNotifyApi.getCountBudget();
    _budgetCount.value = int.parse(notifySum.sum);
  }

  void getCountRh() async {
    NotifySumModel notifySum = await adminDepartementNotifyApi.getCountRh();
    _rhCount.value = int.parse(notifySum.sum);
  }

  void getCountFinance() async {
    NotifySumModel notifySum =
        await adminDepartementNotifyApi.getCountFinance();
    _financeCount.value = int.parse(notifySum.sum);
  }

  void getCountComptabilite() async {
    NotifySumModel notifySum =
        await adminDepartementNotifyApi.getCountComptabilite();
    _comptabiliteCount.value = int.parse(notifySum.sum);
  }

  void getCountExploitation() async {
    NotifySumModel notifySum = await adminDepartementNotifyApi.getCountBudget();
    _exploitationCount.value = int.parse(notifySum.sum);
  }

  void getCountcom() async {
    NotifySumModel notifySum = await adminDepartementNotifyApi.getCountBudget();
    _commMarketingCount.value = int.parse(notifySum.sum);
  }

  void getCountLogistique() async {
    NotifySumModel notifySum = await adminDepartementNotifyApi.getCountBudget();
    _logistiqueCount.value = int.parse(notifySum.sum);
  }

  void getCountDevis() async {
    NotifySumModel notifySum = await adminDepartementNotifyApi.getCountBudget();
    _devisCount.value = int.parse(notifySum.sum);
  }
}
