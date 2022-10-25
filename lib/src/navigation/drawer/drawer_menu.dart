import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/navigation/drawer/components/administration_nav.dart';
import 'package:wm_solution/src/navigation/drawer/components/budget_nav.dart';
import 'package:wm_solution/src/navigation/drawer/components/commercial_marketing_nav.dart';
import 'package:wm_solution/src/navigation/drawer/components/comptabilite_nav.dart';
import 'package:wm_solution/src/navigation/drawer/components/exploitation_nav.dart';
import 'package:wm_solution/src/navigation/drawer/components/finance_nav.dart';
import 'package:wm_solution/src/navigation/drawer/components/logistique_nav.dart'; 
import 'package:wm_solution/src/navigation/drawer/components/rh_nav.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/utils/info_system.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfilController profilController = Get.put(ProfilController());
    final currentRoute = Get.currentRoute;
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
          AdministrationNav(currentRoute: currentRoute, profilController: profilController),
          RhNav(currentRoute: currentRoute, profilController: profilController),
          BudgetNav(currentRoute: currentRoute, profilController: profilController),
          ComptabiliteNav(currentRoute: currentRoute, profilController: profilController),
          FinanceNav(currentRoute: currentRoute, profilController: profilController),
          CommercialMaketingNav(currentRoute: currentRoute, profilController: profilController),
          ExploitationNav(currentRoute: currentRoute, profilController: profilController),
          LogistiqueNav(currentRoute: currentRoute, profilController: profilController)
        ],
      ),
    );
  }
}

