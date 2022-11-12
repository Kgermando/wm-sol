import 'package:get/get.dart';
import 'package:wm_solution/src/helpers/network_controller.dart';
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
import 'package:wm_solution/src/pages/update/controller/update_controller.dart';

class WMBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NetworkController>(() => NetworkController());

    // Authentification
    // Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<ProfilController>(() => ProfilController());
    // Get.lazyPut<ChangePasswordController>(() => ChangePasswordController());
    // Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());

    // Header
    Get.lazyPut<NotifyHeaderController>(() => NotifyHeaderController());

    // Mail
    // Get.lazyPut<MaillingController>(() => MaillingController());

    // Personnels & Roles
    Get.lazyPut<PersonnelsRolesController>(() => PersonnelsRolesController());

    // Taches
    // Get.lazyPut<TachesController>(() => TachesController());
    // Get.lazyPut<RapportController>(() => RapportController());

    // Archive
    // Get.lazyPut<ArchiveController>(() => ArchiveController());
    // Get.lazyPut<ArchiveFolderController>(() => ArchiveFolderController());

    // RH
    // Get.lazyPut<DashobardNotifyController>(() => DashobardNotifyController());
    Get.lazyPut<RHNotifyController>(() => RHNotifyController());
    // Get.lazyPut<PersonnelsController>(() => PersonnelsController());
    // Get.lazyPut<SalaireController>(() => SalaireController());
    // Get.lazyPut<TransportRestController>(() => TransportRestController());
    // Get.lazyPut<TransportRestPersonnelsController>(() => TransportRestPersonnelsController());
    // Get.lazyPut<PerformenceController>(() => PerformenceController());
    // Get.lazyPut<PerformenceNoteController>(() => PerformenceNoteController());
    // Get.lazyPut<UsersController>(() => UsersController());
    // Get.lazyPut<PresenceController>(() => PresenceController());
    // Get.lazyPut<PresencePersonneController>(() => PresencePersonneController());

    // Budgets
    // Get.lazyPut<DashboardBudgetController>(() => DashboardBudgetController());
    Get.lazyPut<BudgetNotifyController>(() => BudgetNotifyController());
    // Get.lazyPut<BudgetPrevisionnelController>(
    //     () => BudgetPrevisionnelController());
    // Get.lazyPut<LignBudgetaireController>(() => LignBudgetaireController());

    // Comptabilites
    // Get.lazyPut<DashboardComptabiliteController>(
    //       () => DashboardComptabiliteController());
    Get.lazyPut<ComptabiliteNotifyController>(
        () => ComptabiliteNotifyController());
    // Get.lazyPut<BalanceController>(() => BalanceController());
    // Get.lazyPut<BalanceRefController>(() => BalanceRefController());
    // Get.lazyPut<BilanController>(() => BilanController());
    // Get.lazyPut<CompteBilanRefController>(() => CompteBilanRefController());
    // Get.lazyPut<CompteBilanRefController>(() => CompteBilanRefController());
    // Get.lazyPut<CompteResultatController>(() => CompteResultatController());
    // Get.lazyPut<JournalController>(() => JournalController());
    // Get.lazyPut<JournalLivreController>(() => JournalLivreController());

    // Devis
    // Get.lazyPut<DevisController>(() => DevisController());
    // Get.lazyPut<DevisListObjetController>(() => DevisListObjetController());
    Get.lazyPut<DevisNotifyController>(() => DevisNotifyController());

    // Finances
    // Get.lazyPut<DashboardFinanceController>(() => DashboardFinanceController());
    // Get.lazyPut<BanqueController>(() => BanqueController());
    Get.lazyPut<BanqueNameController>(() => BanqueNameController());
    // Get.lazyPut<CaisseController>(() => CaisseController());
    Get.lazyPut<CaisseNameController>(() => CaisseNameController());
    // Get.lazyPut<CreanceDetteController>(() => CreanceDetteController());
    // Get.lazyPut<CreanceController>(() => CreanceController());
    // Get.lazyPut<DetteController>(() => DetteController());
    // Get.lazyPut<FinExterieurController>(() => FinExterieurController());
    Get.lazyPut<FinExterieurNameController>(() => FinExterieurNameController());
    Get.lazyPut<FinanceNotifyController>(() => FinanceNotifyController());
    // Get.lazyPut<ObservationNotifyController>(
    //     () => ObservationNotifyController());

    // Marketing
    Get.lazyPut<MarketingNotifyController>(() => MarketingNotifyController());
    // Get.lazyPut<DashboardMarketingController>(() => DashboardMarketingController());
    // Get.lazyPut<CampaignController>(() => CampaignController());
    // Get.lazyPut<AnnuaireController>(() => AnnuaireController());
    // Get.lazyPut<AgendaController>(() => AgendaController());

    // Commercial
    // Get.lazyPut<DashboardComController>(() => DashboardComController());
    Get.lazyPut<ComNotifyController>(() => ComNotifyController());
    // Get.lazyPut<SuccursaleController>(() => SuccursaleController());
    // Get.lazyPut<AchatController>(() => AchatController());
    // Get.lazyPut<BonLivraisonController>(() => BonLivraisonController());
    // Get.lazyPut<CartController>(() => CartController());
    // Get.lazyPut<FactureController>(() => FactureController());
    // Get.lazyPut<FactureCreanceController>(() => FactureCreanceController());
    // Get.lazyPut<NumeroFactureController>(() => NumeroFactureController());
    // Get.lazyPut<GainController>(() => GainController());
    // Get.lazyPut<HistoryLivraisonController>(() => HistoryLivraisonController());
    // Get.lazyPut<HistoryRavitaillementController>(
    //     () => HistoryRavitaillementController());
    // Get.lazyPut<VenteCartController>(() => VenteCartController());
    // Get.lazyPut<ProduitModelController>(() => ProduitModelController());
    // Get.lazyPut<RestitutionController>(() => RestitutionController());
    // Get.lazyPut<LivraisonController>(() => LivraisonController());
    // Get.lazyPut<RavitaillementController>(() => RavitaillementController());
    // Get.lazyPut<StockGlobalController>(() => StockGlobalController());

    // Exploitations
    // Get.lazyPut<ProjetController>(() => ProjetController());
    // Get.lazyPut<DashboardExpController>(() => DashboardExpController());
    Get.lazyPut<NotifyExpController>(() => NotifyExpController());
    // Get.lazyPut<FourniseurController>(() => FourniseurController());
    // Get.lazyPut<ProductionExpController>(() => ProductionExpController());
    // Get.lazyPut<VersementController>(() => VersementController());

    // Logistique
    // Get.lazyPut<ApprovisionReceptionController>(
    //     () => ApprovisionReceptionController());
    // Get.lazyPut<ApprovisionnementController>(
    //     () => ApprovisionnementController());
    // Get.lazyPut<MaterielController>(() => MaterielController());
    // Get.lazyPut<TrajetController>(() => TrajetController());
    // Get.lazyPut<DashboardLogController>(() => DashboardLogController());
    // Get.lazyPut<EntretienController>(() => EntretienController());
    // Get.lazyPut<ObjetRemplaceController>(() => ObjetRemplaceController());
    // Get.lazyPut<EtatMaterielController>(() => EtatMaterielController());
    // Get.lazyPut<ImmobilierController>(() => ImmobilierController());
    // Get.lazyPut<MobilierController>(() => MobilierController());
    Get.lazyPut<NotifyLogController>(() => NotifyLogController());

    // Administration
    // Get.lazyPut<AdminDashboardController>(() => AdminDashboardController());
    Get.lazyPut<AdminNotifyController>(() => AdminNotifyController());

    // Update Version
    Get.lazyPut<UpdateController>(() => UpdateController());
  }
}
