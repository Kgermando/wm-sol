import 'package:get/get.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/balance/balance_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/bilans/bilan_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/compte_resultat/compte_resultat_controller.dart'; 
import 'package:wm_solution/src/pages/comptabilites/controller/journals/journal_livre_controller.dart';

class DashboardComptabiliteController extends GetxController {
  final BalanceController balanceController = Get.put(BalanceController());
  final BilanController bilanController = Get.put(BilanController());
  final CompteResultatController compteResultatController =
      Get.put(CompteResultatController());
  final JournalLivreController journalController = Get.put(JournalLivreController());

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
    getData();
  }

  Future<void> getData() async {
    var bilans = await bilanController.bilanApi.getAllData();
    var journals = await journalController.journalLivreApi.getAllData();
    var balances = await balanceController.balanceCompteApi.getAllData();
    var compteResults = await compteResultatController.compteResultatApi.getAllData();

    _bilanCount.value = bilans
        .where((element) => element.approbationDD == "Approved")
        .length;
   _journalCount.value = journals
        .where((element) => element.approbationDD == "Approved")
        .length;
    _balanceCount.value = balances
        .where((element) =>  element.approbationDD == "Approved")
        .length;
    _compteResultatCount.value = compteResults
        .where((element) => element.approbationDD == "Approved")
        .length;
  }


}