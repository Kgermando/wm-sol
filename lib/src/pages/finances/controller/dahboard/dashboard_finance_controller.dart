import 'package:get/get.dart';
import 'package:wm_solution/src/pages/finances/controller/banques/banque_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/caisses/caisse_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/creance_dettes/creance_dette_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/creances/creance_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/dettes/dette_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/fin_exterieur/fin_exterieur_controller.dart';

class DashboardFinanceController extends GetxController {
  final BanqueController banqueController = Get.put(BanqueController());
  final CaisseController caisseController = Get.put(CaisseController());
  final CreanceController creanceController = Get.put(CreanceController());
  final DetteController detteController = Get.put(DetteController());
  final CreanceDetteController creanceDetteController = Get.put(CreanceDetteController());
  final FinExterieurController finExterieurController = Get.put(FinExterieurController());

  // Banque
  final _recetteBanque = 0.0.obs;
  double get recetteBanque => _recetteBanque.value;

  final _depensesBanque = 0.0.obs;
  double get depensesBanque => _depensesBanque.value;

  final _soldeBanque = 0.0.obs;
  double get soldeBanque => _soldeBanque.value;

  // Caisse
  final _recetteCaisse = 0.0.obs;
  double get recetteCaisse => _recetteCaisse.value;
  final _depensesCaisse = 0.0.obs;
  double get depensesCaisse => _depensesCaisse.value;

  final _soldeCaisse = 0.0.obs;
  double get soldeCaisse => _soldeCaisse.value;

  // Creance
  final _nonPayesCreance = 0.0.obs;
  double get nonPayesCreance => _nonPayesCreance.value;
  final _creancePaiement = 0.0.obs;
  double get creancePaiement => _creancePaiement.value;

  final _soldeCreance = 0.0.obs;
  double get soldeCreance => _soldeCreance.value;

  // Dette
  final _nonPayesDette = 0.0.obs;
  double get nonPayesDette => _nonPayesDette.value;
  final _detteRemboursement = 0.0.obs;
  double get detteRemboursement => _detteRemboursement.value;

  final _soldeDette = 0.0.obs;
  double get soldeDette => _soldeDette.value;

  // FinanceExterieur
  final _cumulFinanceExterieur = 0.0.obs;
  double get cumulFinanceExterieur => _cumulFinanceExterieur.value;

  final _recetteFinanceExterieur = 0.0.obs;
  double get recetteFinanceExterieur => _recetteFinanceExterieur.value;
  final _depenseFinanceExterieur = 0.0.obs;
  double get depenseFinanceExterieur => _depenseFinanceExterieur.value;

  final _soldeFinExterieur = 0.0.obs;
  double get soldeFinExterieur => _soldeFinExterieur.value;

  // Depenses
  final _depenses = 0.0.obs;
  double get depenses => _depenses.value;

  // Disponible
  final _disponible = 0.0.obs;
  double get disponible => _disponible.value;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  void getData() async {
    var dataBanqueList = await banqueController.banqueApi.getAllData();
    var dataCaisseList = await caisseController.caisseApi.getAllData();
    var dataCreanceList = await creanceController.creanceApi.getAllData();
    var dataDetteList = await detteController.detteApi.getAllData();
    var creanceDettes =
        await creanceDetteController.creanceDetteApi.getAllData();
    var dataFinanceExterieurList =
        await finExterieurController.finExterieurApi.getAllData();

    // Banque
    var recetteBanqueList = dataBanqueList
        .where((element) => element.typeOperation == "Depot")
        .toList();
    var depensesBanqueList = dataBanqueList
        .where((element) => element.typeOperation == "Retrait")
        .toList();
    for (var item in recetteBanqueList) {
      _recetteBanque.value += double.parse(item.montantDepot);
    }
    for (var item in depensesBanqueList) {
      _depensesBanque.value += double.parse(item.montantRetrait);
    }
    // Caisse
    var recetteCaisseList = dataCaisseList
        .where((element) => element.typeOperation == "Encaissement")
        .toList();
    var depensesCaisseList = dataCaisseList
        .where((element) => element.typeOperation == "Decaissement")
        .toList();
    for (var item in recetteCaisseList) {
      _recetteCaisse.value += double.parse(item.montantEncaissement);
    }
    for (var item in depensesCaisseList) {
      _depensesCaisse.value += double.parse(item.montantDecaissement);
    }

    // Creance remboursement
    var creancePaiementList =
        creanceDettes.where((element) => element.creanceDette == 'creances');

    var nonPayeCreanceList = dataCreanceList
        .where((element) =>
            element.statutPaie == 'false' &&
            element.approbationDG == 'Approved' &&
            element.approbationDD == 'Approved')
        .toList();

    for (var item in nonPayeCreanceList) {
      _nonPayesCreance.value += double.parse(item.montant);
    }
    for (var item in creancePaiementList) {
      _creancePaiement.value += double.parse(item.montant);
    }

    // Dette paiement
    var detteRemboursementList =
        creanceDettes.where((element) => element.creanceDette == 'dettes');
    var nonPayeDetteList = dataDetteList
        .where((element) =>
            element.statutPaie == 'false' &&
            element.approbationDG == 'Approved' &&
            element.approbationDD == 'Approved')
        .toList();
    for (var item in nonPayeDetteList) {
      _nonPayesDette.value += double.parse(item.montant);
    }
    for (var item in detteRemboursementList) {
      _detteRemboursement.value += double.parse(item.montant);
    }

    // Fin interne actionnaire
    // for (var item in actionnaireCotisationList) {
    //   actionnaire += double.parse(item.montant);
    // }

    // FinanceExterieur
    var recetteFinExtList = dataFinanceExterieurList
        .where((element) => element.typeOperation == "Depot")
        .toList();

    for (var item in recetteFinExtList) {
      _recetteFinanceExterieur.value += double.parse(item.montantDepot);
    }
    var depenseFinExtList = dataFinanceExterieurList
        .where((element) => element.typeOperation == "Retrait")
        .toList();
    for (var item in depenseFinExtList) {
      _depenseFinanceExterieur.value += double.parse(item.montantRetrait);
    }

    _soldeCreance.value = nonPayesCreance - creancePaiement;
    _soldeDette.value = nonPayesDette - detteRemboursement;

    _soldeBanque.value = recetteBanque - depensesBanque;
    _soldeCaisse.value = recetteCaisse - depensesCaisse;
    _soldeFinExterieur.value =
        recetteFinanceExterieur - depenseFinanceExterieur;

    // _cumulFinanceExterieur.value = actionnaire + soldeFinExterieur;
    _cumulFinanceExterieur.value = soldeFinExterieur;
    _depenses.value = depensesBanque + depensesCaisse + depenseFinanceExterieur;
    _disponible.value =
        soldeBanque + soldeCaisse + cumulFinanceExterieur; // Montant disponible

    update();
  }
}
