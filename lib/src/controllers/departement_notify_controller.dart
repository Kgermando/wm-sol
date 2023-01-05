import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wm_solution/src/api/auth/auth_api.dart';
import 'package:wm_solution/src/api/notifications/budgets/budget_notify_api.dart';
import 'package:wm_solution/src/api/notifications/commercial/cart_notify_api.dart';
import 'package:wm_solution/src/api/notifications/commercial/prod_model_notify_api.dart';
import 'package:wm_solution/src/api/notifications/commercial/succursale_notify_api.dart';
import 'package:wm_solution/src/api/notifications/comptabilite/bilan_notify_api.dart';
import 'package:wm_solution/src/api/notifications/comptabilite/compte_resultat_notify_api.dart';
import 'package:wm_solution/src/api/notifications/departements/admin_departement.dart';
import 'package:wm_solution/src/api/notifications/departements/budget_departement.dart';
import 'package:wm_solution/src/api/notifications/departements/comm_marketing_departement.dart';
import 'package:wm_solution/src/api/notifications/departements/comptabilite_departement.dart';
import 'package:wm_solution/src/api/notifications/departements/exploitation_departement.dart';
import 'package:wm_solution/src/api/notifications/departements/finance_departement.dart';
import 'package:wm_solution/src/api/notifications/departements/logistique_departement.dart';
import 'package:wm_solution/src/api/notifications/departements/marketing_departement.dart';
import 'package:wm_solution/src/api/notifications/departements/rh_departement.dart';
import 'package:wm_solution/src/api/notifications/devis/devis_notify_api.dart';
import 'package:wm_solution/src/api/notifications/exploitations/production_notify_api.dart';
import 'package:wm_solution/src/api/notifications/exploitations/projet_notify_api.dart';
import 'package:wm_solution/src/api/notifications/exploitations/taches_notify_api.dart';
import 'package:wm_solution/src/api/notifications/finances/creance_notify_api.dart';
import 'package:wm_solution/src/api/notifications/finances/dette_notify_api.dart';
import 'package:wm_solution/src/api/notifications/logistique/entretien_notify_api.dart';
import 'package:wm_solution/src/api/notifications/logistique/etat_materiel_notify_api.dart';
import 'package:wm_solution/src/api/notifications/logistique/immobilier_notify_api.dart';
import 'package:wm_solution/src/api/notifications/logistique/materiel_notify_api.dart';
import 'package:wm_solution/src/api/notifications/logistique/mobilier_notify_api.dart';
import 'package:wm_solution/src/api/notifications/logistique/trajet_notify_api.dart';
import 'package:wm_solution/src/api/notifications/mails/mails_notify_api.dart';
import 'package:wm_solution/src/api/notifications/marketing/agenda_notify_api.dart';
import 'package:wm_solution/src/api/notifications/marketing/campaign_notify_api.dart';
import 'package:wm_solution/src/api/notifications/rh/salaires_notify_api.dart';
import 'package:wm_solution/src/api/notifications/rh/trans_rest_notify_api.dart';
import 'package:wm_solution/src/models/notify/notify_model.dart';
import 'package:wm_solution/src/models/notify/notify_sum_model.dart';
import 'package:wm_solution/src/models/users/user_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class DepartementNotifyCOntroller extends GetxController {
  Timer? timerAdmin;
  Timer? timerBudgets;
  Timer? timerCommercial;
  Timer? timerComptabilites;
  Timer? timerExploitations;
  Timer? timerFinances;
  Timer? timerLogistique;
  Timer? timerMarketing;
  Timer? timerRH;
  Timer? timerSupport;

  final ProfilController profilController = Get.put(ProfilController());

  // Header
  CartNotifyApi cartNotifyApi = CartNotifyApi();
  TacheNotifyApi tacheNotifyApi = TacheNotifyApi();
  MailsNotifyApi mailsNotifyApi = MailsNotifyApi();
  AgendaNotifyApi agendaNotifyApi = AgendaNotifyApi();

  // Administration
  AdminDepartementNotifyApi adminDepartementNotifyApi =
      AdminDepartementNotifyApi();

  // Budgets
  BudgetDepartementNotifyApi budgetDepartementNotifyApi =
      BudgetDepartementNotifyApi();
  BudgetNotifyApi budgetNotifyApi = BudgetNotifyApi();

  // Commercial
  ComDepartementNotifyApi comDepartementNotifyApi = ComDepartementNotifyApi();
  SuccursaleNotifyApi succursaleNotifyApi = SuccursaleNotifyApi();
  ProdModelNotifyApi prodModelNotifyApi = ProdModelNotifyApi();

  // Comptabilite
  ComptabiliteDepartementNotifyApi comptabiliteDepartementNotifyApi =
      ComptabiliteDepartementNotifyApi();
  BilanNotifyApi bilanNotifyApi = BilanNotifyApi();
  CompteResultatNotifyApi compteResultatNotifyApi = CompteResultatNotifyApi();

  // Exploitation
  final ExploitationDepartementNotifyApi exploitationDepartementNotifyApi =
      ExploitationDepartementNotifyApi();
  final ProjetNotifyApi projetNotifyApi = ProjetNotifyApi();
  final ProductionNotifyApi productionNotifyApi = ProductionNotifyApi();

  // Finance
  FinanceDepartementNotifyApi financeDepartementNotifyApi =
      FinanceDepartementNotifyApi();
  CreanceNotifyApi creanceNotifyApi = CreanceNotifyApi();
  DetteNotifyApi detteNotifyApi = DetteNotifyApi();

  // Logistique
  final LogistiqueDepartementNotifyApi logistiqueDepartementNotifyApi =
      LogistiqueDepartementNotifyApi();
  final DevisNotifyApi devisNotifyApi = DevisNotifyApi();
  final MaterielNotifyApi materielNotifyApi = MaterielNotifyApi();
  final TrajetNotifyApi trajetNotifyApi = TrajetNotifyApi();
  final ImmobilierNotifyApi immobilierNotifyApi = ImmobilierNotifyApi();
  final MobilierNotifyApi mobilierNotifyApi = MobilierNotifyApi();
  final EntretienNotifyApi entretienNotifyApi = EntretienNotifyApi();
  final EtatMaterielNotifyApi etatMaterielNotifyApi = EtatMaterielNotifyApi();

  // Marketing
  MarketingDepartementNotifyApi marketingDepartementNotifyApi =
      MarketingDepartementNotifyApi();
  CampaignNotifyApi campaignNotifyApi = CampaignNotifyApi();

  // Resource Humaine
  RhDepartementNotifyApi rhDepartementNotifyApi = RhDepartementNotifyApi();
  SalaireNotifyApi salaireNotifyApi = SalaireNotifyApi();
  TransRestNotifyApi transRestNotifyApi = TransRestNotifyApi();

  // Header
  final _cartItemCount = 0.obs;
  int get cartItemCount => _cartItemCount.value;

  final _tacheItemCount = 0.obs;
  int get tacheItemCount => _tacheItemCount.value;

  final _mailsItemCount = 0.obs;
  int get mailsItemCount => _mailsItemCount.value;

  final _agendaItemCount = 0.obs;
  int get agendaItemCount => _agendaItemCount.value;

  // Administration
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
  int get marketingCount => _marketingCount.value;

  final _logistiqueCount = 0.obs;
  int get logistiqueCount => _logistiqueCount.value;

  // Budgets
  final _itemBudgetCount = '0'.obs;
  String get itemBudgetCount => _itemBudgetCount.value;

  final _itemBudgetCountDG = 0.obs;
  int get itemBudgetCountDG => _itemBudgetCountDG.value;

  final _itemBudgetCountDD = 0.obs;
  int get itemBudgetCountDD => _itemBudgetCountDD.value;

  // Commercial
  final _itemCommercialCount = '0'.obs;
  String get itemCommercialCount => _itemCommercialCount.value;

  final _succursaleCountDG = 0.obs;
  int get succursaleCountDG => _succursaleCountDG.value;
  final _succursaleCountDD = 0.obs;
  int get succursaleCountDD => _succursaleCountDD.value;

  final _prodModelCount = 0.obs;
  int get prodModelCount => _prodModelCount.value;

  // Comptabilite
  final _itemComptabiliteCount = '0'.obs;
  String get itemComptabiliteCount => _itemComptabiliteCount.value;

  final _bilanCount = 0.obs;
  int get bilanCount => _bilanCount.value;
  final _compteResultatCount = 0.obs;
  int get compteResultatCount => _compteResultatCount.value;

  // Exploitation
  final _itemExploitationCount = '0'.obs;
  String get itemExploitationCount => _itemExploitationCount.value;

  final _itemCountProjetDG = 0.obs;
  int get itemCountProjetDG => _itemCountProjetDG.value;
  final _itemCountProjetBudget = 0.obs;
  int get itemCountProjetBudget => _itemCountProjetBudget.value;
  final _itemCountProjetDD = 0.obs;
  int get itemCountProjetDD => _itemCountProjetDD.value;
  final _itemCountProjetFin = 0.obs;
  int get itemCountProjetFin => _itemCountProjetFin.value;
  final _itemCountProjetObs = 0.obs;
  int get itemCountProjetObs => _itemCountProjetObs.value;

  final _itemCountProductionDG = 0.obs;
  int get itemCountProductionDG => _itemCountProductionDG.value;
  final _itemCounProductionDD = 0.obs;
  int get itemCounProductionDD => _itemCounProductionDD.value;

  // Finance
  final _itemFinanceCount = '0'.obs;
  String get itemFinanceCount => _itemFinanceCount.value;
  final _itemFinanceCountObs = '0'.obs;
  String get itemFinanceCountObs => _itemFinanceCountObs.value;

  final _creanceCountDD = 0.obs;
  int get creanceCountDD => _creanceCountDD.value;
  final _creanceCountDG = 0.obs;
  int get creanceCountDG => _creanceCountDG.value;

  final _detteCountDD = 0.obs;
  int get detteCountDD => _detteCountDD.value;
  final _detteCountDG = 0.obs;
  int get detteCountDG => _detteCountDG.value;

  // Logistique
  final _itemLogCount = '0'.obs;
  String get itemLogCount => _itemLogCount.value;

  final _itemLogCountDevisDG = 0.obs;
  int get itemLogCountDevisDG => _itemLogCountDevisDG.value;
  final _itemLogCountDevisBudget = 0.obs;
  int get itemLogCountDevisBudget => _itemLogCountDevisBudget.value;
  final _itemLogCountDevisDD = 0.obs;
  int get itemLogCountDevisDD => _itemLogCountDevisDD.value;
  final _itemLogCountDevisFin = 0.obs;
  int get itemLogCountDevisFin => _itemLogCountDevisFin.value;
  final _itemLogCountDevisObs = 0.obs;
  int get itemLogCountDevisObs => _itemLogCountDevisObs.value;

  final _itemCountMaterielDG = 0.obs;
  int get itemCountMaterielDG => _itemCountMaterielDG.value;
  final _itemCountMaterielDD = 0.obs;
  int get itemCountMaterielDD => _itemCountMaterielDD.value;

  final _itemCountTrajetsDD = 0.obs;
  int get itemCountTrajetsDD => _itemCountTrajetsDD.value;

  final _itemCountImmobilierDG = 0.obs;
  int get itemCountImmobilierDG => _itemCountImmobilierDG.value;
  final _itemCountImmobilierDD = 0.obs;
  int get itemCountImmobilierDD => _itemCountImmobilierDD.value;

  final _itemCountMobilierDD = 0.obs;
  int get itemCountMobilierDD => _itemCountMobilierDD.value;

  final _itemCounEntretienDD = 0.obs;
  int get itemCounEntretienDD => _itemCounEntretienDD.value;

  final _itemCounEtatmaterielDD = 0.obs;
  int get itemCounEtatmaterielDD => _itemCounEtatmaterielDD.value;

  // Marketing
  final _itemMarketingCount = '0'.obs;
  String get itemMarketingCount => _itemMarketingCount.value;

  final _campaignCountDG = 0.obs;
  int get campaignCountDG => _campaignCountDG.value;
  final _campaignCountDD = 0.obs;
  int get campaignCountDD => _campaignCountDD.value;
  final _campaignCountBudget = 0.obs;
  int get campaignCountBudget => _campaignCountBudget.value;
  final _campaignCountFin = 0.obs;
  int get campaignCountFin => _campaignCountFin.value;
  final _campaignCountObs = 0.obs;
  int get campaignCountObs => _campaignCountObs.value;

  // Resource Humaine
  final _itemRHCount = '0'.obs;
  String get itemRHCount => _itemRHCount.value;

  // Salaire
  final _itemCountSalaireBudget = 0.obs;
  int get itemCountSalaireBudget => _itemCountSalaireBudget.value;
  final _itemCountSalaireDD = 0.obs;
  int get itemCountSalaireDD => _itemCountSalaireDD.value;
  final _itemCountSalaireFin = 0.obs;
  int get itemCountSalaireFin => _itemCountSalaireFin.value;

  // Observation
  final _itemCountSalaireObs = 0.obs;
  int get itemCountSalaireObs => _itemCountSalaireObs.value;
  final _itemCountTransRestObs = 0.obs;
  int get itemCountTransRestObs => _itemCountTransRestObs.value;

  // TransRest
  final _itemCountTransRestDG = 0.obs;
  int get itemCountTransRestDG => _itemCountTransRestDG.value;
  final _itemCountTransRestBudget = 0.obs;
  int get itemCountTransRestBudget => _itemCountTransRestBudget.value;
  final _itemCountTransRestDD = 0.obs;
  int get itemCountTransRestDD => _itemCountTransRestDD.value;
  final _itemCountTransRestFin = 0.obs;
  int get itemCountTransRestFin => _itemCountTransRestFin.value;

  @override
  void onInit() {
    super.onInit();
    getDataNotify();
  }

  void getDataNotify() async {
    final getStorge = GetStorage();
    String? idToken = getStorge.read('idToken');
    if (idToken != null) {
      UserModel user = await AuthApi().getUserId();
      List<dynamic> departement = jsonDecode(user.departement);
      int userRole = int.parse(profilController.user.role); 

      if (departement.contains("Administration")) {
        timerAdmin = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (kDebugMode) {
            print("notify Administration");
          }
          if (userRole <= 1) {
            getBudgetCountDG();
            getCommercialCountSuccursalesDG();
            getCountProjetDG();
            getCountProductionDG();
            getFinanceCountCreanceDG();
            getFinanceCountDetteDG();
            getLogCountMaterielDG();
            getLogCountImmobilierDG();
            getCountTransRestDG();
            getLogCountDevisDG();

            getCountMail();
            getCountAgenda();
            getAdminCountBudget();
            getAdminCountRh();
            getAdminCountFinance();
            getAdminCountComptabilite();
            getAdminCountExploitation();
            getAdminCountCom();
            getAdminCountMarketing();
            getAdminCountLogistique();
          }
        });
      }
      if (departement.contains("Budgets")) {
        timerBudgets = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (kDebugMode) {
            print("notify Budgets");
          }
          if (userRole <= 2) {
            getBudgetCountBudget();
            getBudgetCountDD();
            getCountSalaireBudget();
            getCountTransRestBudget();
            getMarketingCountCampaignBudget();
            getLogCountDevisBudget();
            getCountProjetBudget();
          }
          getCountMail();
          getCountAgenda();
        });
      }
      if (departement.contains("Commercial")) {
        timerCommercial = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (kDebugMode) {
            print("notify Commercial");
          }
          if (userRole <= 2) {
            getCommercialCount();
            getCommercialCountSuccursalesDD();
            getCommercialCountProdModelDD();
          }
          getCountMail();
          getCountAgenda();
          getCountCart();
        });
      }
      if (departement.contains("Comptabilites")) {
        timerComptabilites = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (kDebugMode) {
            print("notify Comptabilites");
          }
          if (userRole <= 2) {
            getCountComptabilite();
            getCountBilanDD();
            getCountCompteResultatDD();
          }
          getCountMail();
          getCountAgenda();
        });
      }
      if (departement.contains("Exploitations")) {
        timerExploitations = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (kDebugMode) {
            print("notify Exploitations");
          }
          if (userRole <= 2) {
            getExploitationCount();
            getCountProjetDD();
            getCountProductionDD();
          }
          getCountMail();
          getCountAgenda();
          getCountTache();
        });
      }
      if (departement.contains("Finances")) {
        timerFinances = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (kDebugMode) {
            print("notify Finances");
          }
          if (userRole <= 2) {
            getFinanceCountDD();
            getFinanceCountCreanceDD();
            getFinanceCountDetteDD();
            getCountSalaireFin();
            getCountTransRestFin();
            getMarketingCountCampaignFin();
            getLogCountDevisFin();
            getCountProjetFin();
          }
          getCountMail();
          getCountAgenda();
          getFinanceCountObs();
          getCountProjeteObs();
          getLogCountDeviseObs();
          getCountTransResteObs();
          getMarketingCountCampaignObs();
          getCountSalaireObs();
        });
      }
      if (departement.contains("Logistique")) {
        timerLogistique = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (kDebugMode) {
            print("notify Logistique");
          }
          if (userRole <= 2) {
            getLogCount();
            getLogCountMaterielDD();
            getLogCountTrajetsDD();
            getLogCountImmobilierDD();
            getLogCountMobilierDD();
            getLogCountEntretienDD();
            getLogCountEtatmaterielDD();
            getLogCountDevisSalaireDD();
          }
          getCountMail();
          getCountAgenda();
        });
      }
      if (departement.contains("Marketing")) {
        timerMarketing = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (kDebugMode) {
            print("notify Marketing");
          }
          if (userRole <= 2) {
            getMarketingCountComMarketing();
            getMarketingCountCampaignDD();
          }
          getCountMail();
          getCountAgenda();
        });
      }
      if (departement.contains("Ressources Humaines")) {
        timerRH = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (kDebugMode) {
            print("notify Ressources Humaines");
          }
          if (userRole <= 2) {
            getRHCount();
            getCountSalaireDD();
            getCountTransRestSalaireDD();
          }
          getCountMail();
          getCountAgenda();
        });
      }

      if (departement.contains("Support")) {
        timerSupport = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (kDebugMode) {
            print("notify Support");
          }
          getCountMail();
          getCountAgenda();
        });
      }
    }
    
  }

  @override
  void dispose() {
    timerAdmin!.cancel();
    timerBudgets!.cancel();
    timerCommercial!.cancel();
    timerComptabilites!.cancel();
    timerExploitations!.cancel();
    timerFinances!.cancel();
    timerLogistique!.cancel();
    timerMarketing!.cancel();
    timerRH!.cancel();
    timerSupport!.cancel();
    super.dispose();
  }

  // Header
  void getCountCart() async {
    NotifyModel notifySum =
        await cartNotifyApi.getCount(profilController.user.matricule);
    _cartItemCount.value = notifySum.count;
    update();
  }

  void getCountTache() async {
    NotifyModel notifySum =
        await tacheNotifyApi.getCount(profilController.user.matricule);
    _tacheItemCount.value = notifySum.count;
    update();
  }

  void getCountMail() async {
    NotifyModel notifySum =
        await mailsNotifyApi.getCount(profilController.user.matricule);
    _mailsItemCount.value = notifySum.count;
    update();
  }

  void getCountAgenda() async {
    NotifyModel notifySum =
        await agendaNotifyApi.getCount(profilController.user.matricule);
    _agendaItemCount.value = notifySum.count;
    update();
  }

  // Administration
  void getAdminCountBudget() async {
    NotifySumModel notifySum = await adminDepartementNotifyApi.getCountBudget();
    _budgetCount.value = int.parse(notifySum.sum);
    update();
  }

  void getAdminCountRh() async {
    NotifySumModel notifySum = await adminDepartementNotifyApi.getCountRh();
    _rhCount.value = int.parse(notifySum.sum);
    update();
  }

  void getAdminCountFinance() async {
    NotifySumModel notifySum =
        await adminDepartementNotifyApi.getCountFinance();
    _financeCount.value = int.parse(notifySum.sum);
    update();
  }

  void getAdminCountComptabilite() async {
    NotifySumModel notifySum =
        await adminDepartementNotifyApi.getCountComptabilite();
    _comptabiliteCount.value = int.parse(notifySum.sum);
    update();
  }

  void getAdminCountExploitation() async {
    NotifySumModel notifySum =
        await adminDepartementNotifyApi.getCountExploitation();
    _exploitationCount.value = int.parse(notifySum.sum);
    update();
  }

  void getAdminCountCom() async {
    NotifySumModel notifySum = await adminDepartementNotifyApi.getCountCom();
    _commCount.value = int.parse(notifySum.sum);
    update();
  }

  void getAdminCountMarketing() async {
    NotifySumModel notifySum =
        await adminDepartementNotifyApi.getCountMarketing();
    _marketingCount.value = int.parse(notifySum.sum);
    update();
  }

  void getAdminCountLogistique() async {
    NotifySumModel notifySum =
        await adminDepartementNotifyApi.getCountLogistique();
    _logistiqueCount.value = int.parse(notifySum.sum);
    update();
  }

  // Budgets
  void getBudgetCountBudget() async {
    NotifySumModel notifySum =
        await budgetDepartementNotifyApi.getCountBudget();
    _itemBudgetCount.value = notifySum.sum;
    update();
  }

  void getBudgetCountDG() async {
    NotifyModel notifySum = await budgetNotifyApi.getCountDG();
    _itemBudgetCountDG.value = notifySum.count;
    update();
  }

  void getBudgetCountDD() async {
    NotifyModel notifySum = await budgetNotifyApi.getCountDD();
    _itemBudgetCountDD.value = notifySum.count;
    update();
  }

  // Commercial
  void getCommercialCount() async {
    NotifySumModel notifySum = await comDepartementNotifyApi.getCountCom();
    _itemCommercialCount.value = notifySum.sum;
    update();
  }

  void getCommercialCountSuccursalesDG() async {
    NotifyModel notifyModel = await succursaleNotifyApi.getCountDG();
    _succursaleCountDG.value = notifyModel.count;
    update();
  }

  void getCommercialCountSuccursalesDD() async {
    NotifyModel notifyModel = await succursaleNotifyApi.getCountDD();
    _succursaleCountDD.value = notifyModel.count;
    update();
  }

  void getCommercialCountProdModelDD() async {
    NotifyModel notifyModel = await prodModelNotifyApi.getCountDD();
    _prodModelCount.value = notifyModel.count;
    update();
  }

  // Comptabilite
  void getCountComptabilite() async {
    NotifySumModel notifySum =
        await comptabiliteDepartementNotifyApi.getCountComptabilite();
    _itemComptabiliteCount.value = notifySum.sum;
    update();
  }

  void getCountBilanDD() async {
    NotifyModel notifySum = await bilanNotifyApi.getCountDD();
    _bilanCount.value = notifySum.count;
    update();
  }

  void getCountCompteResultatDD() async {
    NotifyModel notifySum = await compteResultatNotifyApi.getCountDD();
    _compteResultatCount.value = notifySum.count;
    update();
  }

  // Exploitation
  void getExploitationCount() async {
    NotifySumModel notifySum =
        await exploitationDepartementNotifyApi.getCountExploitation();
    _itemExploitationCount.value = notifySum.sum;
    update();
  }

  void getCountProjetDG() async {
    NotifyModel notifySum = await projetNotifyApi.getCountDG();
    _itemCountProjetDG.value = notifySum.count;
    update();
  }

  void getCountProjetBudget() async {
    NotifyModel notifySum = await projetNotifyApi.getCountBudget();
    _itemCountProjetBudget.value = notifySum.count;
    update();
  }

  void getCountProjetFin() async {
    NotifyModel notifySum = await projetNotifyApi.getCountFin();
    _itemCountProjetFin.value = notifySum.count;
    update();
  }

  void getCountProjetDD() async {
    NotifyModel notifySum = await projetNotifyApi.getCountDD();
    _itemCountProjetDD.value = notifySum.count;
    update();
  }

  void getCountProjeteObs() async {
    NotifyModel notifySum = await projetNotifyApi.getCountObs();
    _itemCountProjetObs.value = notifySum.count;
    update();
  }

  void getCountProductionDG() async {
    NotifyModel notifySum = await productionNotifyApi.getCountDG();
    _itemCountProductionDG.value = notifySum.count;
    update();
  }

  void getCountProductionDD() async {
    NotifyModel notifySum = await productionNotifyApi.getCountDD();
    _itemCounProductionDD.value = notifySum.count;
    update();
  }

  // Finance
  void getFinanceCountDD() async {
    NotifySumModel notifySum =
        await financeDepartementNotifyApi.getCountFinanceDD();
    _itemFinanceCount.value = notifySum.sum;
    update();
  }

  void getFinanceCountObs() async {
    NotifySumModel notifySum =
        await financeDepartementNotifyApi.getCountFinanceObs();
    _itemFinanceCountObs.value = notifySum.sum;
    update();
  }

  void getFinanceCountCreanceDD() async {
    NotifyModel notifySum = await creanceNotifyApi.getCountDD();
    _creanceCountDD.value = notifySum.count;
    update();
  }

  void getFinanceCountCreanceDG() async {
    NotifyModel notifySum = await creanceNotifyApi.getCountDG();
    _creanceCountDG.value = notifySum.count;
    update();
  }

  void getFinanceCountDetteDD() async {
    NotifyModel notifySum = await detteNotifyApi.getCountDD();
    _detteCountDD.value = notifySum.count;
    update();
  }

  void getFinanceCountDetteDG() async {
    NotifyModel notifySum = await detteNotifyApi.getCountDG();
    _detteCountDG.value = notifySum.count;
    update();
  }

  // Logistique
  void getLogCount() async {
    NotifySumModel notifySum =
        await logistiqueDepartementNotifyApi.getCountLogistique();
    _itemLogCount.value = notifySum.sum;
    update();
  }

  void getLogCountDevisDG() async {
    NotifyModel notifySum = await devisNotifyApi.getCountDG();
    _itemLogCountDevisDG.value = notifySum.count;
    update();
  }

  void getLogCountDevisBudget() async {
    NotifyModel notifySum = await devisNotifyApi.getCountBudget();
    _itemLogCountDevisBudget.value = notifySum.count;
    update();
  }

  void getLogCountDevisSalaireDD() async {
    NotifyModel notifySum = await devisNotifyApi.getCountDD();
    _itemLogCountDevisDD.value = notifySum.count;
    update();
  }

  void getLogCountDevisFin() async {
    NotifyModel notifySum = await devisNotifyApi.getCountFin();
    _itemLogCountDevisFin.value = notifySum.count;
    update();
  }

  void getLogCountDeviseObs() async {
    NotifyModel notifySum = await devisNotifyApi.getCountObs();
    _itemLogCountDevisObs.value = notifySum.count;
    update();
  }

  void getLogCountMaterielDG() async {
    NotifyModel notifySum = await materielNotifyApi.getCountDG();
    _itemCountMaterielDG.value = notifySum.count;
    update();
  }

  void getLogCountMaterielDD() async {
    NotifyModel notifySum = await materielNotifyApi.getCountDD();
    _itemCountMaterielDD.value = notifySum.count;
    update();
  }

  void getLogCountTrajetsDD() async {
    NotifyModel notifySum = await trajetNotifyApi.getCountDD();
    _itemCountTrajetsDD.value = notifySum.count;
    update();
  }

  void getLogCountImmobilierDG() async {
    NotifyModel notifySum = await immobilierNotifyApi.getCountDG();
    _itemCountImmobilierDG.value = notifySum.count;
    update();
  }

  void getLogCountImmobilierDD() async {
    NotifyModel notifySum = await immobilierNotifyApi.getCountDD();
    _itemCountImmobilierDD.value = notifySum.count;
    update();
  }

  void getLogCountMobilierDD() async {
    NotifyModel notifySum = await mobilierNotifyApi.getCountDD();
    _itemCountMobilierDD.value = notifySum.count;
    update();
  }

  void getLogCountEntretienDD() async {
    NotifyModel notifySum = await entretienNotifyApi.getCountDD();
    _itemCounEntretienDD.value = notifySum.count;
    update();
  }

  void getLogCountEtatmaterielDD() async {
    NotifyModel notifySum = await etatMaterielNotifyApi.getCountDD();
    _itemCounEtatmaterielDD.value = notifySum.count;
    update();
  }

  // Marketing
  void getMarketingCountComMarketing() async {
    NotifySumModel notifySum =
        await marketingDepartementNotifyApi.getCountMarketing();
    _campaignCountDG.value = 0;
    _itemMarketingCount.value = notifySum.sum;
    update();
  }

  void getMarketingCountCampaignDG() async {
    NotifyModel notifyModel = await campaignNotifyApi.getCountDG();
    _campaignCountDG.value = 0;
    _campaignCountDG.value = notifyModel.count;
    update();
  }

  void getMarketingCountCampaignDD() async {
    NotifyModel notifyModel = await campaignNotifyApi.getCountDD();
    _campaignCountDG.value = 0;
    _campaignCountDD.value = notifyModel.count;
    update();
  }

  void getMarketingCountCampaignBudget() async {
    NotifyModel notifyModel = await campaignNotifyApi.getCountBudget();
    _campaignCountDG.value = 0;
    _campaignCountBudget.value = notifyModel.count;
    update();
  }

  void getMarketingCountCampaignFin() async {
    NotifyModel notifyModel = await campaignNotifyApi.getCountFin();
    _campaignCountDG.value = 0;
    _campaignCountFin.value = notifyModel.count;
    update();
  }

  void getMarketingCountCampaignObs() async {
    NotifyModel notifyModel = await campaignNotifyApi.getCountObs();
    _campaignCountDG.value = 0;
    _campaignCountObs.value = notifyModel.count;
    update();
  }

  // Ressource Humaines
  void getRHCount() async {
    NotifySumModel notifySum = await rhDepartementNotifyApi.getCountRh();
    _itemRHCount.value = notifySum.sum;
    update();
  }

  // salaire
  void getCountSalaireBudget() async {
    NotifyModel notifySum = await salaireNotifyApi.getCountBudget();
    _itemCountSalaireBudget.value = notifySum.count;
    update();
  }

  void getCountSalaireDD() async {
    NotifyModel notifySum = await salaireNotifyApi.getCountDD();
    _itemCountSalaireDD.value = notifySum.count;
    update();
  }

  void getCountSalaireFin() async {
    NotifyModel notifySum = await salaireNotifyApi.getCountFin();
    _itemCountSalaireFin.value = notifySum.count;
    update();
  }

  void getCountSalaireObs() async {
    NotifyModel notifySum = await salaireNotifyApi.getCountObs();
    _itemCountSalaireObs.value = notifySum.count;
    update();
  }

  // transRest
  void getCountTransRestDG() async {
    NotifyModel notifySum = await transRestNotifyApi.getCountDG();
    _itemCountTransRestDG.value = notifySum.count;
    update();
  }

  void getCountTransRestBudget() async {
    NotifyModel notifySum = await transRestNotifyApi.getCountBudget();
    _itemCountTransRestBudget.value = notifySum.count;
  }

  void getCountTransRestSalaireDD() async {
    NotifyModel notifySum = await transRestNotifyApi.getCountDD();
    _itemCountTransRestDD.value = notifySum.count;
    update();
  }

  void getCountTransRestFin() async {
    NotifyModel notifySum = await transRestNotifyApi.getCountFin();
    _itemCountTransRestFin.value = notifySum.count;
    update();
  }

  void getCountTransResteObs() async {
    NotifyModel notifySum = await transRestNotifyApi.getCountObs();
    _itemCountTransRestObs.value = notifySum.count;
    update();
  }
}
