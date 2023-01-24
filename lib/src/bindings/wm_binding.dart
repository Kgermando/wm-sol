import 'package:get/get.dart';
import 'package:wm_solution/src/controllers/network_controller.dart'; 
import 'package:wm_solution/src/pages/auth/controller/login_controller.dart';
// import 'package:wm_solution/src/pages/actionnaire/controller/actionnaire_controller.dart';
// import 'package:wm_solution/src/pages/actionnaire/controller/actionnaire_cotisation_controller.dart';
// import 'package:wm_solution/src/pages/actionnaire/controller/actionnaire_transfert_controller.dart';
// import 'package:wm_solution/src/pages/administration/controller/admin_dashboard_controller.dart';
// import 'package:wm_solution/src/pages/archives/controller/archive_controller.dart';
// import 'package:wm_solution/src/pages/archives/controller/archive_folder_controller.dart';
// import 'package:wm_solution/src/pages/auth/controller/change_password_controller.dart';
// import 'package:wm_solution/src/pages/auth/controller/forgot_controller.dart';
// import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
// import 'package:wm_solution/src/pages/budgets/controller/budget_previsionnel_controller.dart';
// import 'package:wm_solution/src/pages/budgets/controller/dashboard_budget_controller.dart';
// import 'package:wm_solution/src/pages/budgets/controller/ligne_budgetaire_controller.dart';
// import 'package:wm_solution/src/pages/commercial/controller/commercials/achats/achat_controller.dart';
// import 'package:wm_solution/src/pages/commercial/controller/commercials/bon_livraison/bon_livraison_controller.dart';
// import 'package:wm_solution/src/pages/commercial/controller/commercials/cart/cart_controller.dart';
// import 'package:wm_solution/src/pages/commercial/controller/commercials/factures/facture_controller.dart';
// import 'package:wm_solution/src/pages/commercial/controller/commercials/factures/facture_creance_controller.dart';
// import 'package:wm_solution/src/pages/commercial/controller/commercials/factures/numero_facture_controller.dart';
// import 'package:wm_solution/src/pages/commercial/controller/commercials/gains/gain_controller.dart';
// import 'package:wm_solution/src/pages/commercial/controller/commercials/history/history_livraison.dart';
// import 'package:wm_solution/src/pages/commercial/controller/commercials/history/history_ravitaillement_controller.dart';
// import 'package:wm_solution/src/pages/commercial/controller/commercials/history/history_vente_controller.dart';
// import 'package:wm_solution/src/pages/commercial/controller/commercials/produit_model/produit_model_controller.dart';
// import 'package:wm_solution/src/pages/commercial/controller/commercials/restitution/restitution_controller.dart';
// import 'package:wm_solution/src/pages/commercial/controller/commercials/stock_global/livraison_controller.dart';
// import 'package:wm_solution/src/pages/commercial/controller/commercials/stock_global/ravitaillement_controller.dart';
// import 'package:wm_solution/src/pages/commercial/controller/commercials/stock_global/stock_global_controller.dart';
// import 'package:wm_solution/src/pages/commercial/controller/commercials/succursale/succursale_controller.dart';
// import 'package:wm_solution/src/pages/commercial/controller/commercials/vente_effectue/ventes_effectue_controller.dart';
// import 'package:wm_solution/src/pages/commercial/controller/dashboard/dashboard_com_controller.dart';
// import 'package:wm_solution/src/pages/comptabilites/controller/balance/balance_chart_controller.dart';
// import 'package:wm_solution/src/pages/comptabilites/controller/balance/balance_chart_pie_controller.dart';
// import 'package:wm_solution/src/pages/comptabilites/controller/balance/balance_controller.dart';
// import 'package:wm_solution/src/pages/comptabilites/controller/balance/balance_sum_controller.dart';
// import 'package:wm_solution/src/pages/comptabilites/controller/bilans/bilan_controller.dart';
// import 'package:wm_solution/src/pages/comptabilites/controller/bilans/compte_bilan_ref_controller.dart';
// import 'package:wm_solution/src/pages/comptabilites/controller/compte_resultat/compte_resultat_controller.dart';
// import 'package:wm_solution/src/pages/comptabilites/controller/dahsboard/dashboard_comptabilite_controller.dart';
// import 'package:wm_solution/src/pages/comptabilites/controller/journals/journal_controller.dart';
// import 'package:wm_solution/src/pages/devis/controller/devis_controller.dart';
// import 'package:wm_solution/src/pages/devis/controller/devis_list_objet_controller.dart';
// import 'package:wm_solution/src/pages/exploitations/controller/dashboard/dashboard_controller.dart';
// import 'package:wm_solution/src/pages/exploitations/controller/production/fournisseur_controller.dart';
// import 'package:wm_solution/src/pages/exploitations/controller/production/production_exp_controller.dart';
// import 'package:wm_solution/src/pages/exploitations/controller/projets/projet_controller.dart';
// import 'package:wm_solution/src/pages/exploitations/controller/projets/section_projet_controller.dart';
// import 'package:wm_solution/src/pages/finances/controller/banques/banque_controller.dart';
// import 'package:wm_solution/src/pages/finances/controller/banques/banque_name_controller.dart';
// import 'package:wm_solution/src/pages/finances/controller/caisses/caisse_controller.dart';
// import 'package:wm_solution/src/pages/finances/controller/caisses/caisse_name_controller.dart';
// import 'package:wm_solution/src/pages/finances/controller/charts/chart_banque_controller.dart';
// import 'package:wm_solution/src/pages/finances/controller/charts/chart_caisse_controller.dart';
// import 'package:wm_solution/src/pages/finances/controller/charts/chart_fin_exterieur_controller.dart';
// import 'package:wm_solution/src/pages/finances/controller/creance_dettes/creance_dette_controller.dart';
// import 'package:wm_solution/src/pages/finances/controller/creances/creance_controller.dart';
// import 'package:wm_solution/src/pages/finances/controller/dahboard/dashboard_finance_controller.dart';
// import 'package:wm_solution/src/pages/finances/controller/dettes/dette_controller.dart';
// import 'package:wm_solution/src/pages/finances/controller/fin_exterieur/fin_exterieur_controller.dart';
// import 'package:wm_solution/src/pages/finances/controller/fin_exterieur/fin_exterieur_name_controller.dart';
// import 'package:wm_solution/src/pages/logistique/controller/approvisions/approvision_reception_controller.dart';
// import 'package:wm_solution/src/pages/logistique/controller/approvisions/approvisionnement_controller.dart';
// import 'package:wm_solution/src/pages/logistique/controller/dashboard/dashboard_log_controller.dart';
// import 'package:wm_solution/src/pages/logistique/controller/entretiens/entretiens_controller.dart';
// import 'package:wm_solution/src/pages/logistique/controller/entretiens/objet_remplace_controller.dart';
// import 'package:wm_solution/src/pages/logistique/controller/etat_materiel/etat_materiel_controller.dart';
// import 'package:wm_solution/src/pages/logistique/controller/immobiliers/immobilier_controller.dart';
// import 'package:wm_solution/src/pages/logistique/controller/materiels/materiel_controller.dart';
// import 'package:wm_solution/src/pages/logistique/controller/mobiliers/mobilier_controller.dart';
// import 'package:wm_solution/src/pages/logistique/controller/trajets/trajet_controller.dart';
// import 'package:wm_solution/src/pages/mailling/controller/mailling_controller.dart';
// import 'package:wm_solution/src/pages/marketing/controller/agenda/agenda_controller.dart';
// import 'package:wm_solution/src/pages/marketing/controller/annuaire/annuaire_controller.dart';
// import 'package:wm_solution/src/pages/marketing/controller/annuaire/annuaire_pie_controller.dart';
// import 'package:wm_solution/src/pages/marketing/controller/campaigns/compaign_controller.dart';
// import 'package:wm_solution/src/pages/marketing/controller/dahboard/dashboard_marketing_controller.dart';
// import 'package:wm_solution/src/pages/personnels_roles/controller/personnels_roles_controller.dart';
// import 'package:wm_solution/src/pages/ressource_humaines/controller/notify/dashboard_rh_controller.dart';
// import 'package:wm_solution/src/pages/ressource_humaines/controller/performences/performence_controller.dart';
// import 'package:wm_solution/src/pages/ressource_humaines/controller/performences/performence_note_controller.dart';
// import 'package:wm_solution/src/pages/ressource_humaines/controller/personnels/personnels_controller.dart';
// import 'package:wm_solution/src/pages/ressource_humaines/controller/personnels/user_actif_controller.dart';
// import 'package:wm_solution/src/pages/ressource_humaines/controller/presences/presence_controller.dart';
// import 'package:wm_solution/src/pages/ressource_humaines/controller/presences/presence_personne_controller.dart';
// import 'package:wm_solution/src/pages/ressource_humaines/controller/salaires/salaire_controller.dart';
// import 'package:wm_solution/src/pages/ressource_humaines/controller/transport_rest/transport_rest_controller.dart';
// import 'package:wm_solution/src/pages/ressource_humaines/controller/transport_rest/transport_rest_person_controller.dart';
// import 'package:wm_solution/src/pages/update/controller/update_controller.dart';
import 'package:wm_solution/src/pages/screens/controller/splash_controller.dart';


class WMBindings extends Bindings {
  @override
  void dependencies() async { 
    Get.put<NetworkController>(NetworkController());
    Get.put<SplashController>(SplashController());
    // Get.put<ProfilController>(ProfilController());
    // Get.put<UsersController>(UsersController());
    Get.put<LoginController>(LoginController());
    // // Get.put<DepartementNotifyCOntroller>(DepartementNotifyCOntroller());
    
    // // Mail
    // Get.put<MaillingController>(MaillingController());

    // // Archive
    // Get.put<ArchiveFolderController>(ArchiveFolderController());
    // Get.put<ArchiveController>(ArchiveController());

    // // Personnels & Roles
    // Get.put<PersonnelsRolesController>(PersonnelsRolesController());

    // // Authentification
    // Get.put<LoginController>(LoginController()); 
    // Get.put(ProfilController());
    // Get.put(ChangePasswordController());
    // Get.put(ForgotPasswordController());

    // // Actionnaire
    // Get.put<ActionnaireController>(ActionnaireController());
    // Get.put<ActionnaireCotisationController>(ActionnaireCotisationController());
    // Get.put<ActionnaireTransfertController>(ActionnaireTransfertController());


    // // Administration
    // Get.put<AdminDashboardController>(AdminDashboardController());

    // // Budgets
    // Get.put<DashboardBudgetController>(DashboardBudgetController());
    // Get.put<BudgetPrevisionnelController>(BudgetPrevisionnelController()); 
    // Get.put<LignBudgetaireController>(LignBudgetaireController());


    // // Commercial
    // Get.put<DashboardComController>(DashboardComController());
    // Get.put<AchatController>(AchatController());
    // Get.put<BonLivraisonController>(BonLivraisonController());
    // Get.put<CartController>(CartController());
    // Get.put<FactureController>(FactureController());
    // Get.put<FactureCreanceController>(FactureCreanceController());
    // Get.put<NumeroFactureController>(NumeroFactureController());
    // Get.put<GainCartController>(GainCartController());
    // Get.put<HistoryLivraisonController>(HistoryLivraisonController());
    // Get.put<HistoryRavitaillementController>(HistoryRavitaillementController());
    // Get.put<VenteCartController>(VenteCartController());
    // Get.put<ProduitModelController>(ProduitModelController());
    // Get.put<RestitutionController>(RestitutionController());
    // Get.put<LivraisonController>(LivraisonController());
    // Get.put<RavitaillementController>(RavitaillementController());
    // Get.put<StockGlobalController>(StockGlobalController());
    // Get.put<SuccursaleController>(SuccursaleController());
    // Get.put<VenteEffectueController>(VenteEffectueController());
    
    // // Comptabilites
    // Get.put<DashboardComptabiliteController>(DashboardComptabiliteController());
    // Get.put<BalanceChartController>(BalanceChartController());
    // Get.put<BalanceChartPieController>(BalanceChartPieController());
    // Get.put<BalanceController>(BalanceController());
    // Get.put<BalanceSumController>(BalanceSumController());
    // Get.put<BilanController>(BilanController());
    // Get.put<CompteBilanRefController>(CompteBilanRefController());
    // Get.put<CompteResultatController>(CompteResultatController());
    // Get.put<JournalController>(JournalController());
    
    // // Exploitations
    // Get.put<DashboardExpController>(DashboardExpController());
    // Get.put<FourniseurController>(FourniseurController());
    // Get.put<ProductionExpController>(ProductionExpController());
    // Get.put<ProjetController>(ProjetController());
    // Get.put<SectionProjetController>(SectionProjetController());
  

    // // Finances
    // Get.put<DashboardFinanceController>(DashboardFinanceController());
    // Get.put<ChartBanqueController>(ChartBanqueController());
    // Get.put<ChartCaisseController>(ChartCaisseController());
    // Get.put<ChartFinExterieurController>(ChartFinExterieurController());
    // Get.put<BanqueNameController>(BanqueNameController());
    // Get.put<CaisseNameController>(CaisseNameController());
    // Get.put<FinExterieurNameController>(FinExterieurNameController());
    // Get.put<BanqueController>(BanqueController());
    // Get.put<CaisseController>(CaisseController());
    // Get.put<CreanceDetteController>(CreanceDetteController());
    // Get.put<CreanceController>(CreanceController());
    // Get.put<DetteController>(DetteController());
    // Get.put<FinExterieurController>(FinExterieurController());
    


    // // Logistique
    // Get.put<DashboardLogController>(DashboardLogController());
    // Get.put<ApprovisionReceptionController>(ApprovisionReceptionController());
    // Get.put<ApprovisionnementController>(ApprovisionnementController());
    // Get.put<EntretienController>(EntretienController());
    // Get.put<ObjetRemplaceController>(ObjetRemplaceController());
    // Get.put<EtatMaterielController>(EtatMaterielController());
    // Get.put<ImmobilierController>(ImmobilierController());
    // Get.put<MaterielController>(MaterielController());
    // Get.put<MobilierController>(MobilierController());
    // Get.put<TrajetController>(TrajetController());
    // Get.put<DevisController>(DevisController());
    // Get.put<DevisListObjetController>(DevisListObjetController());


    
    // // Marketing
    // Get.put<DashboardMarketingController>(DashboardMarketingController());
    // Get.put<AgendaController>(AgendaController()); 
    // Get.put<AnnuaireController>(AnnuaireController());
    // Get.put<AnnuairePieController>(AnnuairePieController());
    // Get.put<CampaignController>(CampaignController());
    


    // // RH
    // Get.put<DashobardRHController>(DashobardRHController());
    // Get.put<PerformenceController>(PerformenceController());
    // Get.put<PerformenceNoteController>(PerformenceNoteController());
    // Get.put<PersonnelsController>(PersonnelsController());
    // Get.put<UsersController>(UsersController());
    // Get.put<PresenceController>(PresenceController());
    // Get.put<PresencePersonneController>(PresencePersonneController());
    // Get.put<SalaireController>(SalaireController());
    // Get.put<TransportRestController>(TransportRestController());  
    // Get.put<TransportRestPersonnelsController>(TransportRestPersonnelsController());


    // // Update Version
    // Get.put<UpdateController>(UpdateController());
  }
}
