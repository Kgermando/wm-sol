import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/navigation/drawer/components/administration_nav.dart';
import 'package:wm_solution/src/navigation/drawer/components/budget_nav.dart';
import 'package:wm_solution/src/navigation/drawer/components/commercial_nav.dart';
import 'package:wm_solution/src/navigation/drawer/components/marketing_nav.dart';
import 'package:wm_solution/src/navigation/drawer/components/comptabilite_nav.dart';
import 'package:wm_solution/src/navigation/drawer/components/exploitation_nav.dart';
import 'package:wm_solution/src/navigation/drawer/components/finance_nav.dart';
import 'package:wm_solution/src/navigation/drawer/components/logistique_nav.dart'; 
import 'package:wm_solution/src/navigation/drawer/components/rh_nav.dart';
import 'package:wm_solution/src/navigation/drawer/components/update_nav.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/utils/info_system.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfilController profilController = Get.find();
    final currentRoute = Get.currentRoute;
    List<dynamic> departementList = (profilController.user.departement == '-') 
      ? ["Support"] : jsonDecode(profilController.user.departement);
    // var departement = jsonDecode(profilController.user.departement);

 

    return Drawer(
      // backgroundColor: Colors.amber[50],
      child: ListView(
        shrinkWrap: true,
        children: [
          DrawerHeader(
              child: Image.asset(
            InfoSystem().logo(),
            width: 100,
            height: 100,
          )),
          for (var departement in departementList)
          if (departement == 'Administration' || departement == 'Support')
          AdministrationNav(currentRoute: currentRoute, profilController: profilController, 
            departement: departement),

          for (var departement in departementList)
          if (departement == 'Ressources Humaines' ||
              departement == 'Administration' ||
              departement == 'Support')
          RhNav(currentRoute: currentRoute, profilController: profilController, departement: departement),

          for (var departement in departementList)
          if (departement == 'Budgets' ||
              departement == 'Administration' ||
              departement == 'Support')
          BudgetNav(currentRoute: currentRoute, profilController: profilController, departement: departement),

          for (var departement in departementList)
          if (departement == 'Comptabilites' ||
              departement == 'Administration' ||
              departement == 'Support')
          ComptabiliteNav(currentRoute: currentRoute, profilController: profilController, departement: departement),

          for (var departement in departementList)
          if (departement == 'Finances' ||
              departement == 'Administration' ||
              departement == 'Support') 
          FinanceNav(currentRoute: currentRoute, profilController: profilController, departement: departement),

          for (var departement in departementList)
          if (departement == 'Marketing' ||
              departement == 'Administration' ||
              departement == 'Support')
          MaketingNav(currentRoute: currentRoute, profilController: profilController, departement: departement),

          for (var departement in departementList)
          if (departement == 'Commercial' ||
              departement == 'Administration' ||
              departement == 'Support')
            CommercialNav(
                currentRoute: currentRoute,
                profilController: profilController,
                departement: departement),

          for (var departement in departementList)
          if (departement == 'Exploitations' ||
              departement == 'Administration' ||
              departement == 'Support') 
          ExploitationNav(currentRoute: currentRoute, profilController: profilController, departement: departement),

          for (var departement in departementList)
          if (departement == 'Logistique' ||
              departement == 'Administration' ||
              departement == 'Support') 
          LogistiqueNav(currentRoute: currentRoute, profilController: profilController, departement: departement),

          if (Platform.isWindows)
          UpdateNav(currentRoute: currentRoute, profilController: profilController)
        ],
      ),
    );
  }
}

