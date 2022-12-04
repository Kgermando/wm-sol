import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wm_solution/src/pages/administration/controller/admin_dashboard_controller.dart'; 
import 'package:wm_solution/src/pages/auth/controller/login_controller.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/budgets/controller/dashboard_budget_controller.dart'; 
import 'package:wm_solution/src/pages/commercial/controller/dashboard/dashboard_com_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/dahsboard/dashboard_comptabilite_controller.dart';
import 'package:wm_solution/src/pages/exploitations/controller/dashboard/dashboard_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/dahboard/dashboard_finance_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/dashboard/dashboard_log_controller.dart';
import 'package:wm_solution/src/pages/mailling/controller/mailling_controller.dart';
import 'package:wm_solution/src/pages/marketing/controller/dahboard/dashboard_marketing_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/notify/dashboard_rh_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/personnels/user_actif_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';

class SplashController extends GetxController {
  final LoginController loginController = Get.put(LoginController());
  
  final getStorge = GetStorage();
 

  @override
  void onReady() {
    super.onReady();
   String? idToken = getStorge.read('idToken');
    if (idToken != null) {
      Future.delayed(const Duration(milliseconds: 3000), () {
        
      });
      isLoggIn();
    } else {
      Get.offAllNamed(UserRoutes.login);
    }
  }

  void isLoggIn() async {
    Get.put(ProfilController());
    Get.put(UsersController());
    await loginController.authApi.getUserId().then((userData) async {
      var departement = jsonDecode(userData.departement);
      if (departement.first == "Administration") { 
        Get.put(MaillingController());
        Get.put(AdminDashboardController());
        Get.put(DashobardRHController());
        Get.put(DashboardComController());
        Get.put(DashboardBudgetController());
        Get.put(DashboardMarketingController());
        Get.put(DashboardComptabiliteController());
        Get.put(DashboardExpController());
        Get.put(DashboardFinanceController());
        Get.put(DashboardLogController()); 
        if (int.parse(userData.role) <= 2) {
          Get.offAndToNamed(AdminRoutes.adminDashboard);
        } else {
          Get.offAndToNamed(AdminRoutes.adminComptabilite);
        }
      } else if (departement.first == "Finances") { 
        Get.put(MaillingController());
        Get.put(DashboardFinanceController());
        if (int.parse(userData.role) <= 2) {
          Get.offAndToNamed(FinanceRoutes.financeDashboard);
        } else {
          Get.offAndToNamed(FinanceRoutes.transactionsDettes);
        }

      } else if (departement.first == "Comptabilites") { 
        Get.put(MaillingController());
        Get.put(DashboardComptabiliteController());
        if (int.parse(userData.role) <= 2) {
          Get.offAndToNamed(ComptabiliteRoutes.comptabiliteDashboard);
        } else {
          Get.offAndToNamed(ComptabiliteRoutes.comptabiliteJournalLivre);
        }

      } else if (departement.first == "Budgets") { 
        Get.put(MaillingController());
        Get.put(DashboardBudgetController());
        if (int.parse(userData.role) <= 2) {
          Get.offAndToNamed(BudgetRoutes.budgetBudgetPrevisionel);
        } else {
          Get.offAndToNamed(BudgetRoutes.budgetBudgetPrevisionel);
        }

      } else if (departement.first == "Ressources Humaines") { 
        Get.put(MaillingController());
        Get.put(DashobardRHController());
        if (int.parse(userData.role) <= 2) {
          Get.offAndToNamed(RhRoutes.rhDashboard);
        } else {
          Get.offAndToNamed(RhRoutes.rhPresence);
        }

      } else if (departement.first == "Exploitations") { 
        Get.put(MaillingController());
        Get.put(DashboardExpController());
        if (int.parse(userData.role) <= 2) {
          Get.offAndToNamed(ExploitationRoutes.expDashboard);
        } else {
          Get.offAndToNamed(TacheRoutes.tachePage);
        }

      } else if (departement.first == "Marketing") { 
        Get.put(MaillingController());
        Get.put(DashboardMarketingController());
        if (int.parse(userData.role) <= 2) {
          Get.offAndToNamed(MarketingRoutes.marketingDashboard);
        } else {
          Get.offAndToNamed(MarketingRoutes.marketingAnnuaire);
        }
      } else if (departement.first == "Commercial") { 
        Get.put(MaillingController()); 
        Get.put(DashboardComController());
        if (int.parse(userData.role) <= 2) {
          Get.offAndToNamed(ComRoutes.comDashboard);
        } else {
          Get.offAndToNamed(ComRoutes.comVente);
        }
      } else if (departement.first == "Logistique") { 
        Get.put(MaillingController());
        Get.put(DashboardLogController()); 
        if (int.parse(userData.role) <= 2) {
          Get.offAndToNamed(LogistiqueRoutes.logDashboard);
        } else {
          Get.offAndToNamed(LogistiqueRoutes.logMateriel);
        }
      } else if (departement.first == "Support") {
        Get.put(MaillingController());
        Get.put(AdminDashboardController());
        Get.put(DashobardRHController());
        Get.put(DashboardComController());
        Get.put(DashboardBudgetController());
        Get.put(DashboardMarketingController());
        Get.put(DashboardComptabiliteController());
        Get.put(DashboardExpController());
        Get.put(DashboardFinanceController());
        Get.put(DashboardLogController()); 
        
        Get.offAndToNamed(AdminRoutes.adminDashboard);
      }

    });
  }

 
}
