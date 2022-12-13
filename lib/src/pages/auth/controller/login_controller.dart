import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wm_solution/src/api/auth/auth_api.dart';
import 'package:wm_solution/src/api/user/user_api.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/creances/creance_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/dettes/dette_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/personnels/personnels_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/personnels/user_actif_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/utils/info_system.dart';
import 'package:wm_solution/src/pages/administration/controller/admin_dashboard_controller.dart';
import 'package:wm_solution/src/pages/budgets/controller/dashboard_budget_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/dashboard/dashboard_com_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/dahsboard/dashboard_comptabilite_controller.dart';
import 'package:wm_solution/src/pages/exploitations/controller/dashboard/dashboard_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/dahboard/dashboard_finance_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/dashboard/dashboard_log_controller.dart';
import 'package:wm_solution/src/pages/mailling/controller/mailling_controller.dart';
import 'package:wm_solution/src/pages/marketing/controller/dahboard/dashboard_marketing_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/notify/dashboard_rh_controller.dart';

class LoginController extends GetxController {
  final AuthApi authApi = AuthApi();
  final UserApi userApi = UserApi();

  final _loadingLogin = false.obs;
  bool get isLoadingLogin => _loadingLogin.value;

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final TextEditingController matriculeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    matriculeController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void clear() {
    matriculeController.clear();
    passwordController.clear();
  }

  String? validator(String value) {
    if (value.isEmpty) {
      return 'Please this field must be filled';
    }
    return null;
  }

  void login() async {
    final form = loginFormKey.currentState!;
    if (form.validate()) {
      try {
        _loadingLogin.value = true;
        await authApi
            .login(matriculeController.text, passwordController.text)
            .then((value) {
          clear();
          _loadingLogin.value = false;
          if (value) {
            Get.put(UsersController());

            authApi.getUserId().then((userData) async {
              Get.put(ProfilController(), permanent: true);

              GetStorage box = GetStorage();
              box.write('userModel', json.encode(userData));

              var departement = jsonDecode(userData.departement);

              if (departement.first == "Administration") {
                Get.put(MaillingController());
                Get.put(PersonnelsController());
                Get.put(CreanceController());
                Get.put(DetteController());
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
                  Get.offAndToNamed(
                      ComptabiliteRoutes.comptabiliteJournalLivre);
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
                Get.put(PersonnelsController());
                Get.put(CreanceController());
                Get.put(DetteController());
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

              // GetLocalStorage().saveUser(userData);
              _loadingLogin.value = false;
              Get.snackbar("Authentification réussie",
                  "Bienvenue ${userData.prenom} dans l'interface ${InfoSystem().name()}",
                  backgroundColor: Colors.green,
                  icon: const Icon(Icons.check),
                  snackPosition: SnackPosition.TOP);
            });
          } else {
            _loadingLogin.value = false;
            Get.snackbar("Echec d'authentification",
                "Vérifier votre matricule et mot de passe",
                backgroundColor: Colors.red,
                icon: const Icon(Icons.close),
                snackPosition: SnackPosition.TOP);
          }
        });
      } catch (e) {
        _loadingLogin.value = false;
        Get.snackbar("Erreur lors de la connection", "$e",
            backgroundColor: Colors.red,
            icon: const Icon(Icons.close),
            snackPosition: SnackPosition.TOP);
      }
    }
  }

  void logout() async {
    try {
      _loadingLogin.value = true;
      await authApi.getUserId().then((value) {
        GetStorage box = GetStorage();
        // box.remove('idToken');
        // box.remove("userModel");
        // box.remove('accessToken');
        // box.remove('refreshToken');
        box.erase();
        Get.offAllNamed(UserRoutes.logout);
        Get.snackbar("Déconnexion réussie!", "",
            backgroundColor: Colors.green,
            icon: const Icon(Icons.check),
            snackPosition: SnackPosition.TOP);
        _loadingLogin.value = false;
      });
    } catch (e) {
      _loadingLogin.value = false;
      Get.snackbar("Erreur lors de la connection", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.close),
          snackPosition: SnackPosition.TOP);
    }
  }
}
