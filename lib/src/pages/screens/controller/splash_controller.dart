import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wm_solution/src/controllers/departement_notify_controller.dart';
import 'package:wm_solution/src/controllers/network_controller.dart';
import 'package:wm_solution/src/pages/actionnaire/controller/actionnaire_controller.dart';
import 'package:wm_solution/src/pages/actionnaire/controller/actionnaire_cotisation_controller.dart';
import 'package:wm_solution/src/pages/actionnaire/controller/actionnaire_transfert_controller.dart';
import 'package:wm_solution/src/pages/administration/controller/admin_dashboard_controller.dart';
import 'package:wm_solution/src/pages/auth/controller/login_controller.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/budgets/controller/budget_previsionnel_controller.dart';
import 'package:wm_solution/src/pages/budgets/controller/dashboard_budget_controller.dart';
import 'package:wm_solution/src/pages/budgets/controller/ligne_budgetaire_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/dashboard/dashboard_com_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/dahsboard/dashboard_comptabilite_controller.dart';
import 'package:wm_solution/src/pages/exploitations/controller/dashboard/dashboard_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/charts/chart_banque_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/charts/chart_caisse_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/charts/chart_fin_exterieur_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/dahboard/dashboard_finance_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/dashboard/dashboard_log_controller.dart';
import 'package:wm_solution/src/pages/mailling/controller/mailling_controller.dart';
import 'package:wm_solution/src/pages/marketing/controller/annuaire/annuaire_pie_controller.dart';
import 'package:wm_solution/src/pages/marketing/controller/dahboard/dashboard_marketing_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/notify/dashboard_rh_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/personnels/user_actif_controller.dart';
import 'package:wm_solution/src/pages/update/controller/update_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/pages/archives/controller/archive_controller.dart';
import 'package:wm_solution/src/pages/archives/controller/archive_folder_controller.dart';
import 'package:wm_solution/src/pages/auth/controller/change_password_controller.dart';
import 'package:wm_solution/src/pages/auth/controller/forgot_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/achats/achat_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/bon_livraison/bon_livraison_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/cart/cart_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/factures/facture_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/factures/facture_creance_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/factures/numero_facture_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/gains/gain_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/history/history_livraison.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/history/history_ravitaillement_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/history/history_vente_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/produit_model/produit_model_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/restitution/restitution_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/stock_global/livraison_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/stock_global/ravitaillement_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/stock_global/stock_global_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/succursale/succursale_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/vente_effectue/ventes_effectue_controller.dart';

import 'package:wm_solution/src/pages/comptabilites/controller/balance/balance_chart_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/balance/balance_chart_pie_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/balance/balance_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/balance/balance_sum_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/bilans/bilan_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/bilans/compte_bilan_ref_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/compte_resultat/compte_resultat_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/journals/journal_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/devis/devis_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/devis/devis_list_objet_controller.dart';
import 'package:wm_solution/src/pages/exploitations/controller/production/fournisseur_controller.dart';
import 'package:wm_solution/src/pages/exploitations/controller/production/production_exp_controller.dart';
import 'package:wm_solution/src/pages/exploitations/controller/projets/projet_controller.dart';
import 'package:wm_solution/src/pages/exploitations/controller/projets/section_projet_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/banques/banque_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/banques/banque_name_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/caisses/caisse_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/caisses/caisse_name_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/creance_dettes/creance_dette_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/creances/creance_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/dettes/dette_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/fin_exterieur/fin_exterieur_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/fin_exterieur/fin_exterieur_name_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/approvisions/approvision_reception_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/approvisions/approvisionnement_controller.dart';

import 'package:wm_solution/src/pages/logistique/controller/entretiens/entretiens_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/entretiens/objet_remplace_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/etat_materiel/etat_materiel_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/immobiliers/immobilier_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/materiels/materiel_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/mobiliers/mobilier_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/trajets/trajet_controller.dart';
import 'package:wm_solution/src/pages/marketing/controller/agenda/agenda_controller.dart';
import 'package:wm_solution/src/pages/marketing/controller/annuaire/annuaire_controller.dart';
import 'package:wm_solution/src/pages/marketing/controller/campaigns/compaign_controller.dart';
import 'package:wm_solution/src/pages/personnels_roles/controller/personnels_roles_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/performences/performence_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/performences/performence_note_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/personnels/personnels_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/presences/presence_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/presences/presence_personne_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/salaires/salaire_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/transport_rest/transport_rest_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/transport_rest/transport_rest_person_controller.dart';

class SplashController extends GetxController {
  final LoginController loginController = Get.put(LoginController());
  final NetworkController networkController = Get.put(NetworkController()); 

  final getStorge = GetStorage();

  @override
  void onReady() {
    super.onReady();
    // getStorge.erase();

    String? idToken = getStorge.read('idToken');
    if (kDebugMode) {
      print("splash idToken $idToken");
    }
    if (idToken != null) {
      Get.lazyPut(() => ProfilController(), fenix: true);
      Get.lazyPut(() => UsersController());
      Get.lazyPut(() => DepartementNotifyCOntroller());

      // Mail
      Get.lazyPut(() => MaillingController());

      // Archive
      Get.lazyPut(() => ArchiveFolderController());
      Get.lazyPut(() => ArchiveController());

      // Personnels & Roles
      Get.lazyPut(() => PersonnelsRolesController());

      // Authentification
      Get.lazyPut(() => LoginController());
      // Get.lazyPut(() => ProfilController());
      Get.lazyPut(() => ChangePasswordController());
      Get.lazyPut(() => ForgotPasswordController());

      // Actionnaire
      Get.lazyPut(() => ActionnaireController());
      Get.lazyPut(() => ActionnaireCotisationController());
      Get.lazyPut(() => ActionnaireTransfertController());

      // Administration
      Get.lazyPut(() => AdminDashboardController());

      // Budgets
      Get.lazyPut(() => DashboardBudgetController());
      Get.lazyPut(() => BudgetPrevisionnelController());
      Get.lazyPut(() => LignBudgetaireController());

      // Commercial
      Get.lazyPut(() => DashboardComController());
      Get.lazyPut(() => AchatController());
      Get.lazyPut(() => BonLivraisonController());
      Get.lazyPut(() => CartController());
      Get.lazyPut(() => FactureController());
      Get.lazyPut(() => FactureCreanceController());
      Get.lazyPut(() => NumeroFactureController());
      Get.lazyPut(() => GainCartController());
      Get.lazyPut(() => HistoryLivraisonController());
      Get.lazyPut(() => HistoryRavitaillementController());
      Get.lazyPut(() => VenteCartController());
      Get.lazyPut(() => ProduitModelController());
      Get.lazyPut(() => RestitutionController());
      Get.lazyPut(() => LivraisonController());
      Get.lazyPut(() => RavitaillementController());
      Get.lazyPut(() => StockGlobalController());
      Get.lazyPut(() => SuccursaleController());
      Get.lazyPut(() => VenteEffectueController());

      // // Comptabilites
      Get.lazyPut(() => DashboardComptabiliteController());
      Get.lazyPut(() => BalanceChartController());
      Get.lazyPut(() => BalanceChartPieController());
      Get.lazyPut(() => BalanceController());
      Get.lazyPut(() => BalanceSumController());
      Get.lazyPut(() => BilanController());
      Get.lazyPut(() => CompteBilanRefController());
      Get.lazyPut(() => CompteResultatController());
      Get.lazyPut(() => JournalController());

      // Exploitations
      Get.lazyPut(() => DashboardExpController());
      Get.lazyPut(() => FourniseurController());
      Get.lazyPut(() => ProductionExpController());
      Get.lazyPut(() => ProjetController());
      Get.lazyPut(() => SectionProjetController());

      // Finances
      Get.lazyPut(() => DashboardFinanceController());
      Get.lazyPut(() => ChartBanqueController());
      Get.lazyPut(() => ChartCaisseController());
      Get.lazyPut(() => ChartFinExterieurController());
      Get.lazyPut(() => BanqueNameController());
      Get.lazyPut(() => CaisseNameController());
      Get.lazyPut(() => FinExterieurNameController());
      Get.lazyPut(() => BanqueController());
      Get.lazyPut(() => CaisseController());
      Get.lazyPut(() => CreanceDetteController());
      Get.lazyPut(() => CreanceController());
      Get.lazyPut(() => DetteController());
      Get.lazyPut(() => FinExterieurController());

      // Logistique
      Get.lazyPut(() => DashboardLogController());
      Get.lazyPut(() => ApprovisionReceptionController());
      Get.lazyPut(() => ApprovisionnementController());
      Get.lazyPut(() => EntretienController());
      Get.lazyPut(() => ObjetRemplaceController());
      Get.lazyPut(() => EtatMaterielController());
      Get.lazyPut(() => ImmobilierController());
      Get.lazyPut(() => MaterielController());
      Get.lazyPut(() => MobilierController());
      Get.lazyPut(() => TrajetController());
      Get.lazyPut(() => DevisController());
      Get.lazyPut(() => DevisListObjetController());

      // Marketing
      Get.lazyPut(() => DashboardMarketingController());
      Get.lazyPut(() => AgendaController());
      Get.lazyPut(() => AnnuaireController());
      Get.lazyPut(() => AnnuairePieController());
      Get.lazyPut(() => CampaignController());

      // RH
      Get.lazyPut(() => DashobardRHController());
      Get.lazyPut(() => PerformenceController());
      Get.lazyPut(() => PerformenceNoteController());
      Get.lazyPut(() => PersonnelsController());
      Get.lazyPut(() => UsersController());
      Get.lazyPut(() => PresenceController());
      Get.lazyPut(() => PresencePersonneController());
      Get.lazyPut(() => SalaireController());
      Get.lazyPut(() => TransportRestController());
      Get.lazyPut(() => TransportRestPersonnelsController());

      // Update Version
      Get.lazyPut(() => UpdateController());

      isLoggIn();
    } else {
      Get.offAllNamed(UserRoutes.login);
    }
  }

  void isLoggIn() async {
    await loginController.authApi.getUserId().then((userData) async {
      var departement = jsonDecode(userData.departement);
      if (departement.first == "Administration") {
        if (int.parse(userData.role) <= 2) {
          Get.offAndToNamed(AdminRoutes.adminDashboard);
        } else {
          Get.offAndToNamed(AdminRoutes.adminComptabilite);
        }
      } else if (departement.first == "Finances") {
        if (int.parse(userData.role) <= 2) {
          Get.offAndToNamed(FinanceRoutes.financeDashboard);
        } else {
          Get.offAndToNamed(FinanceRoutes.transactionsDettes);
        }
      } else if (departement.first == "Comptabilites") {
        if (int.parse(userData.role) <= 2) {
          Get.offAndToNamed(ComptabiliteRoutes.comptabiliteDashboard);
        } else {
          Get.offAndToNamed(ComptabiliteRoutes.comptabiliteJournalLivre);
        }
      } else if (departement.first == "Budgets") {
        if (int.parse(userData.role) <= 2) {
          Get.offAndToNamed(BudgetRoutes.budgetBudgetPrevisionel);
        } else {
          Get.offAndToNamed(BudgetRoutes.budgetBudgetPrevisionel);
        }
      } else if (departement.first == "Ressources Humaines") {
        if (int.parse(userData.role) <= 2) {
          Get.offAndToNamed(RhRoutes.rhDashboard);
        } else {
          Get.offAndToNamed(RhRoutes.rhPresence);
        }
      } else if (departement.first == "Exploitations") {
        if (int.parse(userData.role) <= 2) {
          Get.offAndToNamed(ExploitationRoutes.expDashboard);
        } else {
          Get.offAndToNamed(TacheRoutes.tachePage);
        }
      } else if (departement.first == "Marketing") {
        Get.put(DashboardMarketingController());
        if (int.parse(userData.role) <= 2) {
          Get.offAndToNamed(MarketingRoutes.marketingDashboard);
        } else {
          Get.offAndToNamed(MarketingRoutes.marketingAnnuaire);
        }
      } else if (departement.first == "Commercial") {
        if (int.parse(userData.role) <= 2) {
          Get.offAndToNamed(ComRoutes.comDashboard);
        } else {
          Get.offAndToNamed(ComRoutes.comVente);
        }
      } else if (departement.first == "Logistique") {
        if (int.parse(userData.role) <= 2) {
          Get.offAndToNamed(LogistiqueRoutes.logDashboard);
        } else {
          Get.offAndToNamed(LogistiqueRoutes.logMateriel);
        }
      } else if (departement.first == "Actionnaire") {
        Get.offAndToNamed(ActionnaireRoute.actionnaireDashboard);
      } else if (departement.first == "Support") {
        Get.offAndToNamed(AdminRoutes.adminDashboard);
      }
    });
  }
}
