import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wm_solution/src/pages/auth/controller/login_controller.dart'; 
import 'package:wm_solution/src/routes/routes.dart';

class SplashController extends GetxController {
  final LoginController loginController  = Get.put(LoginController());
  final getStorge = GetStorage();


  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    String? idToken = getStorge.read('idToken');
    // int id = (idToken == null) ? 0 : int.parse(jsonDecode(idToken));
    if (getStorge.read("idToken") != null) {
      Future.delayed(const Duration(milliseconds: 3000), () {});
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
            Get.offAllNamed(AdminRoutes.adminDashboard);
          } else {
            Get.offAllNamed(AdminRoutes.adminLogistique);
          }
        } else if (departement.first == "Finances") {
          if (int.parse(userData.role) <= 2) {
            Get.offAllNamed(FinanceRoutes.financeDashboard);
          } else {
            Get.offAllNamed(FinanceRoutes.transactionsDettes);
          }
        } else if (departement.first == "Comptabilites") {
          if (int.parse(userData.role) <= 2) {
            Get.offAllNamed(ComptabiliteRoutes.comptabiliteDashboard);
          } else {
            Get.offAllNamed(ComptabiliteRoutes.comptabiliteJournalLivre);
          }
        } else if (departement.first == "Budgets") {
          if (int.parse(userData.role) <= 2) {
            Get.offAllNamed(BudgetRoutes.budgetBudgetPrevisionel);
          } else {
            Get.offAllNamed(BudgetRoutes.budgetBudgetPrevisionel);
          }
        } else if (departement.first == "Ressources Humaines") {
          if (int.parse(userData.role) <= 2) {
            Get.offAllNamed(RhRoutes.rhDashboard);
          } else {
            Get.offAllNamed(RhRoutes.rhPresence);
          }
        } else if (departement.first == "Exploitations") {
          if (int.parse(userData.role) <= 2) {
            Get.offAllNamed(ExploitationRoutes.expDashboard);
          } else {
            Get.offAllNamed(TacheRoutes.tachePage);
          }
        } else if (departement.first == "Marketing") {
          if (int.parse(userData.role) <= 2) {
            Get.offAllNamed(MarketingRoutes.marketingDashboard);
          } else {
            Get.offAllNamed(MarketingRoutes.marketingAnnuaire);
          }
        } else if (departement.first == "Commercial") {
          if (int.parse(userData.role) <= 2) {
            Get.offAllNamed(ComRoutes.comDashboard);
          } else {
            Get.offAllNamed(ComRoutes.comVente);
          }
        } else if (departement.first == "Logistique") {
          if (int.parse(userData.role) <= 2) {
            Get.offAllNamed(LogistiqueRoutes.logDashboard);
          } else {
            Get.offAllNamed(LogistiqueRoutes.logMateriel);
          }
        } else if (departement.first == "Support") {
          Get.offAllNamed(AdminRoutes.adminDashboard);
        }

        // GetLocalStorage().saveUser(userData);
      });  
    }

    // if (getStorge.read("id") != null) {
      // Future.delayed(const Duration(milliseconds: 3000), () {
      //   Get.offAllNamed(Routes.HOME);

        
      // });
    // } else {
    //   Get.offAllNamed(UserRoutes.login);
    // }

  @override
  void onClose() {
    super.onClose();
  }
}
