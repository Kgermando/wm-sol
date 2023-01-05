import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wm_solution/src/api/auth/auth_api.dart';
import 'package:wm_solution/src/api/user/user_api.dart';
import 'package:wm_solution/src/pages/finances/controller/creances/creance_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/dettes/dette_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/personnels/personnels_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/personnels/user_actif_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/utils/info_system.dart';
import 'package:wm_solution/src/pages/administration/controller/admin_dashboard_controller.dart';
import 'package:wm_solution/src/pages/budgets/controller/dashboard_budget_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/dashboard/dashboard_com_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/dahsboard/dashboard_comptabilite_controller.dart';
import 'package:wm_solution/src/pages/exploitations/controller/dashboard/dashboard_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/dahboard/dashboard_finance_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/dashboard/dashboard_log_controller.dart';
import 'package:wm_solution/src/pages/mailling/controller/mailling_controller.dart';
import 'package:wm_solution/src/pages/marketing/controller/dahboard/dashboard_marketing_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/notify/dashboard_rh_controller.dart';
import 'package:wm_solution/src/controllers/departement_notify_controller.dart';
import 'package:wm_solution/src/pages/actionnaire/controller/actionnaire_controller.dart';
import 'package:wm_solution/src/pages/actionnaire/controller/actionnaire_cotisation_controller.dart';
import 'package:wm_solution/src/pages/actionnaire/controller/actionnaire_transfert_controller.dart'; 
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/budgets/controller/budget_previsionnel_controller.dart'; 
import 'package:wm_solution/src/pages/budgets/controller/ligne_budgetaire_controller.dart'; 
import 'package:wm_solution/src/pages/finances/controller/charts/chart_banque_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/charts/chart_caisse_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/charts/chart_fin_exterieur_controller.dart'; 
import 'package:wm_solution/src/pages/marketing/controller/annuaire/annuaire_pie_controller.dart'; 
import 'package:wm_solution/src/pages/update/controller/update_controller.dart'; 
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
import 'package:wm_solution/src/pages/devis/controller/devis_controller.dart';
import 'package:wm_solution/src/pages/devis/controller/devis_list_objet_controller.dart';
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



class LoginController extends GetxController {
  final AuthApi authApi = AuthApi();
  final UserApi userApi = UserApi();

  final _loadingLogin = false.obs;
  bool get isLoadingLogin => _loadingLogin.value;

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final TextEditingController matriculeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    matriculeController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void clear() {
    matriculeController.clear();
    passwordController.clear();
  }

  String? validator(String value) {
    if (value.isEmpty) {
      return 'Please this field must be filled';
    }
    return null;
  }

  void login() async {
    final form = loginFormKey.currentState!;
    if (form.validate()) {
      try {
        _loadingLogin.value = true;
        await authApi
            .login(matriculeController.text, passwordController.text)
            .then((value) async {
          clear();
          _loadingLogin.value = false;
          if (value) {
            Get.put(ProfilController(), permanent: true);
            Get.lazyPut(() => UsersController(), fenix: true);
            Get.lazyPut(() => DepartementNotifyCOntroller(), fenix: true);

            // Mail
            Get.lazyPut(() => MaillingController(), fenix: true);

            // Archive
            Get.lazyPut(() => ArchiveFolderController(), fenix: true);
            Get.lazyPut(() => ArchiveController(), fenix: true);

            // Personnels & Roles
            Get.lazyPut(() => PersonnelsRolesController(), fenix: true);

            // Authentification
            Get.lazyPut(() => LoginController(), fenix: true);
            // Get.lazyPut(() => ProfilController(), fenix: true);
            Get.lazyPut(() => ChangePasswordController(), fenix: true);
            Get.lazyPut(() => ForgotPasswordController(), fenix: true);

            // Actionnaire
            Get.lazyPut(() => ActionnaireController(), fenix: true);
            Get.lazyPut(() => ActionnaireCotisationController(), fenix: true);
            Get.lazyPut(() => ActionnaireTransfertController(), fenix: true);

            // Administration
            Get.lazyPut(() => AdminDashboardController(), fenix: true);

            // Budgets
            Get.lazyPut(() => DashboardBudgetController(), fenix: true);
            Get.lazyPut(() => BudgetPrevisionnelController(), fenix: true);
            Get.lazyPut(() => LignBudgetaireController(), fenix: true);

            // Commercial
            Get.lazyPut(() => DashboardComController(), fenix: true);
            Get.lazyPut(() => AchatController(), fenix: true);
            Get.lazyPut(() => BonLivraisonController(), fenix: true);
            Get.lazyPut(() => CartController(), fenix: true);
            Get.lazyPut(() => FactureController(), fenix: true);
            Get.lazyPut(() => FactureCreanceController(), fenix: true);
            Get.lazyPut(() => NumeroFactureController(), fenix: true);
            Get.lazyPut(() => GainCartController(), fenix: true);
            Get.lazyPut(() => HistoryLivraisonController(), fenix: true);
            Get.lazyPut(() => HistoryRavitaillementController(), fenix: true);
            Get.lazyPut(() => VenteCartController(), fenix: true);
            Get.lazyPut(() => ProduitModelController(), fenix: true);
            Get.lazyPut(() => RestitutionController(), fenix: true);
            Get.lazyPut(() => LivraisonController(), fenix: true);
            Get.lazyPut(() => RavitaillementController(), fenix: true);
            Get.lazyPut(() => StockGlobalController(), fenix: true);
            Get.lazyPut(() => SuccursaleController(), fenix: true);
            Get.lazyPut(() => VenteEffectueController(), fenix: true);

            // // Comptabilites
            Get.lazyPut(() => DashboardComptabiliteController(), fenix: true);
            Get.lazyPut(() => BalanceChartController(), fenix: true);
            Get.lazyPut(() => BalanceChartPieController(), fenix: true);
            Get.lazyPut(() => BalanceController(), fenix: true);
            Get.lazyPut(() => BalanceSumController(), fenix: true);
            Get.lazyPut(() => BilanController(), fenix: true);
            Get.lazyPut(() => CompteBilanRefController(), fenix: true);
            Get.lazyPut(() => CompteResultatController(), fenix: true);
            Get.lazyPut(() => JournalController(), fenix: true);

            // Exploitations
            Get.lazyPut(() => DashboardExpController(), fenix: true);
            Get.lazyPut(() => FourniseurController(), fenix: true);
            Get.lazyPut(() => ProductionExpController(), fenix: true);
            Get.lazyPut(() => ProjetController(), fenix: true);
            Get.lazyPut(() => SectionProjetController(), fenix: true);

            // Finances
            Get.lazyPut(() => DashboardFinanceController(), fenix: true);
            Get.lazyPut(() => ChartBanqueController(), fenix: true);
            Get.lazyPut(() => ChartCaisseController(), fenix: true);
            Get.lazyPut(() => ChartFinExterieurController(), fenix: true);
            Get.lazyPut(() => BanqueNameController(), fenix: true);
            Get.lazyPut(() => CaisseNameController(), fenix: true);
            Get.lazyPut(() => FinExterieurNameController(), fenix: true);
            Get.lazyPut(() => BanqueController(), fenix: true);
            Get.lazyPut(() => CaisseController(), fenix: true);
            Get.lazyPut(() => CreanceDetteController(), fenix: true);
            Get.lazyPut(() => CreanceController(), fenix: true);
            Get.lazyPut(() => DetteController(), fenix: true);
            Get.lazyPut(() => FinExterieurController(), fenix: true);

            // Logistique
            Get.lazyPut(() => DashboardLogController(), fenix: true);
            Get.lazyPut(() => ApprovisionReceptionController(), fenix: true);
            Get.lazyPut(() => ApprovisionnementController(), fenix: true);
            Get.lazyPut(() => EntretienController(), fenix: true);
            Get.lazyPut(() => ObjetRemplaceController(), fenix: true);
            Get.lazyPut(() => EtatMaterielController(), fenix: true);
            Get.lazyPut(() => ImmobilierController(), fenix: true);
            Get.lazyPut(() => MaterielController(), fenix: true);
            Get.lazyPut(() => MobilierController(), fenix: true);
            Get.lazyPut(() => TrajetController(), fenix: true);
            Get.lazyPut(() => DevisController(), fenix: true);
            Get.lazyPut(() => DevisListObjetController(), fenix: true);

            // Marketing
            Get.lazyPut(() => DashboardMarketingController(), fenix: true);
            Get.lazyPut(() => AgendaController(), fenix: true);
            Get.lazyPut(() => AnnuaireController(), fenix: true);
            Get.lazyPut(() => AnnuairePieController(), fenix: true);
            Get.lazyPut(() => CampaignController(), fenix: true);

            // RH
            Get.lazyPut(() => DashobardRHController(), fenix: true);
            Get.lazyPut(() => PerformenceController(), fenix: true);
            Get.lazyPut(() => PerformenceNoteController(), fenix: true);
            Get.lazyPut(() => PersonnelsController(), fenix: true);
            Get.lazyPut(() => UsersController(), fenix: true);
            Get.lazyPut(() => PresenceController(), fenix: true);
            Get.lazyPut(() => PresencePersonneController(), fenix: true);
            Get.lazyPut(() => SalaireController(), fenix: true);
            Get.lazyPut(() => TransportRestController(), fenix: true);
            Get.lazyPut(() => TransportRestPersonnelsController(), fenix: true);

            // Update Version
            Get.lazyPut(() => UpdateController(), fenix: true);

            GetStorage box = GetStorage();
            String? idToken = box.read('idToken');

            if (idToken != null) {
              await authApi.getUserId().then((userData) async {
                box.write('userModel', json.encode(userData));
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
                    Get.offAndToNamed(
                        ComptabiliteRoutes.comptabiliteJournalLivre);
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
                } else if (departement.first == "Support") { 
                  Get.offAndToNamed(AdminRoutes.adminDashboard);
                }

                // GetLocalStorage().saveUser(userData);
                _loadingLogin.value = false;
                Get.snackbar("Authentification réussie",
                    "Bienvenue ${userData.prenom} dans l'interface ${InfoSystem().name()}",
                    backgroundColor: Colors.green,
                    icon: const Icon(Icons.check),
                    snackPosition: SnackPosition.TOP);
              });
            }
          } else {
            _loadingLogin.value = false;
            Get.snackbar("Echec d'authentification",
                "Vérifier votre matricule et mot de passe",
                backgroundColor: Colors.red,
                icon: const Icon(Icons.close),
                snackPosition: SnackPosition.TOP);
          }
        });
      } catch (e) {
        _loadingLogin.value = false;
        Get.snackbar("Erreur lors de la connection", "$e",
            backgroundColor: Colors.red,
            icon: const Icon(Icons.close),
            snackPosition: SnackPosition.TOP);
      }
    }
  }

  Future<void> logout() async {
    try {
      _loadingLogin.value = true;
      await authApi.logout().then((value) {
        Get.deleteAll();
        GetStorage box = GetStorage();
        box.erase();
        Get.offAllNamed(UserRoutes.logout);
        Get.snackbar("Déconnexion réussie!", "",
            backgroundColor: Colors.green,
            icon: const Icon(Icons.check),
            snackPosition: SnackPosition.TOP);
        _loadingLogin.value = false;
      });
    } catch (e) {
      _loadingLogin.value = false;
      Get.snackbar("Erreur lors de la connection", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.close),
          snackPosition: SnackPosition.TOP);
    }
  }
}
