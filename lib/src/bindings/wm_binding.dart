import 'package:get/get.dart';
import 'package:wm_solution/src/helpers/network_controller.dart';
import 'package:wm_solution/src/navigation/header/controller/notify_header_controller.dart';
import 'package:wm_solution/src/pages/administration/controller/admin_dashboard_controller.dart';
import 'package:wm_solution/src/pages/administration/controller/admin_notify_controller.dart';
import 'package:wm_solution/src/pages/budgets/controller/dashboard_budget_controller.dart';
import 'package:wm_solution/src/pages/budgets/controller/notify/budget_notify_controller.dart';
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
import 'package:wm_solution/src/pages/commercial/controller/notify/commercial_notify.dart';
import 'package:wm_solution/src/pages/logistique/controller/materiels/materiel_controller.dart';
import 'package:wm_solution/src/pages/marketing/controller/agenda/agenda_controller.dart';
import 'package:wm_solution/src/pages/marketing/controller/annuaire/annuaire_controller.dart';
import 'package:wm_solution/src/pages/marketing/controller/campaigns/compaign_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/succursale/succursale_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/balance/balance_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/balance/balance_ref_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/bilans/bilan_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/bilans/compte_bilan_ref_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/compte_resultat/compte_resultat_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/dahsboard/dashboard_comptabilite_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/journals/journal_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/journals/journal_livre_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/notify/notify_comptabilite.dart';
import 'package:wm_solution/src/pages/devis/controller/devis_controller.dart';
import 'package:wm_solution/src/pages/devis/controller/devis_list_objet_controller.dart';
import 'package:wm_solution/src/pages/devis/controller/devis_notify.dart';
import 'package:wm_solution/src/pages/exploitations/controller/dashboard/dashboard_controller.dart';
import 'package:wm_solution/src/pages/exploitations/controller/notify/notify_exp.dart';
import 'package:wm_solution/src/pages/exploitations/controller/production/fournisseur_controller.dart';
import 'package:wm_solution/src/pages/exploitations/controller/production/production_exp_controller.dart';
import 'package:wm_solution/src/pages/exploitations/controller/projets/projet_controller.dart';
import 'package:wm_solution/src/pages/exploitations/controller/versements/versement_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/banques/banque_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/banques/banque_name_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/caisses/caisse_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/caisses/caisse_name_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/creance_dettes/creance_dette_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/creances/creance_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/dahboard/dashboard_finance_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/dettes/dette_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/fin_exterieur/fin_exterieur_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/fin_exterieur/fin_exterieur_name_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/notify/finance_notify_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/notify/observation_notify_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/approvisions/approvision_reception_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/approvisions/approvisionnement_controller.dart';  
import 'package:wm_solution/src/pages/logistique/controller/trajets/trajet_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/dashboard/dashboard_log_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/entretiens/entretiens_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/entretiens/objet_remplace_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/etat_materiel/etat_materiel_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/immobiliers/immobilier_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/mobiliers/mobilier_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/notify/notify_log.dart';
import 'package:wm_solution/src/pages/marketing/controller/notify/marketing_notify.dart';
import 'package:wm_solution/src/pages/personnels_roles/controller/personnels_roles_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/notify/dashboard_notify_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/notify/rh_notify_controller.dart';
import 'package:wm_solution/src/pages/auth/controller/forgot_controller.dart';
import 'package:wm_solution/src/pages/auth/controller/change_password_controller.dart';
import 'package:wm_solution/src/pages/auth/controller/login_controller.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/budgets/controller/budget_previsionnel_controller.dart';
import 'package:wm_solution/src/pages/budgets/controller/ligne_budgetaire_controller.dart';
import 'package:wm_solution/src/pages/mailling/controller/mailling_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/performences/performence_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/performences/performence_note_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/personnels/personnels_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/personnels/user_actif_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/presences/presence_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/presences/presence_personne_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/salaires/salaire_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/transport_rest/transport_rest_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/transport_rest/transport_rest_person_controller.dart';
import 'package:wm_solution/src/pages/taches/controller/rapport_controller.dart';
import 'package:wm_solution/src/pages/taches/controller/taches_controller.dart';
import 'package:wm_solution/src/pages/update/controller/update_controller.dart';

class WMBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NetworkController>(() => NetworkController());
    
    // Authentification
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<ProfilController>(() => ProfilController());
    Get.lazyPut<ChangePasswordController>(() => ChangePasswordController());
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());

    // Header
    Get.lazyPut<NotifyHeaderController>(() => NotifyHeaderController());

    // Mail
    Get.lazyPut<MaillingController>(() => MaillingController());

    // Personnels & Roles
    Get.lazyPut<PersonnelsRolesController>(() => PersonnelsRolesController());

    // Taches
    Get.lazyPut<TachesController>(() => TachesController());
    Get.lazyPut<RapportController>(() => RapportController());


    // RH
    Get.lazyPut<DashobardNotifyController>(() => DashobardNotifyController());
    Get.lazyPut<RHNotifyController>(() => RHNotifyController());
    Get.lazyPut<PersonnelsController>(() => PersonnelsController());
    Get.lazyPut<SalaireController>(() => SalaireController());
    Get.lazyPut<TransportRestController>(() => TransportRestController());
    Get.lazyPut<TransportRestPersonnelsController>(() => TransportRestPersonnelsController());
    Get.lazyPut<PerformenceController>(() => PerformenceController());
    Get.lazyPut<PerformenceNoteController>(() => PerformenceNoteController());
    Get.lazyPut<UsersController>(() => UsersController());
    Get.lazyPut<PresenceController>(() => PresenceController());
    Get.lazyPut<PresencePersonneController>(() => PresencePersonneController());


  // Budgets
  Get.lazyPut<DashboardBudgetController>(() => DashboardBudgetController());
  Get.lazyPut<BudgetNotifyController>(() => BudgetNotifyController());
  Get.lazyPut<BudgetPrevisionnelController>(
      () => BudgetPrevisionnelController());
  Get.lazyPut<LignBudgetaireController>(() => LignBudgetaireController());

  // Comptabilites
  Get.lazyPut<DashboardComptabiliteController>(
        () => DashboardComptabiliteController());
  Get.lazyPut<ComptabiliteNotifyController>(() => ComptabiliteNotifyController());
  Get.lazyPut<BalanceController>(() => BalanceController());
  Get.lazyPut<BalanceRefController>(() => BalanceRefController());
  Get.lazyPut<BilanController>(() => BilanController());
  Get.lazyPut<CompteBilanRefController>(() => CompteBilanRefController()); 
  Get.lazyPut<CompteResultatController>(() => CompteResultatController());
  Get.lazyPut<JournalController>(() => JournalController());
  Get.lazyPut<JournalLivreController>(() => JournalLivreController());

  // Finances
  Get.lazyPut<DashboardFinanceController>(() => DashboardFinanceController()); 
  Get.lazyPut<BanqueController>(() => BanqueController()); 
  Get.lazyPut<BanqueNameController>(() => BanqueNameController());
  Get.lazyPut<CaisseController>(() => CaisseController());
  Get.lazyPut<CaisseNameController>(() => CaisseNameController());
  Get.lazyPut<CreanceDetteController>(() => CreanceDetteController());
  Get.lazyPut<CreanceController>(() => CreanceController());
  Get.lazyPut<DetteController>(() => DetteController());
  Get.lazyPut<FinExterieurController>(() => FinExterieurController());
  Get.lazyPut<FinExterieurNameController>(() => FinExterieurNameController());
  Get.lazyPut<FinanceNotifyController>(() => FinanceNotifyController());
  Get.lazyPut<ObservationNotifyController>(() => ObservationNotifyController());

  // Devis
  Get.lazyPut<DevisController>(() => DevisController());
  Get.lazyPut<DevisListObjetController>(() => DevisListObjetController());
  Get.lazyPut<DevisNotifyController>(() => DevisNotifyController());


  // Exploitations
  Get.lazyPut<ProjetController>(() => ProjetController());
  Get.lazyPut<DashboardExpController>(() => DashboardExpController());
  Get.lazyPut<NotifyExpController>(() => NotifyExpController());
  Get.lazyPut<FourniseurController>(() => FourniseurController());
  Get.lazyPut<ProductionExpController>(() => ProductionExpController());
  Get.lazyPut<VersementController>(() => VersementController());


  // Marketing
  Get.lazyPut<MarketingNotifyController>(() => MarketingNotifyController());
  Get.lazyPut<CampaignController>(() => CampaignController());
  Get.lazyPut<AnnuaireController>(() => AnnuaireController());
  Get.lazyPut<AgendaController>(() => AgendaController());

  // Commercial
  Get.lazyPut<ComNotifyController>(() => ComNotifyController());
  Get.lazyPut<SuccursaleController>(() => SuccursaleController());
  Get.lazyPut<AchatController>(() => AchatController());
  Get.lazyPut<BonLivraisonController>(() => BonLivraisonController());
  Get.lazyPut<CartController>(() => CartController());
  Get.lazyPut<FactureController>(() => FactureController());
  Get.lazyPut<FactureCreanceController>(() => FactureCreanceController());
  Get.lazyPut<NumeroFactureController>(() => NumeroFactureController());
  Get.lazyPut<GainController>(() => GainController());
  Get.lazyPut<HistoryLivraisonController>(() => HistoryLivraisonController());
  Get.lazyPut<HistoryRavitaillementController>(() => HistoryRavitaillementController());
  Get.lazyPut<VenteCartController>(() => VenteCartController());
  Get.lazyPut<ProduitModelController>(() => ProduitModelController());
  Get.lazyPut<RestitutionController>(() => RestitutionController());
  Get.lazyPut<LivraisonController>(() => LivraisonController());
  Get.lazyPut<RavitaillementController>(() => RavitaillementController());
  Get.lazyPut<StockGlobalController>(() => StockGlobalController());  


  // Logistique
  Get.lazyPut<ApprovisionReceptionController>(() => ApprovisionReceptionController());  
  Get.lazyPut<ApprovisionnementController>(() => ApprovisionnementController());
  Get.lazyPut<MaterielController>(() => MaterielController());  
  Get.lazyPut<TrajetController>(() => TrajetController());  
  Get.lazyPut<DashboardLogController>(() => DashboardLogController());  
  Get.lazyPut<EntretienController>(() => EntretienController());  
  Get.lazyPut<ObjetRemplaceController>(() => ObjetRemplaceController());  
  Get.lazyPut<EtatMaterielController>(() => EtatMaterielController());  
  Get.lazyPut<ImmobilierController>(() => ImmobilierController());  
  Get.lazyPut<MobilierController>(() => MobilierController());  
  Get.lazyPut<NotifyLogController>(() => NotifyLogController());  

  // Update Version
  Get.lazyPut<UpdateController>(() => UpdateController());  


  // Administration
  Get.lazyPut<AdminDashboardController>(() => AdminDashboardController()); 
  Get.lazyPut<AdminNotifyController>(() => AdminNotifyController()); 

  
  }
}
