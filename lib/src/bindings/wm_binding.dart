import 'package:get/get.dart';
import 'package:wm_solution/src/controllers/departement_notify_controller.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/screens/controller/splash_controller.dart';
import 'package:wm_solution/src/pages/update/controller/update_controller.dart';

class WMBindings extends Bindings {
  @override
  void dependencies() async {
    Get.put<SplashController>(SplashController());
    Get.put<DepartementNotifyCOntroller>(DepartementNotifyCOntroller());

    // Authentification
    // Get.put<LoginController>(LoginController());
    // Get.putAsync(() async => ProfilController());
    Get.put(ProfilController());

    // // Mail
    // Get.put<MaillingController>(MaillingController());

    // // Personnels & Roles
    // Get.put<PersonnelsRolesController>(PersonnelsRolesController());

    // // RH
    // Get.put<DashobardRHController>(DashobardRHController());
    // Get.put<PersonnelsController>(PersonnelsController());

    // // Budgets
    // Get.put<DashboardBudgetController>(DashboardBudgetController());

    // // Comptabilites
    // Get.put<DashboardComptabiliteController>(DashboardComptabiliteController());

    // // Devis
    // // Get.put<DevisController>(DevisController());
    // // Get.put<DevisListObjetController>(DevisListObjetController());
    // Get.put<DevisNotifyController>(DevisNotifyController());

    // // Finances
    // Get.put<DashboardFinanceController>(DashboardFinanceController());
    // Get.put<BanqueNameController>(BanqueNameController());
    // Get.put<CaisseNameController>(CaisseNameController());
    // Get.put<FinExterieurNameController>(FinExterieurNameController());
    // Get.put<ObservationNotifyController>(ObservationNotifyController());

    // // Marketing
    // Get.put<AgendaController>(AgendaController());

    // // Commercial
    // Get.put<DashboardComController>(DashboardComController());
    // Get.put<AchatController>(AchatController());
    // Get.put<CartController>(CartController());

    // // Exploitations
    // // Get.put<ProjetController>(ProjetController());
    // Get.put<DashboardExpController>(DashboardExpController());

    // // Logistique
    // Get.put<DashboardLogController>(DashboardLogController());

    // Update Version
    Get.put<UpdateController>(UpdateController());
  }
}
