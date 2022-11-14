import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/budgets/controller/dashboard_budget_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/dash_number_budget_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class DashboardBudget extends StatefulWidget {
  const DashboardBudget({super.key});

  @override
  State<DashboardBudget> createState() => _DashboardBudgetState();
}

class _DashboardBudgetState extends State<DashboardBudget> {
  final DashboardBudgetController controller = Get.find();

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
                                            '${NumberFormat.decimalPattern('fr').format(controller.coutTotal)} \$',
                                        title: "Coût Total prévisionnel",
                                        icon: Icons.monetization_on,
                                        color: Colors.blue.shade700),
                                    DashNumberBudgetWidget(
                                        gestureTapCallback: () {
                                          Get.toNamed(BudgetRoutes
                                              .budgetBudgetPrevisionel); 
                                        },
                                        number:
                                            '${NumberFormat.decimalPattern('fr').format(controller.sommeEnCours)} \$',
                                        title: "Sommes en cours d'execution",
                                        icon: Icons.monetization_on_outlined,
                                        color: Colors.pink.shade700),
                                    DashNumberBudgetWidget(
                                        gestureTapCallback: () {
                                          Get.toNamed(BudgetRoutes
                                              .budgetBudgetPrevisionel);  
                                        },
                                        number:
                                            '${NumberFormat.decimalPattern('fr').format(controller.sommeRestantes)} \$',
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
                                const SizedBox(height: p30),
                                const TitleWidget(title: "Tableau de dépenses"),
                                const SizedBox(height: p10),
                                if (!Responsive.isMobile(context))
                                  Table(
                                    children: <TableRow>[
                                      tableDepartement(controller),
                                      tableCellRHSalaire(controller),
                                      tableCellRHTransRest(controller),
                                      tableCellExploitation(controller),
                                      tableCellEtatBesoin(controller),
                                      tableCellMarketing(controller)
                                    ],
                                  ),
                                if (Responsive.isMobile(context))
                                  Scrollbar(
                                    controller: controller.controllerTable,
                                    child: SingleChildScrollView(
                                      controller: controller.controllerTable,
                                      scrollDirection: Axis.horizontal,
                                      child: Container(
                                        constraints: BoxConstraints(
                                            minWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                2),
                                        child: Table(
                                          children: <TableRow>[
                                            tableDepartement(controller),
                                            tableCellRHSalaire(controller),
                                            tableCellRHTransRest(controller),
                                            tableCellExploitation(controller),
                                            tableCellEtatBesoin(controller),
                                            tableCellMarketing(controller)
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                              ]),
                        )),
                  ))
            ],
          )),
    );
  }

  TableRow tableDepartement(DashboardBudgetController controller) {
    final headline6 = Theme.of(context).textTheme.headline6;
    return TableRow(children: [
      Card(
        elevation: 10.0,
        shadowColor: mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          color: mainColor,
          padding: const EdgeInsets.all(16.0 * 0.75),
          child: AutoSizeText(
            "DEPENSES",
            maxLines: 1,
            style: headline6!.copyWith(color: Colors.white),
          ),
        ),
      ),
      Card(
        elevation: 10.0,
        shadowColor: mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          padding: const EdgeInsets.all(16.0 * 0.75),
          decoration: BoxDecoration(border: Border.all(color: mainColor)),
          child: AutoSizeText(
            "Coût Total".toUpperCase(),
            maxLines: 1,
            textAlign: TextAlign.center,
            style: headline6.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      Card(
        elevation: 10.0,
        shadowColor: mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          padding: const EdgeInsets.all(16.0 * 0.75),
          decoration: BoxDecoration(border: Border.all(color: mainColor)),
          child: AutoSizeText(
            "Caisse".toUpperCase(),
            maxLines: 1,
            textAlign: TextAlign.center,
            style: headline6.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      Card(
        elevation: 10.0,
        shadowColor: mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          padding: const EdgeInsets.all(16.0 * 0.75),
          decoration: BoxDecoration(border: Border.all(color: mainColor)),
          child: AutoSizeText(
            "Banque".toUpperCase(),
            maxLines: 1,
            textAlign: TextAlign.center,
            style: headline6.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      Card(
        elevation: 10.0,
        shadowColor: mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          padding: const EdgeInsets.all(16.0 * 0.75),
          decoration: BoxDecoration(border: Border.all(color: mainColor)),
          child: AutoSizeText(
            "Reste à trouver".toUpperCase(),
            maxLines: 1,
            textAlign: TextAlign.center,
            style: headline6.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ]);
  }

  TableRow tableCellRHSalaire(DashboardBudgetController controller) {
    final headline6 = Theme.of(context).textTheme.headline6;
    return TableRow(children: [
      Card(
        elevation: 10.0,
        shadowColor: Colors.red.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          color: Colors.red.shade700,
          padding: const EdgeInsets.all(16.0 * 0.75),
          child: AutoSizeText(
            "Salaire",
            maxLines: 1,
            style: headline6!.copyWith(color: Colors.white),
          ),
        ),
      ),
      Card(
        elevation: 10.0,
        shadowColor: Colors.red.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          padding: const EdgeInsets.all(16.0 * 0.75),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.red.shade700)),
          child: AutoSizeText(
            "${NumberFormat.decimalPattern('fr').format(controller.totalSalaire)} \$",
            maxLines: 1,
            textAlign: TextAlign.center,
            style: headline6,
          ),
        ),
      ),
      Card(
        elevation: 10.0,
        shadowColor: Colors.red.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          padding: const EdgeInsets.all(16.0 * 0.75),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.red.shade700)),
          child: AutoSizeText(
            "${NumberFormat.decimalPattern('fr').format(controller.caisseSalaire)} \$",
            maxLines: 1,
            textAlign: TextAlign.center,
            style: headline6,
          ),
        ),
      ),
      Card(
        elevation: 10.0,
        shadowColor: Colors.red.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          padding: const EdgeInsets.all(16.0 * 0.75),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.red.shade700)),
          child: AutoSizeText(
            "${NumberFormat.decimalPattern('fr').format(controller.banqueSalaire)} \$",
            maxLines: 1,
            textAlign: TextAlign.center,
            style: headline6,
          ),
        ),
      ),
      Card(
        elevation: 10.0,
        shadowColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          padding: const EdgeInsets.all(16.0 * 0.75),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.red.shade700)),
          child: AutoSizeText(
            "${NumberFormat.decimalPattern('fr').format(controller.finExterieurSalaire)} \$",
            maxLines: 1,
            textAlign: TextAlign.center,
            style: headline6,
          ),
        ),
      ),
    ]);
  }

  TableRow tableCellRHTransRest(DashboardBudgetController controller) {
    final headline6 = Theme.of(context).textTheme.headline6;
    return TableRow(children: [
      Card(
        elevation: 10.0,
        shadowColor: Colors.blue.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          color: Colors.blue.shade700,
          padding: const EdgeInsets.all(16.0 * 0.75),
          child: AutoSizeText(
            "Transport & Restauration",
            maxLines: 3,
            style: headline6!.copyWith(color: Colors.white),
          ),
        ),
      ),
      Card(
        elevation: 10.0,
        shadowColor: Colors.blue.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          padding: const EdgeInsets.all(16.0 * 0.75),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.blue.shade700)),
          child: AutoSizeText(
            "${NumberFormat.decimalPattern('fr').format(controller.totalTransRest)} \$",
            maxLines: 1,
            textAlign: TextAlign.center,
            style: headline6,
          ),
        ),
      ),
      Card(
        elevation: 10.0,
        shadowColor: Colors.blue.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          padding: const EdgeInsets.all(16.0 * 0.75),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.blue.shade700)),
          child: AutoSizeText(
            "${NumberFormat.decimalPattern('fr').format(controller.caisseTransRest)} \$",
            maxLines: 1,
            textAlign: TextAlign.center,
            style: headline6,
          ),
        ),
      ),
      Card(
        elevation: 10.0,
        shadowColor: Colors.blue.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          padding: const EdgeInsets.all(16.0 * 0.75),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.blue.shade700)),
          child: AutoSizeText(
            "${NumberFormat.decimalPattern('fr').format(controller.banqueTransRest)} \$",
            maxLines: 1,
            textAlign: TextAlign.center,
            style: headline6,
          ),
        ),
      ),
      Card(
        elevation: 10.0,
        shadowColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          padding: const EdgeInsets.all(16.0 * 0.75),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.blue.shade700)),
          child: AutoSizeText(
            "${NumberFormat.decimalPattern('fr').format(controller.finExterieurTransRest)} \$",
            maxLines: 1,
            textAlign: TextAlign.center,
            style: headline6,
          ),
        ),
      ),
    ]);
  }

  TableRow tableCellExploitation(DashboardBudgetController controller) {
    final headline6 = Theme.of(context).textTheme.headline6;
    return TableRow(children: [
      Card(
        elevation: 10.0,
        shadowColor: Colors.grey.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          color: Colors.grey.shade700,
          padding: const EdgeInsets.all(16.0 * 0.75),
          child: AutoSizeText(
            "Exploitations",
            maxLines: 1,
            style: headline6!.copyWith(color: Colors.white),
          ),
        ),
      ),
      Card(
        elevation: 10.0,
        shadowColor: Colors.grey.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          padding: const EdgeInsets.all(16.0 * 0.75),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.grey.shade700)),
          child: AutoSizeText(
            "${NumberFormat.decimalPattern('fr').format(controller.totalProjet)} \$",
            maxLines: 1,
            textAlign: TextAlign.center,
            style: headline6,
          ),
        ),
      ),
      Card(
        elevation: 10.0,
        shadowColor: Colors.grey.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          padding: const EdgeInsets.all(16.0 * 0.75),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.grey.shade700)),
          child: AutoSizeText(
            "${NumberFormat.decimalPattern('fr').format(controller.caisseProjet)} \$",
            maxLines: 1,
            textAlign: TextAlign.center,
            style: headline6,
          ),
        ),
      ),
      Card(
        elevation: 10.0,
        shadowColor: Colors.grey.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          padding: const EdgeInsets.all(16.0 * 0.75),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.grey.shade700)),
          child: AutoSizeText(
            "${NumberFormat.decimalPattern('fr').format(controller.banqueProjet)} \$",
            maxLines: 1,
            textAlign: TextAlign.center,
            style: headline6,
          ),
        ),
      ),
      Card(
        elevation: 10.0,
        shadowColor: Colors.grey.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          padding: const EdgeInsets.all(16.0 * 0.75),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.grey.shade700)),
          child: AutoSizeText(
            "${NumberFormat.decimalPattern('fr').format(controller.finExterieurProjet)} \$",
            maxLines: 1,
            textAlign: TextAlign.center,
            style: headline6,
          ),
        ),
      ),
    ]);
  }

  TableRow tableCellEtatBesoin(DashboardBudgetController controller) {
    final headline6 = Theme.of(context).textTheme.headline6;
    return TableRow(children: [
      Card(
        elevation: 10.0,
        shadowColor: Colors.purple.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          color: Colors.purple.shade700,
          padding: const EdgeInsets.all(16.0 * 0.75),
          child: AutoSizeText(
            "Devis",
            maxLines: 1,
            style: headline6!.copyWith(color: Colors.white),
          ),
        ),
      ),
      Card(
        elevation: 10.0,
        shadowColor: Colors.purple.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          padding: const EdgeInsets.all(16.0 * 0.75),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.purple.shade700)),
          child: AutoSizeText(
            "${NumberFormat.decimalPattern('fr').format(controller.totalDevis)} \$",
            maxLines: 1,
            textAlign: TextAlign.center,
            style: headline6,
          ),
        ),
      ),
      Card(
        elevation: 10.0,
        shadowColor: Colors.purple.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          padding: const EdgeInsets.all(16.0 * 0.75),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.purple.shade700)),
          child: AutoSizeText(
            "${NumberFormat.decimalPattern('fr').format(controller.caisseEtatBesion)} \$",
            maxLines: 1,
            textAlign: TextAlign.center,
            style: headline6,
          ),
        ),
      ),
      Card(
        elevation: 10.0,
        shadowColor: Colors.purple.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          padding: const EdgeInsets.all(16.0 * 0.75),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.purple.shade700)),
          child: AutoSizeText(
            "${NumberFormat.decimalPattern('fr').format(controller.banqueEtatBesion)} \$",
            maxLines: 1,
            textAlign: TextAlign.center,
            style: headline6,
          ),
        ),
      ),
      Card(
        elevation: 10.0,
        shadowColor: Colors.purple.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          padding: const EdgeInsets.all(16.0 * 0.75),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.purple.shade700)),
          child: AutoSizeText(
            "${NumberFormat.decimalPattern('fr').format(controller.finExterieurEtatBesion)} \$",
            maxLines: 1,
            textAlign: TextAlign.center,
            style: headline6,
          ),
        ),
      ),
    ]);
  }

  TableRow tableCellMarketing(DashboardBudgetController controller) {
    final headline6 = Theme.of(context).textTheme.headline6;
    return TableRow(children: [
      Card(
        elevation: 10.0,
        shadowColor: Colors.orange.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          color: Colors.orange.shade700,
          padding: const EdgeInsets.all(16.0 * 0.75),
          child: AutoSizeText(
            "Marketing",
            maxLines: 1,
            style: headline6!.copyWith(color: Colors.white),
          ),
        ),
      ),
      Card(
        elevation: 10.0,
        shadowColor: Colors.orange.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          padding: const EdgeInsets.all(16.0 * 0.75),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.orange.shade700)),
          child: AutoSizeText(
            "${NumberFormat.decimalPattern('fr').format(controller.totalCampaign)} \$",
            maxLines: 1,
            textAlign: TextAlign.center,
            style: headline6,
          ),
        ),
      ),
      Card(
        elevation: 10.0,
        shadowColor: Colors.orange.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          padding: const EdgeInsets.all(16.0 * 0.75),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.orange.shade700)),
          child: AutoSizeText(
            "${NumberFormat.decimalPattern('fr').format(controller.caisseCampaign)} \$",
            maxLines: 1,
            textAlign: TextAlign.center,
            style: headline6,
          ),
        ),
      ),
      Card(
        elevation: 10.0,
        shadowColor: Colors.orange.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          padding: const EdgeInsets.all(16.0 * 0.75),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.orange.shade700)),
          child: AutoSizeText(
            "${NumberFormat.decimalPattern('fr').format(controller.banqueCampaign)} \$",
            maxLines: 1,
            textAlign: TextAlign.center,
            style: headline6,
          ),
        ),
      ),
      Card(
        elevation: 10.0,
        shadowColor: Colors.orange.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          padding: const EdgeInsets.all(16.0 * 0.75),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.orange.shade700)),
          child: AutoSizeText(
            "${NumberFormat.decimalPattern('fr').format(controller.finExterieurCampaign)} \$",
            maxLines: 1,
            textAlign: TextAlign.center,
            style: headline6,
          ),
        ),
      ),
    ]);
  }
}
