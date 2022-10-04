import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/auth/auth_api.dart';
import 'package:wm_solution/src/api/user/user_api.dart';
import 'package:wm_solution/src/helpers/get_local_storage.dart';
import 'package:wm_solution/src/models/users/user_model.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/utils/info_system.dart';

class LoginController extends GetxController {
  final AuthApi authController = AuthApi();
  final UserApi userController = UserApi();

  final _loadingLogin = false.obs;
  bool get isLoadingLogin => _loadingLogin.value;

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final TextEditingController matriculeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
 
  final _user = UserModel(
          nom: '-',
          prenom: '-',
          email: '-',
          telephone: '-',
          matricule: '-',
          departement: '-',
          servicesAffectation: '-',
          fonctionOccupe: '-',
          role: '5',
          isOnline: 'false',
          createdAt: DateTime.now(),
          passwordHash: '-',
          succursale: '-')
      .obs;

  UserModel get user => _user.value;

  @override
  void onClose() {
    matriculeController.dispose();
    passwordController.dispose();
    super.onClose();
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
        await authController
            .login(matriculeController.text, passwordController.text)
            .then((value) {
          if (value) {
            authController.getUserId().then((user) async {
              _user.value = user;
              final userModel = UserModel(
                  id: user.id,
                  nom: user.nom,
                  prenom: user.prenom,
                  email: user.email,
                  telephone: user.telephone,
                  matricule: user.matricule,
                  departement: user.departement,
                  servicesAffectation: user.servicesAffectation,
                  fonctionOccupe: user.fonctionOccupe,
                  role: user.role,
                  isOnline: 'true',
                  createdAt: user.createdAt,
                  passwordHash: user.passwordHash,
                  succursale: user.succursale);
              await userController.updateData(userModel).then((userData) {
                if (userData.departement == "Administration") {
                  if (int.parse(userData.role) <= 2) {
                    Get.toNamed(AdminRoutes.adminDashboard);
                  } else {
                    Get.toNamed(AdminRoutes.adminLogistique);
                  }
                } else if (userData.departement == "Finances") {
                  if (int.parse(userData.role) <= 2) {
                    Get.toNamed(FinanceRoutes.financeDashboard);
                  } else {
                    Get.toNamed(FinanceRoutes.transactionsDettes);
                  }
                } else if (userData.departement == "Comptabilites") {
                  if (int.parse(userData.role) <= 2) {
                    Get.toNamed(ComptabiliteRoutes.comptabiliteDashboard);
                  } else {
                    Get.toNamed(ComptabiliteRoutes.comptabiliteJournalLivre);
                  }
                } else if (userData.departement == "Budgets") {
                  if (int.parse(userData.role) <= 2) {
                    Get.toNamed(BudgetRoutes.budgetBudgetPrevisionel);
                  } else {
                    Get.toNamed(BudgetRoutes.budgetBudgetPrevisionel);
                  }
                } else if (userData.departement == "Ressources Humaines") {
                  if (int.parse(userData.role) <= 2) {
                    Get.toNamed(RhRoutes.rhDashboard);
                  } else {
                    Get.toNamed(RhRoutes.rhPresence);
                  }
                } else if (userData.departement == "Exploitations") {
                  if (int.parse(userData.role) <= 2) {
                    Get.toNamed(ExploitationRoutes.expDashboard);
                  } else {
                    Get.toNamed(ExploitationRoutes.expTache);
                  }
                } else if (userData.departement == "Commercial et Marketing") {
                  if (int.parse(userData.role) <= 2) {
                    Get.toNamed(ComMarketingRoutes.comMarketingDashboard);
                  } else {
                    Get.toNamed(ComMarketingRoutes.comMarketingAnnuaire);
                  }
                } else if (userData.departement == "Logistique") {
                  if (int.parse(userData.role) <= 2) {
                    Get.toNamed(LogistiqueRoutes.logDashboard);
                  } else {
                    Get.toNamed(LogistiqueRoutes.logAnguinAuto);
                  }
                } else if (userData.departement == "Support") {
                  Get.toNamed(AdminRoutes.adminDashboard);
                }
              });
              _loadingLogin.value = false;
              Get.snackbar("Authentification réussie", "Bienvenue ${user.prenom} dans l'interface ${InfoSystem().name()}",
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
        Get.snackbar(
          "Erreur de connection",
          "$e",
          backgroundColor: Colors.red,
        );
      }
    }
  }

  void logout() async {
    final userModel = UserModel(
        id: user.id,
        nom: user.nom,
        prenom: user.prenom,
        email: user.email,
        telephone: user.telephone,
        matricule: user.matricule,
        departement: user.departement,
        servicesAffectation: user.servicesAffectation,
        fonctionOccupe: user.fonctionOccupe,
        role: user.role,
        isOnline: 'false',
        createdAt: user.createdAt,
        passwordHash: user.passwordHash,
        succursale: user.succursale);
    await userController.updateData(userModel).then((value) {
      authController.logout().then((response) async {
        GetLocalStorage().removeIdToken();
        GetLocalStorage().removeAccessToken();
        GetLocalStorage().removeRefreshToken();
        Get.offAllNamed(UserRoutes.logout);
        Get.snackbar("Déconnexion réussie!", "",
            backgroundColor: Colors.green,
            icon: const Icon(Icons.check),
            snackPosition: SnackPosition.TOP);
      }, onError: (err) {
        Get.snackbar(
          "Une erreur s'est produite",
          "$err",
          backgroundColor: Colors.red,
        );
      });
    });
  }
}
