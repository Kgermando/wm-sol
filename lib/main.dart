import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wm_solution/src/api/auth/auth_api.dart';
import 'package:wm_solution/src/bindings/wm_binding.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/role_theme.dart';
import 'package:wm_solution/src/models/users/user_model.dart';
import 'package:wm_solution/src/pages/404/error.dart';
import 'package:wm_solution/src/routes/router.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/utils/info_system.dart';

void main() async {
  await GetStorage.init();
  UserModel user = await AuthApi().getUserId();

  runApp(Phoenix(child: MyApp(user: user)));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.user}) : super(key: key);
  final UserModel user;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("departement ${user.departement}");
    }
    String homeRoute = "";
    
    var departement = (user.departement == '-') ? ['-'] : jsonDecode(user.departement);
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
      } else if (departement.first == "Commercial et Marketing") {
        if (int.parse(user.role) <= 2) {
          homeRoute = ComMarketingRoutes.comMarketingDashboard;
        } else {
          homeRoute = ComMarketingRoutes.comMarketingAnnuaire;
        }
      } else if (departement.first == "Logistique") {
        if (int.parse(user.role) <= 2) {
          homeRoute = LogistiqueRoutes.logDashboard;
        } else {
          homeRoute = LogistiqueRoutes.logAnguinAuto;
        }
      } else if (departement.first == "Support") {
        homeRoute = AdminRoutes.adminDashboard;
      }
    }
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      popGesture: true,
      title: InfoSystem().name(),
      initialBinding: WMBindings(),
      initialRoute: homeRoute,
      unknownRoute: GetPage(
          name: '/not-found',
          page: () => const PageNotFound(),
          transition: Transition.fadeIn),
      getPages: getPages,
      theme: ThemeData(
          useMaterial3: true,
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            },
          ),
          scaffoldBackgroundColor: Colors.blue.shade50,
          primaryColor: Colors.white,
          primarySwatch: roleThemeSwatch(1),
          fontFamily: 'Poppins',
          colorScheme: ColorScheme.light(
            primary: mainColor,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(5.0),
              shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
                return RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0));
              }),
              textStyle: MaterialStateProperty.all(const TextStyle(
                color: Colors.white,
              )),
              backgroundColor: MaterialStateProperty.all(mainColor),
            ),
          ),
          // visualDensity: VisualDensity.adaptivePlatformDensity,
        )
    );
  }
}
