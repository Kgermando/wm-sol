import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/controllers/departement_notify_controller.dart';
import 'package:wm_solution/src/helpers/get_local_storage.dart';
import 'package:wm_solution/src/models/users/user_model.dart';
import 'package:wm_solution/src/navigation/drawer/components/actionnaire_nav.dart';
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
import 'package:wm_solution/src/navigation/drawer/drawer_widget.dart';
import 'package:wm_solution/src/routes/routes.dart'; 
import 'package:wm_solution/src/utils/info_system.dart'; 

class DrawerMenu extends GetView<DepartementNotifyCOntroller> {
  const DrawerMenu({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final currentRoute = Get.currentRoute; 
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return Drawer( 
        child: FutureBuilder<UserModel>(
            future: GetLocalStorage().read(),
            builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
              if (snapshot.hasData) {
                UserModel? user = snapshot.data;
                List<dynamic> departementList = (user!.departement =='-')
                  ? ["Support"]
                  : jsonDecode(user.departement); 
                int userRole = int.parse(user.role);
                return ListView(
                  shrinkWrap: true,
                  children: [
                    DrawerHeader(
                        child: Image.asset(
                      InfoSystem().logo(),
                      width: 100,
                      height: 100,
                    )), 
                    if (departementList.contains('Administration') ||
                        departementList.contains('Actionnaire') ||
                        departementList.contains('Support')) 
                    ActionnaireNav(
                          currentRoute: currentRoute,
                          departementList: departementList),
                    if(departementList.contains('Administration') ||
                      departementList.contains('Support')) 
                     AdministrationNav(
                      currentRoute: currentRoute,
                      user: user,
                      departementList: departementList,
                      controller: controller),
                    
                    if (departementList.contains('Ressources Humaines') ||
                        departementList.contains('Administration') ||
                        departementList.contains('Support')) 
                        RhNav(
                          currentRoute: currentRoute,
                          user: user,
                          departementList: departementList,
                          controller: controller), 

                    if (departementList.contains('Budgets') ||
                        departementList.contains('Administration') ||
                        departementList.contains('Support')) 
                      BudgetNav(
                          currentRoute: currentRoute,
                          user: user,
                          departementList: departementList,
                          controller: controller),

                    if (departementList.contains('Comptabilites') ||
                        departementList.contains('Administration') ||
                        departementList.contains('Support'))  
                      ComptabiliteNav(
                          currentRoute: currentRoute,
                          user: user,
                          departementList: departementList,
                          controller: controller),

                    if (departementList.contains('Finances') ||
                        departementList.contains('Administration') ||
                        departementList.contains('Support'))       
                        FinanceNav(
                          currentRoute: currentRoute,
                          user: user,
                          departementList: departementList,
                          controller: controller),


                    if (departementList.contains('Marketing') ||
                        departementList.contains('Administration') ||
                        departementList.contains('Support')) 
                      MaketingNav(
                          currentRoute: currentRoute,
                          user: user,
                          departementList: departementList,
                          controller: controller),


                    if (departementList.contains('Commercial') ||
                        departementList.contains('Administration') ||
                        departementList.contains('Support'))  
                      CommercialNav(
                          currentRoute: currentRoute,
                          user: user,
                          departementList: departementList,
                          controller: controller),


                    if (departementList.contains('Exploitations') ||
                        departementList.contains('Administration') ||
                        departementList.contains('Support'))  
                        ExploitationNav(
                          currentRoute: currentRoute,
                          user: user,
                          departementList: departementList,
                          controller: controller),


                    if (departementList.contains('Logistique') ||
                        departementList.contains('Administration') ||
                        departementList.contains('Support')) 
                        LogistiqueNav(
                          currentRoute: currentRoute,
                          user: user,
                          departementList: departementList,
                          controller: controller),
                          
                    if (userRole <= 3)
                      DrawerWidget(
                        selected: currentRoute ==
                            LogistiqueRoutes.logApprovisionReception,
                        icon: Icons.multiline_chart_sharp,
                        sizeIcon: 20.0,
                        title: 'Acc. Reception',
                        style: bodyMedium!,
                        onTap: () {
                          Get.toNamed(
                              LogistiqueRoutes.logApprovisionReception);
                        }),
                    DrawerWidget(
                        selected: currentRoute == ArchiveRoutes.archivesFolder,
                        icon: Icons.archive,
                        sizeIcon: 20.0,
                        title: 'Archives',
                        style: bodyMedium!,
                        onTap: () {
                          Navigator.pushNamed(context, ArchiveRoutes.archivesFolder);
                          // Navigator.of(context).pop();
                        }),
                    if (userRole <= 2)
                      DrawerWidget(
                        selected:
                          currentRoute == RhRoutes.rhPerformence,
                        icon: Icons.checklist_outlined,
                        sizeIcon: 20.0,
                        title: 'Performences',
                        style: bodyMedium,
                        onTap: () {
                          Get.toNamed(RhRoutes.rhPerformence);
                          // Navigator.of(context).pop();
                        }),


                    if (Platform.isWindows)
                      UpdateNav(
                          currentRoute: currentRoute,
                          user: user,
                      )
                  ],
                );
              } else {
                return Column(
                  children: const [
                    SizedBox(height: p20),
                    CircularProgressIndicator(),
                  ],
                );
              }
            }));
  }
}
