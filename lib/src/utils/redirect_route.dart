import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:wm_solution/src/models/users/user_model.dart';
import 'package:wm_solution/src/routes/routes.dart';

String redirectRoute(UserModel user) {
  // final ProfilController profilController = Get.put(ProfilController());

  String homeRoute = '';

  if (kDebugMode) {
    print("departement ${user.departement}");
  }

  var departement =
      (user.departement == '-') ? ['-'] : jsonDecode(user.departement);

  if (departement.first == '-') {
    homeRoute = UserRoutes.login;
  } else {
    if (departement.first == "Administration") {
      if (int.parse(user.role) <= 2) {
        homeRoute = AdminRoutes.adminDashboard;
      } else {
        homeRoute = AdminRoutes.adminLogistique;
      }
    } else if (departement.first == "Finances") {
      if (int.parse(user.role) <= 2) {
        homeRoute = FinanceRoutes.financeDashboard;
      } else {
        homeRoute = FinanceRoutes.transactionsDettes;
      }
    } else if (departement.first == "Comptabilites") {
      if (int.parse(user.role) <= 2) {
        homeRoute = ComptabiliteRoutes.comptabiliteDashboard;
      } else {
        homeRoute = ComptabiliteRoutes.comptabiliteJournalLivre;
      }
    } else if (departement.first == "Budgets") {
      if (int.parse(user.role) <= 2) {
        homeRoute = BudgetRoutes.budgetDashboard;
      } else {
        homeRoute = BudgetRoutes.budgetBudgetPrevisionel;
      }
    } else if (departement.first == "Ressources Humaines") {
      if (int.parse(user.role) <= 2) {
        homeRoute = RhRoutes.rhDashboard;
      } else {
        homeRoute = RhRoutes.rhPresence;
      }
    } else if (departement.first == "Exploitations") {
      if (int.parse(user.role) <= 2) {
        homeRoute = ExploitationRoutes.expDashboard;
      } else {
        homeRoute = TacheRoutes.tachePage;
      }
    } else if (departement.first == "Marketing") {
      if (int.parse(user.role) <= 2) {
        homeRoute = MarketingRoutes.marketingDashboard;
      } else {
        homeRoute = MarketingRoutes.marketingAnnuaire;
      }
    } else if (departement.first == "Commercial") {
      if (int.parse(user.role) <= 2) {
        homeRoute = ComRoutes.comDashboard;
      } else {
        homeRoute = ComRoutes.comVente;
      }
    } else if (departement.first == "Logistique") {
      if (int.parse(user.role) <= 2) {
        homeRoute = LogistiqueRoutes.logDashboard;
      } else {
        homeRoute = LogistiqueRoutes.logMateriel;
      }
    } else if (departement.first == "Support") {
      homeRoute = AdminRoutes.adminDashboard;
    }
  }

  print('homeRoute $homeRoute');

  return homeRoute;
}
