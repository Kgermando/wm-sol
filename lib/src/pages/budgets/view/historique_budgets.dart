import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/budgets/components/historique/table_budget_previsionnel.dart';
import 'package:wm_solution/src/pages/budgets/controller/budget_previsionnel_controller.dart';
import 'package:wm_solution/src/widgets/loading.dart';

class HistoriqueBudget extends StatefulWidget {
  const HistoriqueBudget({super.key});

  @override
  State<HistoriqueBudget> createState() => _HistoriqueBudgetState();
}

class _HistoriqueBudgetState extends State<HistoriqueBudget> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Budgets";
  String subTitle = "historique budgets";

  @override
  Widget build(BuildContext context) {
    final BudgetPrevisionnelController controller =
        Get.put(BudgetPrevisionnelController());
    return SafeArea(
      child: controller.obx(
          onLoading: loadingPage(context),
          onEmpty: const Text('Aucune donnée'),
          onError: (error) => loadingError(context, error!),
          (data) => Scaffold(
              key: scaffoldKey,
              appBar: headerBar(context, scaffoldKey, title, subTitle),
              drawer: const DrawerMenu(),
              body: Row(
                children: [
                  Visibility(
                      visible: !Responsive.isMobile(context),
                      child: const Expanded(flex: 1, child: DrawerMenu())),
                  Expanded(
                      flex: 5,
                      child: Container(
                          margin: const EdgeInsets.only(
                              top: p20, right: p20, left: p20, bottom: p8),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: TableHistoriqueBudget(
                              departementBudgetList:
                                  controller.departementBudgetList,
                              controller: controller))),
                ],
              ))),
    );
  }
}
