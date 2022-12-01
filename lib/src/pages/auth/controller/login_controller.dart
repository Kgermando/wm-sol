import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wm_solution/src/api/auth/auth_api.dart';
import 'package:wm_solution/src/api/user/user_api.dart';
import 'package:wm_solution/src/models/users/user_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/utils/info_system.dart';

class LoginController extends GetxController {
  final AuthApi authApi = AuthApi();
  final UserApi userApi = UserApi();

  final ProfilController profilController = Get.put(ProfilController());

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
          _loadingLogin.value = false;
          if (value) { 
            authApi.getUserId().then((user) async {
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
              await userApi.updateData(userModel).then((userData)async {
                clear();
                GetStorage box = GetStorage();  
                box.write('userModel', json.encode(user));
                
                var departement = jsonDecode(userData.departement);
                if (departement.first == "Administration") {
                  if (int.parse(userData.role) <= 2) {
                    Get.toNamed(AdminRoutes.adminDashboard);
                  } else {
                    Get.toNamed(AdminRoutes.adminLogistique);
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
                    Get.toNamed(
                        ComptabiliteRoutes.comptabiliteJournalLivre);
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

                // GetLocalStorage().saveUser(userData);
              });
              _loadingLogin.value = false;
              Get.snackbar("Authentification réussie",
                  "Bienvenue ${user.prenom} dans l'interface ${InfoSystem().name()}",
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
      authApi.getUserId().then((user) async {
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
        await userApi.updateData(userModel).then((value) {
          GetStorage box = GetStorage();
          box.remove('idToken');
          box.remove('accessToken');
          box.remove('refreshToken'); 
          Get.offAllNamed(UserRoutes.logout);
          Get.snackbar("Déconnexion réussie!", "",
              backgroundColor: Colors.green,
              icon: const Icon(Icons.check),
              snackPosition: SnackPosition.TOP);
        });
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
