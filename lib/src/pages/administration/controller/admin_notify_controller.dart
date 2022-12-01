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

  final _commCount = 0.obs;
  int get commCount => _commCount.value;

  final _marketingCount = 0.obs;
  int get mrketingCount => _marketingCount.value;

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
      getCountCom();
      getCountMarketing();
      getCountLogistique();
      getCountDevis();
    
  }



  void getCountBudget() async {
    NotifySumModel notifySum = await adminDepartementNotifyApi.getCountBudget();
    _budgetCount.value = int.parse(notifySum.sum);
    update();
  }

  void getCountRh() async {
    NotifySumModel notifySum = await adminDepartementNotifyApi.getCountRh();
    _rhCount.value = int.parse(notifySum.sum);
    update();
  }

  void getCountFinance() async {
    NotifySumModel notifySum =
        await adminDepartementNotifyApi.getCountFinance();
    _financeCount.value = int.parse(notifySum.sum);
    update();
  }

  void getCountComptabilite() async {
    NotifySumModel notifySum =
        await adminDepartementNotifyApi.getCountComptabilite();
    _comptabiliteCount.value = int.parse(notifySum.sum);
    update();
  }

  void getCountExploitation() async {
    NotifySumModel notifySum =
        await adminDepartementNotifyApi.getCountExploitation();
    _exploitationCount.value = int.parse(notifySum.sum);
    update();
  }

  void getCountCom() async {
    NotifySumModel notifySum = await adminDepartementNotifyApi.getCountCom();
    _commCount.value = int.parse(notifySum.sum);
    update();
  }

  void getCountMarketing() async {
    NotifySumModel notifySum =
        await adminDepartementNotifyApi.getCountMarketing();
    _marketingCount.value = int.parse(notifySum.sum);
    update();
  }

  void getCountLogistique() async {
    NotifySumModel notifySum = await adminDepartementNotifyApi.getCountBudget();
    _logistiqueCount.value = int.parse(notifySum.sum);
    update();
  }

  void getCountDevis() async {
    NotifySumModel notifySum = await adminDepartementNotifyApi.getCountBudget();
    _devisCount.value = int.parse(notifySum.sum);
    update();
  }
}
