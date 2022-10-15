import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/dashboard_comptabilite_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/dash_number_widget.dart';

class DashboardComptabilite extends StatefulWidget {
  const DashboardComptabilite({super.key});

  @override
  State<DashboardComptabilite> createState() => _DashboardComptabiliteState();
}

class _DashboardComptabiliteState extends State<DashboardComptabilite> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Comptabilite";
  String subTitle = "Dashboard";

  @override
  Widget build(BuildContext context) {
    final DashboardComptabiliteController controller = Get.put(DashboardComptabiliteController());
    return SafeArea(
      child: Scaffold(
          key: scaffoldKey,
          appBar: headerBar(context, scaffoldKey, title, subTitle),
          drawer: const DrawerMenu(),
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                  visible: !Responsive.isMobile(context),
                  child: const Expanded(flex: 1, child: DrawerMenu())),
              Expanded(
                  flex: 5,
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    physics: const ScrollPhysics(),
                    child: Container(
                        margin: const EdgeInsets.only(
                            top: p20, bottom: p8, right: p20, left: p20),
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: p20),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  alignment: WrapAlignment.spaceEvenly,
                                  children: [
                                    DashNumberWidget(
                                        gestureTapCallback: () {
                                          Get.toNamed(ComptabiliteRoutes
                                              .comptabiliteBilan);  
                                        },
                                        number: '${controller.bilanCount}',
                                        title: 'Bilans',
                                        icon: Icons.blur_linear_rounded,
                                        color: Colors.green.shade700),
                                    DashNumberWidget(
                                        gestureTapCallback: () {
                                          Get.toNamed(ComptabiliteRoutes
                                              .comptabiliteJournalLivre);  
                                        },
                                        number: '${controller.journalCount}',
                                        title: 'Journals',
                                        icon: Icons.backup_table,
                                        color: Colors.blue.shade700),
                                    DashNumberWidget(
                                        gestureTapCallback: () {
                                          Get.toNamed(ComptabiliteRoutes
                                              .comptabiliteCompteResultat); 
                                        },
                                        number: '${controller.compteResultatCount}',
                                        title: 'Comptes resultats',
                                        icon: Icons.view_compact_rounded,
                                        color: Colors.teal.shade700),
                                    DashNumberWidget(
                                        gestureTapCallback: () {
                                          Get.toNamed(ComptabiliteRoutes
                                              .comptabiliteBalance);
                                        },
                                        number: '${controller.balanceCount}',
                                        title: 'Balances',
                                        icon: Icons.balcony_outlined,
                                        color: Colors.orange.shade700),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                              ]),
                        )),
                  ))
            ],
          )),
    );
  }
}
