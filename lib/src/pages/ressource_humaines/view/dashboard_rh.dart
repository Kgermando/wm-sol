import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/dashboard/calendar_widget.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/dashboard/dash_pie_wdget.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/notify/dashboard_notify_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/dash_number_rh_widget.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';

class DashboardRH extends StatefulWidget {
  const DashboardRH({Key? key}) : super(key: key);

  @override
  State<DashboardRH> createState() => _DashboardRHState();
}

class _DashboardRHState extends State<DashboardRH> {
  final DashobardNotifyController controller = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Ressources Humaines";
  String subTitle = "Dashboard";

  @override
  Widget build(BuildContext context) {
    var isMonth = '';
    final month = DateTime.now().month;

    if (month == 1) {
      isMonth = 'Janvier';
    } else if (month == 2) {
      isMonth = 'Fevrier';
    } else if (month == 3) {
      isMonth = 'Mars';
    } else if (month == 4) {
      isMonth = 'Avril';
    } else if (month == 5) {
      isMonth = 'Mai';
    } else if (month == 6) {
      isMonth = 'Juin';
    } else if (month == 7) {
      isMonth = 'Juillet';
    } else if (month == 8) {
      isMonth = 'Août';
    } else if (month == 9) {
      isMonth = 'Septembre';
    } else if (month == 10) {
      isMonth = 'Octobre';
    } else if (month == 11) {
      isMonth = 'Novembre';
    } else if (month == 12) {
      isMonth = 'Décembre';
    }
    return Scaffold(
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
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: p20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                alignment: WrapAlignment.spaceEvenly,
                                children: [
                                  Obx(() => DashNumberRHWidget(
                                      gestureTapCallback: () {
                                        Get.toNamed(RhRoutes.rhPersonnelsPage);
                                      },
                                      number: '${controller.agentsCount}',
                                      title: 'Total agents',
                                      icon: Icons.group,
                                      color: Colors.blue.shade700)) ,
                                  Obx(() => DashNumberRHWidget(
                                      gestureTapCallback: () {
                                        Get.toNamed(RhRoutes.rhPersonnelsPage);
                                      },
                                      number: '${controller.agentActifCount}',
                                      title: 'Agents Actifs',
                                      icon: Icons.person,
                                      color: Colors.green.shade700))  ,
                                  Obx(() => DashNumberRHWidget(
                                      gestureTapCallback: () {
                                        Get.toNamed(RhRoutes.rhPersonnelsPage);
                                      },
                                      number: '${controller.agentInactifCount}',
                                      title: 'Agents inactifs',
                                      icon: Icons.person_off,
                                      color: Colors.red.shade700))  ,
                                  Obx(() => DashNumberRHWidget(
                                      gestureTapCallback: () {
                                        Get.toNamed(RhRoutes.rhPersonnelsPage);
                                      },
                                      number: '${controller.agentFemmeCount}',
                                      title: 'Femmes',
                                      icon: Icons.female,
                                      color: Colors.purple.shade700))  ,
                                  Obx(() => DashNumberRHWidget(
                                      gestureTapCallback: () {
                                        Get.toNamed(RhRoutes.rhPersonnelsPage);
                                      },
                                      number: '${controller.agentHommeCount}',
                                      title: 'Hommes',
                                      icon: Icons.male,
                                      color: Colors.grey.shade700))  ,
                                  Obx(() => DashNumberRHWidget(
                                      gestureTapCallback: () {
                                        Get.toNamed(RhRoutes.rhPaiement);
                                      },
                                      number:
                                          "${NumberFormat.decimalPattern('fr').format(controller.totalEnveloppeSalaire)} \$",
                                      title: 'Enveloppe salariale',
                                      icon: Icons.monetization_on,
                                      color: Colors.teal.shade700))  ,
                                  Obx(() => DashNumberRHWidget(
                                      gestureTapCallback: () {
                                        Get.toNamed(RhRoutes.rhPersonnelsPage);
                                      },
                                      number: '${controller.agentNonPaye}',
                                      title: 'Non payés $isMonth',
                                      icon: Icons.person_remove,
                                      color: Colors.pink.shade700))  ,
                                ],
                              ),
                              const SizedBox(height: p20),
                              ResponsiveChildWidget(
                                  child1: DashRHPieWidget(
                                      controller:
                                          controller.personnelsController),
                                  child2: const CalendarWidget())
                            ]),
                      )),
                ))
          ],
        )
      );
  }
}
