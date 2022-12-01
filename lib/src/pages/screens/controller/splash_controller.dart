import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wm_solution/src/pages/administration/controller/admin_dashboard_controller.dart'; 
import 'package:wm_solution/src/pages/auth/controller/login_controller.dart';
import 'package:wm_solution/src/pages/budgets/controller/dashboard_budget_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/dashboard/dashboard_com_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/dahsboard/dashboard_comptabilite_controller.dart';
import 'package:wm_solution/src/pages/exploitations/controller/dashboard/dashboard_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/dahboard/dashboard_finance_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/dashboard/dashboard_log_controller.dart';
import 'package:wm_solution/src/pages/marketing/controller/dahboard/dashboard_marketing_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/personnels/personnels_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';

class SplashController extends GetxController {
  final LoginController loginController = Get.put(LoginController()); 
   final AdminDashboardController controller =
      Get.put(AdminDashboardController());
  final PersonnelsController personnelsController =
      Get.put(PersonnelsController());
  final DashboardComController dashboardcomController =
      Get.put(DashboardComController());
  final DashboardBudgetController dashboardBudgetController =
      Get.put(DashboardBudgetController());
  final DashboardMarketingController dashboardMarketingController =
      Get.put(DashboardMarketingController()); 

  final DashboardComptabiliteController dashboardComptabiliteController =
      Get.put(DashboardComptabiliteController()); 
  final DashboardExpController dashboardExpController =
      Get.put(DashboardExpController()); 
  final DashboardFinanceController dashboardFinanceController =
      Get.put(DashboardFinanceController());
  final DashboardLogController dashboardLogController =
      Get.put(DashboardLogController()); 

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
    await loginController.authApi.getUserId().then((userData) async {
      var departement = jsonDecode(userData.departement);
      if (departement.first == "Administration") {
        if (int.parse(userData.role) <= 2) {
          Get.toNamed(AdminRoutes.adminDashboard);
        } else {
          Get.toNamed(AdminRoutes.adminComptabilite);
        }
      } else if (departement.first == "Finances") {
        if (int.parse(userData.role) <= 2) {
          Get.toNamed(FinanceRoutes.financeDashboard);
        } else {
          Get.toNamed(FinanceRoutes.transactionsDettes);
        }
      } else if (departement.first == "Comptabilites") {
        if (int.parse(userData.role) <= 2) {
          Get.toNamed(ComptabiliteRoutes.comptabiliteDashboard);
        } else {
          Get.toNamed(ComptabiliteRoutes.comptabiliteJournalLivre);
        }
      } else if (departement.first == "Budgets") {
        if (int.parse(userData.role) <= 2) {
          Get.toNamed(BudgetRoutes.budgetBudgetPrevisionel);
        } else {
          Get.toNamed(BudgetRoutes.budgetBudgetPrevisionel);
        }
      } else if (departement.first == "Ressources Humaines") {
        if (int.parse(userData.role) <= 2) {
          Get.toNamed(RhRoutes.rhDashboard);
        } else {
          Get.toNamed(RhRoutes.rhPresence);
        }
      } else if (departement.first == "Exploitations") {
        if (int.parse(userData.role) <= 2) {
          Get.toNamed(ExploitationRoutes.expDashboard);
        } else {
          Get.toNamed(TacheRoutes.tachePage);
        }
      } else if (departement.first == "Marketing") {
        if (int.parse(userData.role) <= 2) {
          Get.toNamed(MarketingRoutes.marketingDashboard);
        } else {
          Get.toNamed(MarketingRoutes.marketingAnnuaire);
        }
      } else if (departement.first == "Commercial") {
        if (int.parse(userData.role) <= 2) {
          Get.toNamed(ComRoutes.comDashboard);
        } else {
          Get.toNamed(ComRoutes.comVente);
        }
      } else if (departement.first == "Logistique") {
        if (int.parse(userData.role) <= 2) {
          Get.toNamed(LogistiqueRoutes.logDashboard);
        } else {
          Get.toNamed(LogistiqueRoutes.logMateriel);
        }
      } else if (departement.first == "Support") {
        Get.toNamed(AdminRoutes.adminDashboard);
      }

    });
  }

 
}
