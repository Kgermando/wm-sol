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
    var departement = (profilController.user.departement == '-') 
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
          if (departement.first == 'Administration' || departement.first == 'Support')
          AdministrationNav(currentRoute: currentRoute, profilController: profilController, departement: departement),
          if (departement.first == 'Ressources Humaines' ||
              departement.first == 'Administration' ||
              departement.first == 'Support')
          RhNav(currentRoute: currentRoute, profilController: profilController, departement: departement),
          if (departement.first == 'Budgets' ||
              departement.first == 'Administration' ||
              departement.first == 'Support')
          BudgetNav(currentRoute: currentRoute, profilController: profilController, departement: departement),
          if (departement.first == 'Comptabilites' ||
              departement.first == 'Administration' ||
              departement.first == 'Support')
          ComptabiliteNav(currentRoute: currentRoute, profilController: profilController, departement: departement),
          if (departement.first == 'Finances' ||
              departement.first == 'Administration' ||
              departement.first == 'Support') 
          FinanceNav(currentRoute: currentRoute, profilController: profilController, departement: departement),
          if (departement.first == 'Commercial et Marketing' ||
              departement.first == 'Administration' ||
              departement.first == 'Support')
          MaketingNav(currentRoute: currentRoute, profilController: profilController, departement: departement),
          if (departement.first == 'Commercial et Marketing' ||
              departement.first == 'Administration' ||
              departement.first == 'Support')
            CommercialNav(
                currentRoute: currentRoute,
                profilController: profilController,
                departement: departement),
          if (departement.first == 'Exploitations' ||
              departement.first == 'Administration' ||
              departement.first == 'Support') 
          ExploitationNav(currentRoute: currentRoute, profilController: profilController, departement: departement),
          if (departement.first == 'Logistique' ||
              departement.first == 'Administration' ||
              departement.first == 'Support') 
          LogistiqueNav(currentRoute: currentRoute, profilController: profilController, departement: departement),
          if (Platform.isWindows)
          UpdateNav(currentRoute: currentRoute, profilController: profilController)
        ],
      ),
    );
  }
}

