import 'package:get/get.dart';
import 'package:wm_solution/src/models/archive/archive_model.dart';
import 'package:wm_solution/src/models/budgets/departement_budget_model.dart';
import 'package:wm_solution/src/models/budgets/ligne_budgetaire_model.dart';
import 'package:wm_solution/src/models/comptabilites/balance_comptes_model.dart';
import 'package:wm_solution/src/models/comptabilites/bilan_model.dart';
import 'package:wm_solution/src/models/rh/agent_model.dart';
import 'package:wm_solution/src/models/rh/paiement_salaire_model.dart';
import 'package:wm_solution/src/models/rh/perfomence_model.dart';
import 'package:wm_solution/src/models/rh/presence_model.dart';
import 'package:wm_solution/src/models/rh/transport_restauration_model.dart';
import 'package:wm_solution/src/models/users/user_model.dart';
import 'package:wm_solution/src/pages/archives/components/add_archive.dart';
import 'package:wm_solution/src/pages/archives/components/archive_pdf_viewer.dart';
import 'package:wm_solution/src/pages/archives/components/detail_archive.dart'; 
import 'package:wm_solution/src/pages/archives/views/archive_folder_page.dart';
import 'package:wm_solution/src/pages/archives/views/archives.dart';
import 'package:wm_solution/src/pages/auth/view/login_auth.dart';
import 'package:wm_solution/src/pages/auth/view/change_password_auth.dart';
import 'package:wm_solution/src/pages/auth/view/profil_auth.dart';
import 'package:wm_solution/src/pages/budgets/components/budget_previsionnel/detail_budget_previsionnel.dart';
import 'package:wm_solution/src/pages/budgets/components/ligne_budgetaire/ajout_ligne_budgetaire.dart';
import 'package:wm_solution/src/pages/budgets/components/ligne_budgetaire/detail_ligne_budgetaire.dart';
import 'package:wm_solution/src/pages/budgets/view/budget_previsionnel_page.dart';
import 'package:wm_solution/src/pages/budgets/view/dashboard_budget.dart';
import 'package:wm_solution/src/pages/budgets/view/dd_budget.dart';
import 'package:wm_solution/src/pages/budgets/view/historique_budgets.dart';
import 'package:wm_solution/src/pages/comptabilites/components/balance/detail_balance.dart';
import 'package:wm_solution/src/pages/comptabilites/components/bilan/detail_bilan.dart';
import 'package:wm_solution/src/pages/comptabilites/view/balance_comptabilite.dart';
import 'package:wm_solution/src/pages/comptabilites/view/bilan_comptabilite.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/dd_rh/users_actifs/detail._user.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/performences/add_performence_note.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/performences/detail_performence.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/personnels/add_personnel.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/personnels/detail_personne.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/personnels/update_personnel.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/presences/detail_presence.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/salaires/add_salaire.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/salaires/bulletin_salaire.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/transport_restauration/detail_transport_rest.dart';
import 'package:wm_solution/src/pages/ressource_humaines/view/dashboard_rh.dart';
import 'package:wm_solution/src/pages/ressource_humaines/view/dd_rh.dart';
import 'package:wm_solution/src/pages/ressource_humaines/view/performence_rh.dart';
import 'package:wm_solution/src/pages/ressource_humaines/view/personnels_rh.dart';
import 'package:wm_solution/src/pages/ressource_humaines/view/presence_rh.dart';
import 'package:wm_solution/src/pages/ressource_humaines/view/salaires_rh.dart';
import 'package:wm_solution/src/pages/ressource_humaines/view/transport_restauration_rh.dart';
import 'package:wm_solution/src/routes/routes.dart';

List<GetPage<dynamic>>? getPages = [
  // Settings
  // GetPage(name: SettingsRoutes.helps, page: page),
  // GetPage(name: SettingsRoutes.settings, page: page),
  // GetPage(name: SettingsRoutes.pageVerrouillage, page: page),
  // GetPage(name: SettingsRoutes.splash, page: page),

  // Archives
  GetPage(
      name: ArchiveRoutes.archives,
      page: () => const ArchiveFolderPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
    GetPage(
      name: ArchiveRoutes.archiveTable,
      page: () {
        ArchiveFolderModel  archiveFolderModel = Get.arguments as ArchiveFolderModel;
        return ArchiveData(archiveFolderModel: archiveFolderModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
    GetPage(
      name: ArchiveRoutes.addArchives,
      page: () {
        ArchiveFolderModel archiveFolderModel =
            Get.arguments as ArchiveFolderModel;
        return AddArchive(archiveFolderModel: archiveFolderModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ArchiveRoutes.archivesDetail,
      page: () {
        ArchiveModel archiveModel =
            Get.arguments as ArchiveModel;
        return DetailArchive(archiveModel: archiveModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ArchiveRoutes.archivePdf,
      page: () { 
        String url = Get.arguments as String;
        return ArchivePdfViewer(url: url);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),



  // UserRoutes
  GetPage(name: UserRoutes.login, page: () => const LoginAuth()),
  GetPage(name: UserRoutes.logout, page: () => const LoginAuth()),
  GetPage(name: UserRoutes.profil, page: () => const ProfileAuth()),
  GetPage(name: UserRoutes.forgotPassword, page: () => const ProfileAuth()),
  GetPage(
      name: UserRoutes.changePassword, page: () => const ChangePasswordAuth()),

  // RH
  GetPage(
      name: RhRoutes.rhDashboard,
      page: () => const DashboardRH(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: RhRoutes.rhDD,
      page: () => const DDRH(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: RhRoutes.rhPersonnelsPage,
      page: () => const PersonnelsPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: RhRoutes.rhPersonnelsAdd,
      page: () {
        List<AgentModel> personnelList = Get.arguments as List<AgentModel>;
        return AddPersonnel(personnelList: personnelList);
      }),
  GetPage(
      name: RhRoutes.rhPersonnelsDetail,
      page: () {
        AgentModel personne = Get.arguments as AgentModel;
        return DetailPersonne(personne: personne);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: RhRoutes.rhPersonnelsUpdate,
      page: () {
        AgentModel personne = Get.arguments as AgentModel;
        return UpdatePersonnel(personne: personne);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: RhRoutes.rhPaiement,
      page: () => const SalairesRH(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: RhRoutes.rhPaiementBulletin,
      page: () {
        PaiementSalaireModel salaire = Get.arguments as PaiementSalaireModel;
        return BulletinSalaire(salaire: salaire);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: RhRoutes.rhPaiementAdd,
      page: () {
        AgentModel personne = Get.arguments as AgentModel;
        return AddSalaire(personne: personne);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: RhRoutes.rhTransportRest,
      page: () => const TransportRestaurationRH(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: RhRoutes.rhTransportRestDetail,
      page: () {
        TransportRestaurationModel transportRestaurationModel =
            Get.arguments as TransportRestaurationModel;
        return DetailTransportRest(
            transportRestaurationModel: transportRestaurationModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: RhRoutes.rhPerformence,
      page: () => const PerformenceRH(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: RhRoutes.rhPerformenceDetail,
      page: () {
        PerformenceModel performenceModel = Get.arguments as PerformenceModel;
        return DetailPerformence(performenceModel: performenceModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: RhRoutes.rhPerformenceAddNote,
      page: () {
        PerformenceModel performenceModel = Get.arguments as PerformenceModel;
        return AddPerformenceNote(performenceModel: performenceModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: RhRoutes.rhPresence,
      page: () => const PresenceRH(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: RhRoutes.rhPresenceDetail,
      page: () {
        final PresenceModel presenceModel = Get.arguments as PresenceModel;
        return DetailPresence(presenceModel: presenceModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: RhRoutes.rhdetailUser,
      page: () {
        final UserModel userModel = Get.arguments as UserModel;
        return DetailUser(user: userModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),


  // Budgets
  GetPage(
      name: BudgetRoutes.budgetDashboard,
      page: () => const DashboardBudget(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: BudgetRoutes.budgetDD,
      page: () => const DDBudget(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
    name: BudgetRoutes.budgetBudgetPrevisionel,
    page: () => const BudgetPrevisionnelPage(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(seconds: 1)
  ),
  GetPage(
      name: BudgetRoutes.historiqueBudgetPrevisionel,
      page: () => const HistoriqueBudget(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
    name: BudgetRoutes.budgetBudgetPrevisionelDetail,
    page: () {
      final DepartementBudgetModel departementBudgetModel = Get.arguments as DepartementBudgetModel;
      return DetailBudgetPrevisionnel(departementBudgetModel: departementBudgetModel);
    },
    transition: Transition.cupertino,
    transitionDuration: const Duration(seconds: 1)
  ),
  GetPage(
      name: BudgetRoutes.budgetLignebudgetaireDetail,
      page: () {
        final LigneBudgetaireModel ligneBudgetaireModel =
            Get.arguments as LigneBudgetaireModel;
        return DetailLigneBudgetaire(ligneBudgetaireModel: ligneBudgetaireModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: BudgetRoutes.budgetLignebudgetaireAdd,
      page: () {
        final DepartementBudgetModel departementBudgetModel =
            Get.arguments as DepartementBudgetModel;
        return AjoutLigneBudgetaire(departementBudgetModel: departementBudgetModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),


  // Comptabilites
  GetPage(
      name: ComptabiliteRoutes.comptabiliteBalance,
      page: () => const BalanceComptabilite(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComptabiliteRoutes.comptabiliteBalanceDetail,
      page: () {
        final BalanceCompteModel balanceCompteModel =
            Get.arguments as BalanceCompteModel;
        return DetailBalance(balanceCompteModel: balanceCompteModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  
  GetPage(
      name: ComptabiliteRoutes.comptabiliteBilan,
      page: () => const BilanComptabilite(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComptabiliteRoutes.comptabiliteBilanDetail,
      page: () {
        final BilanModel bilanModel =
            Get.arguments as BilanModel;
        return DetailBilan(bilanModel: bilanModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),


  // DevisRoutes
];
