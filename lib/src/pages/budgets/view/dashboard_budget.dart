import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/budgets/components/dahsboard/courbe_ligne_budgetaire.dart';
import 'package:wm_solution/src/pages/budgets/components/dahsboard/line_chart_sortie.dart';
import 'package:wm_solution/src/pages/budgets/controller/dashboard_budget_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/dash_number_budget_widget.dart';

class DashboardBudget extends StatefulWidget {
  const DashboardBudget({super.key});

  @override
  State<DashboardBudget> createState() => _DashboardBudgetState();
}

class _DashboardBudgetState extends State<DashboardBudget> {
  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());
  final DashboardBudgetController controller =
      Get.put(DashboardBudgetController());

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Budgets";
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: p20),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  alignment: WrapAlignment.spaceEvenly,
                                  children: [
                                    DashNumberBudgetWidget(
                                        gestureTapCallback: () {
                                          Get.toNamed(BudgetRoutes
                                              .budgetBudgetPrevisionel);
                                        },
                                        number:
                                            '${NumberFormat.decimalPattern('fr').format(controller.coutTotal)} ${monnaieStorage.monney}',
                                        title: "Coût Total prévisionnel",
                                        icon: Icons.monetization_on,
                                        color: Colors.blue.shade700),
                                    DashNumberBudgetWidget(
                                        gestureTapCallback: () {
                                          Get.toNamed(BudgetRoutes
                                              .budgetBudgetPrevisionel);
                                        },
                                        number:
                                            '${NumberFormat.decimalPattern('fr').format(controller.sommeEnCours)} ${monnaieStorage.monney}',
                                        title: "Sommes en cours d'execution",
                                        icon: Icons.monetization_on_outlined,
                                        color: Colors.pink.shade700),
                                    DashNumberBudgetWidget(
                                        gestureTapCallback: () {
                                          Get.toNamed(BudgetRoutes
                                              .budgetBudgetPrevisionel);
                                        },
                                        number:
                                            '${NumberFormat.decimalPattern('fr').format(controller.sommeRestantes)} ${monnaieStorage.monney}',
                                        title: "Sommes restantes",
                                        icon: Icons.monetization_on_outlined,
                                        color: Colors.red.shade700),
                                    DashNumberBudgetWidget(
                                        gestureTapCallback: () {
                                          Get.toNamed(BudgetRoutes
                                              .budgetBudgetPrevisionel);
                                        },
                                        number:
                                            "${NumberFormat.decimalPattern('fr').format(double.parse(controller.poursentExecution.toStringAsFixed(0)))} %",
                                        title: "Taux d'executions",
                                        icon: Icons.monetization_on_outlined,
                                        color: Colors.green.shade700),
                                  ],
                                ),
                                // const SizedBox(height: p30),
                                // LineChartSortie(
                                //     ligneBudgetaireList:
                                //         controller.ligneBudgetaireList),
                                const SizedBox(height: p30),
                                CourbeLignBudgetaire(ligneBudgetaireList: controller.ligneBudgetaireList)

                                        
                              ]),
                        )),
                  ))
            ],
          )),
    );
  }
}
