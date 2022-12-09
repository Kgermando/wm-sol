import 'package:get/get.dart';
import 'package:wm_solution/src/models/budgets/ligne_budgetaire_model.dart'; 
import 'package:wm_solution/src/pages/budgets/controller/budget_previsionnel_controller.dart';
import 'package:wm_solution/src/pages/budgets/controller/ligne_budgetaire_controller.dart';
import 'package:wm_solution/src/pages/marketing/controller/campaigns/compaign_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/bilans/bilan_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/journals/journal_controller.dart';
import 'package:wm_solution/src/pages/devis/controller/devis_controller.dart';
import 'package:wm_solution/src/pages/devis/controller/devis_list_objet_controller.dart';
import 'package:wm_solution/src/pages/exploitations/controller/projets/projet_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/banques/banque_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/caisses/caisse_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/creance_dettes/creance_dette_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/creances/creance_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/dettes/dette_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/fin_exterieur/fin_exterieur_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/personnels/personnels_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/salaires/salaire_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/transport_rest/transport_rest_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/transport_rest/transport_rest_person_controller.dart';

class AdminDashboardController extends GetxController {

  // RH
  final PersonnelsController personnelsController = Get.put(PersonnelsController());
  final SalaireController salaireController = Get.put(SalaireController());
  final TransportRestController transportRestController = Get.put(TransportRestController());
  final TransportRestPersonnelsController transportRestPersonnelsController =
      Get.put(TransportRestPersonnelsController());

  // Budgets
  final BudgetPrevisionnelController budgetPrevisionnelController = Get.put(BudgetPrevisionnelController());
  final LignBudgetaireController lignBudgetaireController = Get.put(LignBudgetaireController());

  // Comm & Marketing
  final CampaignController campaignController = Get.put(CampaignController());

  // Logistique
  final DevisController devisController = Get.put(DevisController());
  final DevisListObjetController devisListObjetController = Get.put(DevisListObjetController());

  // Exploitation
  final ProjetController projetController = Get.put(ProjetController());

  // Comptabilite
  final BilanController bilanController = Get.put(BilanController());
  final JournalController journalController = Get.put(JournalController());

  // Finances
  final BanqueController banqueController = Get.put(BanqueController());
  final CaisseController caisseController = Get.put(CaisseController());
  final CreanceController creanceController = Get.put(CreanceController());
  final DetteController detteController = Get.put(DetteController());
  final CreanceDetteController creanceDetteController = Get.put(CreanceDetteController());
  final FinExterieurController finExterieurController = Get.put(FinExterieurController());

  // var actionnaireCotisationList = await ActionnaireCotisationApi().getAllData();

  List<LigneBudgetaireModel> ligneBudgetaireList = [];

  // RH
  final _agentsCount = 0.obs;
  int get agentsCount => _agentsCount.value;

  final _agentActifCount = 0.obs;
  int get agentActifCount => _agentActifCount.value;

  // Budgets
  double coutTotal = 0.0;
  double poursentExecutionTotal = 0.0;
  double poursentExecution = 0.0;
  double caisseSolde = 0.0;
  double banqueSolde = 0.0;
  double finExterieurSolde = 0.0;

  double caisse = 0.0;
  double banque = 0.0;
  double finExterieur = 0.0;
  double caisseSortie = 0.0;
  double banqueSortie = 0.0;
  double finExterieurSortie = 0.0;

  // Comptabilite
  int bilanCount = 0;

  // Finance
  double depenses = 0.0;
  double disponible = 0.0;
  double recetteBanque = 0.0;
  double depensesBanque = 0.0;
  double soldeBanque = 0.0;
  double recetteCaisse = 0.0;
  double depensesCaisse = 0.0;
  double soldeCaisse = 0.0;
  double nonPayesCreance = 0.0;
  double creancePaiement = 0.0;
  double soldeCreance = 0.0;
  double nonPayesDette = 0.0;
  double detteRemboursement = 0.0;
  double soldeDette = 0.0;
  double cumulFinanceExterieur = 0.0;
  double actionnaire = 0.0;
  double recetteFinanceExterieur = 0.0;
  double depenseFinanceExterieur = 0.0;
  double soldeFinExterieur = 0.0;

  // Exploitations
  int projetsApprouveCount = 0;

  // Campaigns
  int campaignCount = 0;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> getData() async {
    var personnels = await personnelsController.personnelsApi.getAllData();
    _agentsCount.value = personnels.length;

    _agentActifCount.value =
        personnels.where((element) => element.statutAgent == 'Actif').length;

    // Exploitations
    var projets = await projetController.projetsApi.getAllData();
    projetsApprouveCount = projets
        .where((element) =>
            element.approbationDG == 'Approved' &&
            element.approbationDD == 'Approved' &&
            element.approbationBudget == 'Approved' &&
            element.approbationFin == 'Approved')
        .length;

    // Comm & Marketing
    var campaigns = await campaignController.campaignApi.getAllData();
    campaignCount = campaigns
        .where((element) =>
            element.approbationDG == 'Approved' &&
            element.approbationDD == 'Approved' &&
            element.approbationBudget == 'Approved' &&
            element.approbationFin == 'Approved')
        .length;

    // Budgets
    ligneBudgetaireList = lignBudgetaireController.ligneBudgetaireList
        .where((element) => DateTime.now().isBefore(element.periodeBudgetFin))
        .toList();
 
    for (var element in ligneBudgetaireList) {
      coutTotal += double.parse(element.coutTotal);
      caisse += double.parse(element.caisse);
      banque += double.parse(element.banque);
      finExterieur += double.parse(element.finExterieur);
      caisseSortie += element.caisseSortie;
      banqueSortie += element.banqueSortie;
      finExterieurSortie += element.finExterieurSortie;
    }

    caisseSolde = caisse - caisseSortie;
    banqueSolde = banque - banqueSortie;
    finExterieurSolde = finExterieur - finExterieurSortie;

    poursentExecutionTotal =
        (caisseSolde + banqueSolde + finExterieurSolde) * 100 / coutTotal;
    poursentExecution = 100 - poursentExecutionTotal;


    // Comptabilite
    var bilans = await bilanController.bilanApi.getAllData();
    bilanCount =
        bilans.where((element) => element.approbationDD == 'Approved').length;

    // FINANCE
    // Banque
    var banques = await banqueController.banqueApi.getAllData();
    var recetteBanqueList =
        banques.where((element) => element.typeOperation == "Depot").toList();
    var depensesBanqueList =
        banques.where((element) => element.typeOperation == "Retrait").toList();
    for (var item in recetteBanqueList) {
      recetteBanque += double.parse(item.montantDepot);
    }
    for (var item in depensesBanqueList) {
      depensesBanque += double.parse(item.montantRetrait);
    }
    // Caisse
    var caisses = await caisseController.caisseApi.getAllData();
    var recetteCaisseList = caisses
        .where((element) => element.typeOperation == "Encaissement")
        .toList();
    var depensesCaisseList = caisses
        .where((element) => element.typeOperation == "Decaissement")
        .toList();
    for (var item in recetteCaisseList) {
      recetteCaisse += double.parse(item.montantEncaissement);
    }
    for (var item in depensesCaisseList) {
      depensesCaisse += double.parse(item.montantDecaissement);
    }

    // Creance remboursement
    var creanceDettes =
        await creanceDetteController.creanceDetteApi.getAllData();
    var creancePaiementList =
        creanceDettes.where((element) => element.creanceDette == 'creances');

    // Creance
    var creances = await creanceController.creanceApi.getAllData();
    var nonPayeCreanceList = creances
        .where((element) =>
            element.statutPaie == 'false' &&
            element.approbationDG == 'Approved' &&
            element.approbationDD == 'Approved')
        .toList();

    for (var item in nonPayeCreanceList) {
      nonPayesCreance += double.parse(item.montant);
    }
    for (var item in creancePaiementList) {
      creancePaiement += double.parse(item.montant);
    }

    // Dette paiement
    var detteRemboursementList =
        creanceDettes.where((element) => element.creanceDette == 'dettes');
    var nonPayeDetteList = detteController.detteList
        .where((element) =>
            element.statutPaie == 'false' &&
            element.approbationDG == 'Approved' &&
            element.approbationDD == 'Approved')
        .toList();
    for (var item in nonPayeDetteList) {
      nonPayesDette += double.parse(item.montant);
    }
    for (var item in detteRemboursementList) {
      detteRemboursement += double.parse(item.montant);
    }

    // Fin interne actionnaire
    // for (var item in actionnaireCotisationList) {
    //   actionnaire += double.parse(item.montant);
    // }

    // FinanceExterieur
    var finExterieurs =
        await finExterieurController.finExterieurApi.getAllData();
    var recetteFinExtList = finExterieurs
        .where((element) => element.typeOperation == "Depot")
        .toList();

    for (var item in recetteFinExtList) {
      recetteFinanceExterieur += double.parse(item.montantDepot);
    }
    var depenseFinExtList = finExterieurs
        .where((element) => element.typeOperation == "Retrait")
        .toList();
    for (var item in depenseFinExtList) {
      depenseFinanceExterieur += double.parse(item.montantRetrait);
    }

    soldeCreance = nonPayesCreance - creancePaiement;
    soldeDette = nonPayesDette - detteRemboursement;

    soldeBanque = recetteBanque - depensesBanque;
    soldeCaisse = recetteCaisse - depensesCaisse;
    soldeFinExterieur = recetteFinanceExterieur - depenseFinanceExterieur;

    cumulFinanceExterieur = actionnaire + soldeFinExterieur;
    depenses = depensesBanque + depensesCaisse + depenseFinanceExterieur;
    disponible = soldeBanque + soldeCaisse + cumulFinanceExterieur;

    update();
  }
}
