import 'package:get/get.dart';
import 'package:wm_solution/src/navigation/header/controller/notify_header_controller.dart';
import 'package:wm_solution/src/pages/administration/controller/admin_notify_controller.dart';
import 'package:wm_solution/src/pages/budgets/controller/notify/budget_notify_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/notify/commercial_notify.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/notify/notify_comptabilite.dart';
import 'package:wm_solution/src/pages/devis/controller/devis_notify.dart';
import 'package:wm_solution/src/pages/exploitations/controller/notify/notify_exp.dart';
import 'package:wm_solution/src/pages/finances/controller/banques/banque_name_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/caisses/caisse_name_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/fin_exterieur/fin_exterieur_name_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/notify/finance_notify_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/notify/notify_log.dart';
import 'package:wm_solution/src/pages/marketing/controller/notify/marketing_notify.dart';
import 'package:wm_solution/src/pages/personnels_roles/controller/personnels_roles_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/notify/rh_notify_controller.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/screens/controller/splash_controller.dart';
import 'package:wm_solution/src/pages/update/controller/update_controller.dart';

class WMBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
    // Authentification
    // Get.put<LoginController>(LoginController());
    Get.put<ProfilController>(ProfilController());
    // Get.put<ChangePasswordController>(ChangePasswordController());
    // Get.put<ForgotPasswordController>(ForgotPasswordController());

    // Header
    Get.put<NotifyHeaderController>(NotifyHeaderController());
    // Administration
    Get.put<AdminNotifyController>(AdminNotifyController());

    // Mail
    // Get.put<MaillingController>(MaillingController());

    // Personnels & Roles
    Get.put<PersonnelsRolesController>(PersonnelsRolesController());

    // Taches
    // Get.put<TachesController>(TachesController());
    // Get.put<RapportController>(RapportController());

    // Archive
    // Get.put<ArchiveController>(ArchiveController());
    // Get.put<ArchiveFolderController>(ArchiveFolderController());

    // RH
    // Get.put<DashobardRHController>(DashobardRHController());
    Get.put<RHNotifyController>(RHNotifyController());
    // Get.put<PersonnelsController>(PersonnelsController());
    // Get.put<SalaireController>(SalaireController());
    // Get.put<TransportRestController>(TransportRestController());
    // Get.put<TransportRestPersonnelsController>(TransportRestPersonnelsController());
    // Get.put<PerformenceController>(PerformenceController());
    // Get.put<PerformenceNoteController>(PerformenceNoteController());
    // Get.put<UsersController>(UsersController());
    // Get.put<PresenceController>(PresenceController());
    // Get.put<PresencePersonneController>(PresencePersonneController());

    // Budgets
    // Get.put<DashboardBudgetController>(DashboardBudgetController());
    Get.put<BudgetNotifyController>(BudgetNotifyController());
    // Get.put<BudgetPrevisionnelController>(
    //     BudgetPrevisionnelController());
    // Get.put<LignBudgetaireController>(LignBudgetaireController());

    // Comptabilites
    // Get.put<DashboardComptabiliteController>(
    //       DashboardComptabiliteController());
    Get.put<ComptabiliteNotifyController>(ComptabiliteNotifyController());
    // Get.put<BalanceController>(BalanceController());
    // Get.put<BalanceRefController>(BalanceRefController());
    // Get.put<BilanController>(BilanController());
    // Get.put<CompteBilanRefController>(CompteBilanRefController());
    // Get.put<CompteBilanRefController>(CompteBilanRefController());
    // Get.put<CompteResultatController>(CompteResultatController());
    // Get.put<JournalController>(JournalController());
    // Get.put<JournalLivreController>(JournalLivreController());

    // Devis
    // Get.put<DevisController>(DevisController());
    // Get.put<DevisListObjetController>(DevisListObjetController());
    Get.put<DevisNotifyController>(DevisNotifyController());

    // Finances
    // Get.put<DashboardFinanceController>(DashboardFinanceController());
    // Get.put<BanqueController>(BanqueController());
    Get.put<BanqueNameController>(BanqueNameController());
    // Get.put<CaisseController>(CaisseController());
    Get.put<CaisseNameController>(CaisseNameController());
    // Get.put<CreanceDetteController>(CreanceDetteController());
    // Get.put<CreanceController>(CreanceController());
    // Get.put<DetteController>(DetteController());
    // Get.put<FinExterieurController>(FinExterieurController());
    Get.put<FinExterieurNameController>(FinExterieurNameController());
    Get.put<FinanceNotifyController>(FinanceNotifyController());
    // Get.put<ObservationNotifyController>(
    //     ObservationNotifyController());

    // Marketing
    Get.put<MarketingNotifyController>(MarketingNotifyController());
    // Get.put<DashboardMarketingController>(DashboardMarketingController());
    // Get.put<CampaignController>(CampaignController());
    // Get.put<AnnuaireController>(AnnuaireController());
    // Get.put<AgendaController>(AgendaController());

    // Commercial
    // Get.put<DashboardComController>(DashboardComController());
    Get.put<ComNotifyController>(ComNotifyController());
    // Get.put<SuccursaleController>(SuccursaleController());
    // Get.put<AchatController>(AchatController());
    // Get.put<BonLivraisonController>(BonLivraisonController());
    // Get.put<CartController>(CartController());
    // Get.put<FactureController>(FactureController());
    // Get.put<FactureCreanceController>(FactureCreanceController());
    // Get.put<NumeroFactureController>(NumeroFactureController());
    // Get.put<GainController>(GainController());
    // Get.put<HistoryLivraisonController>(HistoryLivraisonController());
    // Get.put<HistoryRavitaillementController>(
    //     HistoryRavitaillementController());
    // Get.put<VenteCartController>(VenteCartController());
    // Get.put<ProduitModelController>(ProduitModelController());
    // Get.put<RestitutionController>(RestitutionController());
    // Get.put<LivraisonController>(LivraisonController());
    // Get.put<RavitaillementController>(RavitaillementController());
    // Get.put<StockGlobalController>(StockGlobalController());

    // Exploitations
    // Get.put<ProjetController>(ProjetController());
    // Get.put<DashboardExpController>(DashboardExpController());
    Get.put<NotifyExpController>(NotifyExpController());
    // Get.put<FourniseurController>(FourniseurController());
    // Get.put<ProductionExpController>(ProductionExpController());
    // Get.put<VersementController>(VersementController());

    // Logistique
    // Get.put<ApprovisionReceptionController>(
    //     ApprovisionReceptionController());
    // Get.put<ApprovisionnementController>(
    //     ApprovisionnementController());
    // Get.put<MaterielController>(MaterielController());
    // Get.put<TrajetController>(TrajetController());
    // Get.put<DashboardLogController>(DashboardLogController());
    // Get.put<EntretienController>(EntretienController());
    // Get.put<ObjetRemplaceController>(ObjetRemplaceController());
    // Get.put<EtatMaterielController>(EtatMaterielController());
    // Get.put<ImmobilierController>(ImmobilierController());
    // Get.put<MobilierController>(MobilierController());
    Get.put<NotifyLogController>(NotifyLogController());

    // Update Version
    Get.put<UpdateController>(UpdateController());
  }
}
