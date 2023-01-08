import 'package:flash_card/flash_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/administration/controller/admin_dashboard_controller.dart';
import 'package:wm_solution/src/pages/commercial/components/commercial/dashboard/courbe_vente_gain_mounth.dart';
import 'package:wm_solution/src/pages/commercial/components/commercial/dashboard/courbe_vente_gain_year.dart';
import 'package:wm_solution/src/pages/commercial/controller/dashboard/dashboard_com_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/dashboard/dash_pie_wdget.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/personnels/personnels_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/dash_number_widget.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());
  final AdminDashboardController controller = Get.find();
  final PersonnelsController personnelsController = Get.find();
  final DashboardComController dashboardcomController = Get.find();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Administration";
  String subTitle = "Dashboard";

  @override
  Widget build(BuildContext context) {
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
                        child: GetBuilder(builder: (AdminDashboardController controller) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                alignment: WrapAlignment.spaceEvenly,
                                children: [
                                  DashNumberWidget(
                                      gestureTapCallback: () {
                                        Get.toNamed(RhRoutes.rhPersonnelsPage);
                                      },
                                      number: '${controller.agentsCount}',
                                      title: 'Total agents',
                                      icon: Icons.group,
                                      color: Colors.blue.shade700),
                                  DashNumberWidget(
                                      gestureTapCallback: () {
                                        Get.toNamed(RhRoutes.rhUserActif);
                                      },
                                      number: '${controller.agentActifCount}',
                                      title: 'Agent Actifs',
                                      icon: Icons.person,
                                      color: Colors.green.shade700),
                                  DashNumberWidget(
                                      gestureTapCallback: () {
                                        Get.toNamed(
                                            BudgetRoutes.budgetDashboard);
                                      },
                                      number:
                                          "${NumberFormat.decimalPattern('fr').format(double.parse(controller.poursentExecution.toStringAsFixed(0)))} %",
                                      title: "Budgets",
                                      icon: Icons.monetization_on_outlined,
                                      color: Colors.purple.shade700),
                                  DashNumberWidget(
                                      gestureTapCallback: () {
                                        Get.toNamed(
                                            FinanceRoutes.transactionsDettes);
                                      },
                                      number:
                                          "${NumberFormat.decimalPattern('fr').format(controller.soldeDette)} ${monnaieStorage.monney}",
                                      title: 'Dette',
                                      icon: Icons.blur_linear_rounded,
                                      color: Colors.red.shade700),
                                  DashNumberWidget(
                                      gestureTapCallback: () {
                                        Get.toNamed(
                                            FinanceRoutes.transactionsCreances);
                                      },
                                      number:
                                          "${NumberFormat.decimalPattern('fr').format(controller.soldeCreance)} ${monnaieStorage.monney}",
                                      title: 'Créance',
                                      icon: Icons.money_off_csred,
                                      color: Colors.deepOrange.shade700),
                                  DashNumberWidget(
                                      gestureTapCallback: () {
                                        Get.toNamed(
                                            FinanceRoutes.financeDashboard);
                                      },
                                      number:
                                          "${NumberFormat.decimalPattern('fr').format(controller.depenses)} ${monnaieStorage.monney}",
                                      title: 'Dépenses',
                                      icon: Icons.monetization_on,
                                      color: Colors.pink.shade700),
                                  DashNumberWidget(
                                      gestureTapCallback: () {
                                        Get.toNamed(
                                            FinanceRoutes.financeDashboard);
                                      },
                                      number:
                                          "${NumberFormat.decimalPattern('fr').format(controller.disponible)} ${monnaieStorage.monney}",
                                      title: 'Disponible',
                                      icon: Icons.attach_money,
                                      color: Colors.teal.shade700),
                                  DashNumberWidget(
                                      gestureTapCallback: () {
                                        Get.toNamed(ComptabiliteRoutes
                                            .comptabiliteBilan);
                                      },
                                      number: '${controller.bilanCount}',
                                      title: 'Bilans',
                                      icon: Icons.blur_linear_rounded,
                                      color: Colors.blueGrey.shade700),
                                  DashNumberWidget(
                                      gestureTapCallback: () {
                                        Get.toNamed(
                                            ExploitationRoutes.expProjet);
                                      },
                                      number:
                                          '${controller.projetsApprouveCount}',
                                      title: 'Projets approuvés',
                                      icon: Icons.work,
                                      color: Colors.grey.shade700),
                                  DashNumberWidget(
                                      gestureTapCallback: () {
                                        Get.toNamed(
                                            MarketingRoutes.marketingDashboard);
                                      },
                                      number: '${controller.campaignCount}',
                                      title: 'Campagnes',
                                      icon: Icons.campaign,
                                      color: Colors.orange.shade700),
                                ],
                              ),
                              const SizedBox(height: p20),
                              ResponsiveChildWidget(
                                  flex1: 3,
                                  flex2: 1,
                                  child1: FlashCard(
                                      height: 400,
                                      width: MediaQuery.maybeOf(context)!
                                              .size
                                              .width /
                                          1.1,
                                      frontWidget: CourbeVenteGainYear(
                                          controller: dashboardcomController),
                                      backWidget: CourbeVenteGainMounth(
                                          controller: dashboardcomController)),
                                  child2: DashRHPieWidget(
                                      controller: personnelsController))
                            ])) ),
                  )) 
            ],
          )),
    );
  }
}
