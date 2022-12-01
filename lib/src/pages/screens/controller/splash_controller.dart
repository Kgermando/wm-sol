import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart'; 
import 'package:wm_solution/src/pages/auth/controller/login_controller.dart';
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
        isLoggIn();
      });
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
