import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/models/budgets/departement_budget_model.dart';
import 'package:wm_solution/src/models/budgets/ligne_budgetaire_model.dart';
import 'package:wm_solution/src/models/comm_maketing/campaign_model.dart';
import 'package:wm_solution/src/models/devis/devis_list_objets_model.dart';
import 'package:wm_solution/src/models/devis/devis_models.dart';
import 'package:wm_solution/src/models/exploitations/projet_model.dart';
import 'package:wm_solution/src/models/rh/paiement_salaire_model.dart';
import 'package:wm_solution/src/models/rh/transport_restauration_model.dart';
import 'package:wm_solution/src/pages/budgets/controller/budget_previsionnel_controller.dart';
import 'package:wm_solution/src/pages/budgets/controller/ligne_budgetaire_controller.dart';
import 'package:wm_solution/src/pages/commercial_marketing/controller/compaigns/compaign_controller.dart';
import 'package:wm_solution/src/pages/devis/controller/devis_controller.dart';
import 'package:wm_solution/src/pages/devis/controller/devis_list_objet_controller.dart';
import 'package:wm_solution/src/pages/exploitations/controller/projets/projet_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/salaires/salaire_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/transport_rest/transport_rest_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/transport_rest/transport_rest_person_controller.dart';

class DashboardBudgetController extends GetxController {
  final BudgetPrevisionnelController budgetPrevisionnelController =
      Get.put(BudgetPrevisionnelController());
  final LignBudgetaireController lignBudgetaireController =
      Get.put(LignBudgetaireController());
  final SalaireController salaireController = Get.put(SalaireController());
  final TransportRestController transportRestController =
      Get.put(TransportRestController());
  final TransportRestPersonnelsController transportRestPersonnelsController =
      Get.put(TransportRestPersonnelsController());
  final ProjetController projetController = Get.put(ProjetController());
  final CampaignController campaignController = Get.put(CampaignController());
  final DevisController devisController = Get.put(DevisController());
  final DevisListObjetController devisListObjetController =
      Get.put(DevisListObjetController());
 
  final ScrollController controllerTable = ScrollController();
  
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

  // Campaigns
  double caisseCampaign = 0.0;
  double banqueCampaign = 0.0;
  double finExterieurCampaign = 0.0;
  // Etat de besoins
  double caisseEtatBesion = 0.0;
  double banqueEtatBesion = 0.0;
  double finExterieurEtatBesion = 0.0;
  // Exploitations
  double caisseProjet = 0.0;
  double banqueProjet = 0.0;
  double finExterieurProjet = 0.0;
  // Salaires
  double caisseSalaire = 0.0;
  double banqueSalaire = 0.0;
  double finExterieurSalaire = 0.0;
  // Transports & Restaurations
  double caisseTransRest = 0.0;
  double banqueTransRest = 0.0;
  double finExterieurTransRest = 0.0;


  var departementsList = <DepartementBudgetModel>[].obs;
  var ligneBudgetaireList = <LigneBudgetaireModel>[].obs;
  var dataCampaignList = <CampaignModel>[].obs;
  var dataDevisList = <DevisModel>[].obs;
  var devisListObjetsList = <DevisListObjetsModel>[].obs; // avec montant
  var dataProjetList = <ProjetModel>[].obs;
  var dataSalaireList = <PaiementSalaireModel>[].obs;
  var dataTransRestList = <TransportRestaurationModel>[].obs;
  var tansRestList = <TransRestAgentsModel>[].obs; // avec montant


  @override
  void onInit() {
    super.onInit();
    getData();  
  }

  Future<void> getData() async {
    var departements = await budgetPrevisionnelController.depeartementBudgetApi.getAllData();
    var budgets = await lignBudgetaireController.lIgneBudgetaireApi.getAllData();
    var campaigns = await campaignController.campaignApi.getAllData();
    var projets = await projetController.projetsApi.getAllData();
    var salaires = await salaireController.paiementSalaireApi.getAllData();
    var transRests = await transportRestController.transportRestaurationApi.getAllData();
    var transRestAgents = await
        transportRestPersonnelsController.transRestAgentsApi.getAllData();
    var devis = await devisController.devisAPi.getAllData();
    var devisListObjets = await devisListObjetController.devisListObjetsApi.getAllData();
    
  
    departementsList.assignAll(departements); 
    devisListObjetsList.assignAll(devisListObjets); 
    tansRestList.assignAll(transRestAgents);  

      for (var i in departementsList) {
        ligneBudgetaireList.assignAll(budgets
            .where((element) =>
                element.periodeBudgetDebut.microsecondsSinceEpoch ==
                    i.periodeDebut.microsecondsSinceEpoch &&
                DateTime.now().isBefore(element.periodeBudgetFin) &&
                i.approbationDG == "Approved" &&
                i.approbationDD == "Approved")
            .toList());
      }

      for (var item in ligneBudgetaireList) {
        dataCampaignList.assignAll(campaigns
            .where((element) =>
                element.approbationDG == 'Approved' &&
                element.approbationDD == 'Approved' &&
                element.approbationBudget == 'Approved' &&
                element.observation == 'true' &&
                element.created.isBefore(item.periodeBudgetFin))
            .toList());

        dataDevisList.assignAll(devis
            .where((element) =>
                element.approbationDG == 'Approved' &&
                element.approbationDD == 'Approved' &&
                element.approbationBudget == 'Approved' &&
                element.observation == 'true' &&
                element.created.isBefore(item.periodeBudgetFin))
            .toList());
        dataProjetList.assignAll(projets
            .where((element) =>
                element.approbationDG == 'Approved' &&
                element.approbationDD == 'Approved' &&
                element.approbationBudget == 'Approved' &&
                element.observation == 'true' &&
                element.created.isBefore(item.periodeBudgetFin))
            .toList())    ;
        dataSalaireList.assignAll(salaires
            .where((element) =>
                element.createdAt.month == DateTime.now().month &&
                element.createdAt.year == DateTime.now().year &&
                element.approbationDD == 'Approved' &&
                element.approbationBudget == 'Approved' &&
                element.observation == 'true' &&
                element.createdAt.isBefore(item.periodeBudgetFin))
            .toList())   ;
        dataTransRestList.assignAll(transRests
            .where((element) =>
                element.approbationDG == 'Approved' &&
                element.approbationDD == 'Approved' &&
                element.approbationBudget == 'Approved' &&
                element.observation == 'true' &&
                element.created.isBefore(item.periodeBudgetFin))
            .toList());
      } 

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
      var devisCaisseList = tansRestList
          .where((element) =>
              element.reference ==
              item.id)
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

    // Caisse
    for (var item in dataCampaignList
        .where((element) => element.ressource == "caisse")
        .toList()) {
      caisseCampaign += double.parse(item.coutCampaign);
    }
    for (var item in dataDevisList.where((e) => e.ressource == "caisse")) {
      var devisCaisseList = devisListObjetsList
          .where((element) =>
              element.reference == item.id)
          .toList();
      for (var element in devisCaisseList) {
        caisseEtatBesion += double.parse(element.montantGlobal);
      }
    }
    for (var item in dataProjetList
        .where((element) => element.ressource == "caisse")
        .toList()) {
      caisseProjet += double.parse(item.coutProjet);
    }
    for (var item in dataSalaireList
        .where((element) => element.ressource == "caisse")
        .toList()) {
      caisseSalaire += double.parse(item.salaire);
    }
    for (var item in dataTransRestList.where((e) => e.ressource == "caisse")) {
      var devisCaisseList = tansRestList
          .where((element) =>
              element.reference == item.id)
          .toList();
      for (var element in devisCaisseList) {
        caisseTransRest += double.parse(element.montant);
      }
    }

    // Banque
    for (var item in dataCampaignList
        .where((element) => element.ressource == "banque")
        .toList()) {
      banqueCampaign += double.parse(item.coutCampaign);
    }
    for (var item in dataDevisList.where((e) => e.ressource == "banque")) {
      var devisCaisseList = devisListObjetsList
          .where((element) =>
              element.reference == item.id)
          .toList();
      for (var element in devisCaisseList) {
        banqueEtatBesion += double.parse(element.montantGlobal);
      }
    }
    for (var item in dataProjetList
        .where((element) => element.ressource == "banque")
        .toList()) {
      banqueProjet += double.parse(item.coutProjet);
    }
    for (var item in dataSalaireList
        .where((element) => element.ressource == "banque")
        .toList()) {
      banqueSalaire += double.parse(item.salaire);
    }
    for (var item in dataTransRestList.where((e) => e.ressource == "banque")) {
      var devisCaisseList = tansRestList
          .where((element) =>
              element.reference == item.id)
          .toList();
      for (var element in devisCaisseList) {
        banqueTransRest += double.parse(element.montant);
      }
    }

    // Fin Exterieur
    for (var item in dataCampaignList
        .where((element) => element.ressource == "finExterieur")
        .toList()) {
      finExterieurCampaign += double.parse(item.coutCampaign);
    }
    for (var item
        in dataDevisList.where((e) => e.ressource == "finExterieur")) {
      var devisCaisseList = devisListObjetsList
          .where((element) =>
              element.reference == item.id)
          .toList();
      for (var element in devisCaisseList) {
        finExterieurEtatBesion += double.parse(element.montantGlobal);
      }
    }
    for (var item in dataProjetList
        .where((element) => element.ressource == "finExterieur")
        .toList()) {
      finExterieurProjet += double.parse(item.coutProjet);
    }
    for (var item in dataSalaireList
        .where((element) => element.ressource == "finExterieur")
        .toList()) {
      finExterieurSalaire += double.parse(item.salaire);
    }
    for (var item
        in dataTransRestList.where((e) => e.ressource == "finExterieur")) {
      var devisCaisseList = tansRestList
          .where((element) =>
              element.reference == item.id)
          .toList();
      for (var element in devisCaisseList) {
        finExterieurTransRest += double.parse(element.montant);
      }
    }
  }


}