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
import 'package:wm_solution/src/pages/commercial_marketing/controller/marketing/compaigns/compaign_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/bilans/bilan_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/journals/journal_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/journals/journal_livre_controller.dart';
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
    final PersonnelsController personnelsController = Get.put(PersonnelsController());
    final SalaireController salaireController = Get.put(SalaireController());
    final TransportRestController transportRestController =
        Get.put(TransportRestController());
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
    final JournalLivreController journalLivreController = Get.put(JournalLivreController()); 
    final JournalController journalController = Get.put(JournalController()); 

    // Finances
     final BanqueController banqueController = Get.put(BanqueController());
     final CaisseController caisseController = Get.put(CaisseController());
     final CreanceController creanceController = Get.put(CreanceController());
     final DetteController detteController = Get.put(DetteController());
     final CreanceDetteController creanceDetteController = Get.put(CreanceDetteController());
     final FinExterieurController finExterieurController = Get.put(FinExterieurController());

    // var actionnaireCotisationList = await ActionnaireCotisationApi().getAllData();

  
  var ligneBudgetaireList = <LigneBudgetaireModel>[].obs;
  var dataCampaignList = <CampaignModel>[].obs;
  var dataDevisList = <DevisModel>[].obs;
  var devisListObjetsList = <DevisListObjetsModel>[].obs; // avec montant
  var dataProjetList = <ProjetModel>[].obs;
  var dataSalaireList = <PaiementSalaireModel>[].obs;
  var dataTransRestList = <TransportRestaurationModel>[].obs;
  var tansRestAgentList = <TransRestAgentsModel>[].obs; // avec montant
  var departementsList = <DepartementBudgetModel>[].obs;

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

  @override
  void refresh() {
    getData();
    super.refresh();
  }

  Future<void> getData() async {
   
    _agentsCount.value = personnelsController.personnelsList.length;
    _agentActifCount.value =
        personnelsController.personnelsList
        .where((element) => element.statutAgent == 'true').length;

    // Exploitations
    projetsApprouveCount = projetController.projetList
        .where((element) =>
            element.approbationDG == 'Approved' &&
            element.approbationDD == 'Approved')
        .length;

    // Comm & Marketing
    campaignCount = campaignController.campaignList
        .where((element) =>
            element.approbationDG == 'Approved' &&
            element.approbationDD == 'Approved')
        .length;

    // Budgets
    devisListObjetsList = devisListObjetController.devisListObjetList;
    tansRestAgentList = transportRestPersonnelsController.transRestAgentList;
    departementsList.assignAll(budgetPrevisionnelController.departementBudgetList
        .where((element) =>
            element.approbationDG == 'Approved' &&
            element.approbationDD == 'Approved' &&
            DateTime.now().isBefore(element.periodeFin))
        .toList()); 

    for (var i in departementsList) {
      ligneBudgetaireList.assignAll(lignBudgetaireController.ligneBudgetaireList
          .where((element) =>
              element.periodeBudgetDebut.microsecondsSinceEpoch ==
                  i.periodeDebut.microsecondsSinceEpoch &&
              DateTime.now().isBefore(element.periodeBudgetFin) &&
              i.approbationDG == "Approved" &&
              i.approbationDD == "Approved")
          .toList());
    }

    for (var item in ligneBudgetaireList) {
      dataCampaignList.assignAll(campaignController.campaignList
          .where((element) =>
              element.approbationDG == 'Approved' &&
              element.approbationDD == 'Approved' &&
              element.approbationBudget == 'Approved' &&
              element.observation == 'true' &&
              element.created.isBefore(item.periodeBudgetFin))
          .toList());
      dataDevisList.assignAll(devisController.devisList
          .where((element) =>
              element.approbationDG == 'Approved' &&
              element.approbationDD == 'Approved' &&
              element.approbationBudget == 'Approved' &&
              element.observation == 'true' &&
              element.created.isBefore(item.periodeBudgetFin))
          .toList());
      dataProjetList.assignAll(projetController.projetList
          .where((element) =>
              element.approbationDG == 'Approved' &&
              element.approbationDD == 'Approved' &&
              element.approbationBudget == 'Approved' &&
              element.observation == 'true' &&
              element.created.isBefore(item.periodeBudgetFin))
          .toList());
      dataSalaireList.assignAll(salaireController.paiementSalaireList
          .where((element) =>
              element.createdAt.month == DateTime.now().month &&
              element.createdAt.year == DateTime.now().year &&
              element.approbationDD == 'Approved' &&
              element.approbationBudget == 'Approved' &&
              element.observation == 'true' &&
              element.createdAt.isBefore(item.periodeBudgetFin))
          .toList());
      dataTransRestList.assignAll(transportRestController.transportRestaurationList
          .where((element) =>
              element.approbationDG == 'Approved' &&
              element.approbationDD == 'Approved' &&
              element.approbationBudget == 'Approved' &&
              element.observation == 'true' &&
              element.created.isBefore(item.periodeBudgetFin))
          .toList());
    }

    // Comptabilite
    bilanCount = bilanController.bilanList
        .where((element) => element.approbationDD == 'Approved').length;

    for (var journal in journalLivreController.journalLivreList
        .where((element) => element.approbationDD == 'Approved')) {
      journalCount = journalController.journalList
        .where((element) => element.reference == journal.id).length;
    }
    

    // FINANCE
    // Banque
    var recetteBanqueList = banqueController.banqueList
        .where((element) => element.typeOperation == "Depot")
        .toList();
    var depensesBanqueList = banqueController.banqueList
        .where((element) => element.typeOperation == "Retrait")
        .toList();
    for (var item in recetteBanqueList) {
      recetteBanque += double.parse(item.montant);
    }
    for (var item in depensesBanqueList) {
      depensesBanque += double.parse(item.montant);
    }
    // Caisse
    var recetteCaisseList = caisseController.caisseList
        .where((element) => element.typeOperation == "Encaissement")
        .toList();
    var depensesCaisseList = caisseController.caisseList
        .where((element) => element.typeOperation == "Decaissement")
        .toList();
    for (var item in recetteCaisseList) {
      recetteCaisse += double.parse(item.montant);
    }
    for (var item in depensesCaisseList) {
      depensesCaisse += double.parse(item.montant);
    }

    // Creance remboursement
    var creancePaiementList =
        creanceDetteController.creanceDetteList.where((element) => element.creanceDette == 'creances');

    // Creance
    var nonPayeCreanceList = creanceController.creanceList
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
        creanceDetteController.creanceDetteList
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
    var recetteFinExtList = finExterieurController.finExterieurList
        .where((element) => element.typeOperation == "Depot")
        .toList();

    for (var item in recetteFinExtList) {
      recetteFinanceExterieur += double.parse(item.montant);
    }
    var depenseFinExtList = finExterieurController.finExterieurList
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
          .where((element) => element.reference == item.id).toList();
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
          .where((element) =>
              element.reference == item.id)
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
  }

   
}
