import 'package:get/get.dart';
import 'package:wm_solution/src/models/budgets/departement_budget_model.dart';
import 'package:wm_solution/src/models/budgets/ligne_budgetaire_model.dart';
import 'package:wm_solution/src/models/comm_maketing/campaign_model.dart';
import 'package:wm_solution/src/models/devis/devis_list_objets_model.dart';
import 'package:wm_solution/src/models/devis/devis_models.dart';
import 'package:wm_solution/src/models/exploitations/projet_model.dart';
import 'package:wm_solution/src/models/rh/paiement_salaire_model.dart';
import 'package:wm_solution/src/models/rh/transport_restauration_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
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
  final ProfilController profilController = Get.find();

  // RH
  final PersonnelsController personnelsController = Get.find();
  final SalaireController salaireController = Get.find();
  final TransportRestController transportRestController = Get.find();
  final TransportRestPersonnelsController transportRestPersonnelsController =
      Get.find();

  // Budgets
  final BudgetPrevisionnelController budgetPrevisionnelController = Get.find();
  final LignBudgetaireController lignBudgetaireController = Get.find();

  // Comm & Marketing
  final CampaignController campaignController = Get.find();

  // Logistique
  final DevisController devisController = Get.find();
  final DevisListObjetController devisListObjetController = Get.find();

  // Exploitation
  final ProjetController projetController = Get.find();

  // Comptabilite
  final BilanController bilanController = Get.find();
  final JournalController journalController = Get.find();

  // Finances
  final BanqueController banqueController = Get.find();
  final CaisseController caisseController = Get.find();
  final CreanceController creanceController = Get.find();
  final DetteController detteController = Get.find();
  final CreanceDetteController creanceDetteController = Get.find();
  final FinExterieurController finExterieurController = Get.find();

  // var actionnaireCotisationList = await ActionnaireCotisationApi().getAllData();

  List<LigneBudgetaireModel> ligneBudgetaireList = [];
  List<CampaignModel> dataCampaignList = [];
  List<DevisModel> dataDevisList = [];
  List<DevisListObjetsModel> devisListObjetsList = []; // avec montant
  List<ProjetModel> dataProjetList = [];
  List<PaiementSalaireModel> dataSalaireList = [];
  List<TransportRestaurationModel> dataTransRestList = [];
  List<TransRestAgentsModel> tansRestAgentList = []; // avec montant
  List<DepartementBudgetModel> departementsList = [];

  // RH
  final _agentsCount = 0.obs;
  int get agentsCount => _agentsCount.value;

  final _agentActifCount = 0.obs;
  int get agentActifCount => _agentActifCount.value;

  // Budgets
  double coutTotal = 0.0;
  double sommeEnCours = 0.0; // cest la somme des 4 departements
  double sommeRestantes =
      0.0; // la somme restante apres la soustration entre coutTotal - sommeEnCours
  double poursentExecution = 0;
  // Total par departements
  double totalCampaign = 0.0;
  double totalProjet = 0.0;
  double totalSalaire = 0.0;
  double totalDevis = 0.0;
  double totalTransRest = 0.0;

  // Comptabilite
  int bilanCount = 0;
  int journalCount = 0;

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
        personnels.where((element) => element.statutAgent == 'true').length;

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
    devisListObjetsList =
        await devisListObjetController.devisListObjetsApi.getAllData();
    tansRestAgentList =
        await transportRestPersonnelsController.transRestAgentsApi.getAllData();
    var departementBudgetList =
        await budgetPrevisionnelController.depeartementBudgetApi.getAllData();
    departementsList = departementBudgetList
        .where((element) =>
            element.approbationDG == 'Approved' &&
            element.approbationDD == 'Approved' &&
            DateTime.now().isBefore(element.periodeFin))
        .toList();

    for (var i in departementsList) {
      var ligneBudgetaire =
          await lignBudgetaireController.lIgneBudgetaireApi.getAllData();
      ligneBudgetaireList = ligneBudgetaire
          .where((element) =>
              element.periodeBudgetDebut.microsecondsSinceEpoch ==
                  i.periodeDebut.microsecondsSinceEpoch &&
              DateTime.now().isBefore(element.periodeBudgetFin) &&
              i.approbationDG == "Approved" &&
              i.approbationDD == "Approved")
          .toList();
    }

    for (var item in ligneBudgetaireList) {
      var campaigns = await campaignController.campaignApi.getAllData();
      dataCampaignList = campaigns
          .where((element) =>
              element.approbationDG == 'Approved' &&
              element.approbationDD == 'Approved' &&
              element.approbationBudget == 'Approved' &&
              element.observation == 'true' &&
              element.created.isBefore(item.periodeBudgetFin))
          .toList();
      var devis = await devisController.devisAPi.getAllData();
      dataDevisList = devis
          .where((element) =>
              element.approbationDG == 'Approved' &&
              element.approbationDD == 'Approved' &&
              element.approbationBudget == 'Approved' &&
              element.observation == 'true' &&
              element.created.isBefore(item.periodeBudgetFin))
          .toList();
      var projets = await projetController.projetsApi.getAllData();
      dataProjetList = projets
          .where((element) =>
              element.approbationDG == 'Approved' &&
              element.approbationDD == 'Approved' &&
              element.approbationBudget == 'Approved' &&
              element.observation == 'true' &&
              element.created.isBefore(item.periodeBudgetFin))
          .toList();
      var salaires = await salaireController.paiementSalaireApi.getAllData();
      dataSalaireList = salaires
          .where((element) =>
              element.createdAt.month == DateTime.now().month &&
              element.createdAt.year == DateTime.now().year &&
              element.approbationDD == 'Approved' &&
              element.approbationBudget == 'Approved' &&
              element.approbationFin == 'Approved' &&
              element.observation == 'true' &&
              element.createdAt.isBefore(item.periodeBudgetFin))
          .toList();
      var transportRestaurations = await transportRestController
        .transportRestaurationApi.getAllData();
      dataTransRestList = transportRestaurations
          .where((element) =>
              element.approbationDG == 'Approved' &&
              element.approbationDD == 'Approved' &&
              element.approbationBudget == 'Approved' &&
              element.approbationFin == 'Approved' &&
              element.observation == 'true' &&
              element.created.isBefore(item.periodeBudgetFin))
          .toList();
    }

    // Comptabilite
    var bilans = await bilanController.bilanApi.getAllData();
    bilanCount = bilans
        .where((element) => element.approbationDD == 'Approved')
        .length;

    // FINANCE
    // Banque
    var banques = await banqueController.banqueApi.getAllData();
    var recetteBanqueList = banques
        .where((element) => element.typeOperation == "Depot")
        .toList();
    var depensesBanqueList = banques
        .where((element) => element.typeOperation == "Retrait")
        .toList();
    for (var item in recetteBanqueList) {
      recetteBanque += double.parse(item.montant);
    }
    for (var item in depensesBanqueList) {
      depensesBanque += double.parse(item.montant);
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
      recetteCaisse += double.parse(item.montant);
    }
    for (var item in depensesCaisseList) {
      depensesCaisse += double.parse(item.montant);
    }

    // Creance remboursement
    var creanceDettes = await creanceDetteController.creanceDetteApi.getAllData();
    var creancePaiementList = creanceDettes
        .where((element) => element.creanceDette == 'creances');

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
    var detteRemboursementList = creanceDettes
        .where((element) => element.creanceDette == 'dettes');
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
    var finExterieurs = await finExterieurController.finExterieurApi.getAllData();
    var recetteFinExtList = finExterieurs
        .where((element) => element.typeOperation == "Depot")
        .toList();

    for (var item in recetteFinExtList) {
      recetteFinanceExterieur += double.parse(item.montant);
    }
    var depenseFinExtList = finExterieurs
        .where((element) => element.typeOperation == "Retrait")
        .toList();
    for (var item in depenseFinExtList) {
      depenseFinanceExterieur += double.parse(item.montant);
    }

    soldeCreance = nonPayesCreance - creancePaiement;
    soldeDette = nonPayesDette - detteRemboursement;

    soldeBanque = recetteBanque - depensesBanque;
    soldeCaisse = recetteCaisse - depensesCaisse;
    soldeFinExterieur = recetteFinanceExterieur - depenseFinanceExterieur;

    cumulFinanceExterieur = actionnaire + soldeFinExterieur;
    depenses = depensesBanque + depensesCaisse + depenseFinanceExterieur;
    disponible = soldeBanque + soldeCaisse + cumulFinanceExterieur;

    // Budget
    for (var item in ligneBudgetaireList) {
      coutTotal += double.parse(item.coutTotal);
    }

    for (var item in dataCampaignList) {
      totalCampaign += double.parse(item.coutCampaign);
    }
    for (var item in dataDevisList) {
      var devisCaisseList = devisListObjetsList
          .where((element) => element.reference == item.id)
          .toList();
      for (var element in devisCaisseList) {
        totalDevis += double.parse(element.montantGlobal);
      }
    }
    for (var item in dataProjetList) {
      totalProjet += double.parse(item.coutProjet);
    }
    for (var item in dataSalaireList) {
      totalSalaire += double.parse(item.salaire);
    }
    for (var item in dataTransRestList) {
      var devisCaisseList = tansRestAgentList
          .where((element) => element.reference == item.id)
          .toList();
      for (var element in devisCaisseList) {
        totalTransRest += double.parse(element.montant);
      }
    }
    // Sommes budgets
    sommeEnCours = totalCampaign +
        totalDevis +
        totalProjet +
        totalSalaire +
        totalTransRest;
    sommeRestantes = coutTotal - sommeEnCours;
    poursentExecution = sommeRestantes * 100 / coutTotal;

    update();
  }
}
