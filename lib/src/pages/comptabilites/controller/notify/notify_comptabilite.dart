import 'package:get/get.dart';
import 'package:wm_solution/src/api/notifications/comptabilite/balance_notify_api.dart';
import 'package:wm_solution/src/api/notifications/comptabilite/bilan_notify_api.dart';
import 'package:wm_solution/src/api/notifications/comptabilite/compte_resultat_notify_api.dart';
import 'package:wm_solution/src/api/notifications/comptabilite/journal_notify_api.dart';
import 'package:wm_solution/src/api/notifications/departements/comptabilite_departement.dart';
import 'package:wm_solution/src/models/notify/notify_model.dart';
import 'package:wm_solution/src/models/notify/notify_sum_model.dart';

class ComptabiliteNotifyController extends GetxController {
  ComptabiliteDepartementNotifyApi comptabiliteDepartementNotifyApi =
      ComptabiliteDepartementNotifyApi();
  BilanNotifyApi bilanNotifyApi = BilanNotifyApi();
  JournalNotifyApi journalNotifyApi = JournalNotifyApi();
  CompteResultatNotifyApi compteResultatNotifyApi = CompteResultatNotifyApi();
  BalanceNotifyApi balanceNotifyApi = BalanceNotifyApi();

  final _itemCount = '0'.obs;
  String get itemCount => _itemCount.value;

  final _bilanCount = 0.obs;
  int get bilanCount => _bilanCount.value;
  final _compteResultatCount = 0.obs;
  int get compteResultatCount => _compteResultatCount.value;
  final _journalCount = 0.obs;
  int get journalCount => _journalCount.value;
  final _balanceCount = 0.obs;
  int get balanceCount => _balanceCount.value;

  @override
  void onInit() {
    super.onInit();
    getCountComptabilite();
    getCountBilanDD();
    getCountJournalDD();
    getCountCompteResultatDD();
    getCountBalanceDD();
  }

  void getCountComptabilite() async {
    NotifySumModel notifySum =
        await comptabiliteDepartementNotifyApi.getCountComptabilite();
    _itemCount.value = notifySum.sum;
     
  }

  void getCountBilanDD() async {
    NotifyModel notifySum = await bilanNotifyApi.getCountDD();
    _bilanCount.value = notifySum.count;
     
  }

  void getCountJournalDD() async {
    NotifyModel notifySum = await journalNotifyApi.getCountDD();
    _journalCount.value = notifySum.count;
     
  }

  void getCountCompteResultatDD() async {
    NotifyModel notifySum = await compteResultatNotifyApi.getCountDD();
    _compteResultatCount.value = notifySum.count;
     
  }

  void getCountBalanceDD() async {
    NotifyModel notifySum = await balanceNotifyApi.getCountDD();
    _balanceCount.value = notifySum.count;
     
  }
}
