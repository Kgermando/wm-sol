import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/navigation/drawer/components/budget_nav.dart';
import 'package:wm_solution/src/navigation/drawer/components/commercial_marketing_nav.dart';
import 'package:wm_solution/src/navigation/drawer/components/comptabilite_nav.dart';
import 'package:wm_solution/src/navigation/drawer/components/finance_nav.dart'; 
import 'package:wm_solution/src/navigation/drawer/components/rh_nav.dart';
import 'package:wm_solution/src/utils/info_system.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentRoute = Get.currentRoute;
    return Drawer(
      child: ListView(
        shrinkWrap: true,
        children: [
          DrawerHeader(
              child: Image.asset(
            InfoSystem().logo(),
            width: 100,
            height: 100,
          )),
          RhNav(currentRoute: currentRoute),
          BudgetNav(currentRoute: currentRoute),
          ComptabiliteNav(currentRoute: currentRoute),
          FinanceNav(currentRoute: currentRoute),
          CommercialMaketingNav(currentRoute: currentRoute),
        ],
      ),
    );
  }
}

