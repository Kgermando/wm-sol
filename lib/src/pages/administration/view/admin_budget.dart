import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/administration/components/budgets/table_budget_previsionnel_dg.dart'; 
import 'package:wm_solution/src/pages/budgets/controller/budget_previsionnel_controller.dart';
import 'package:wm_solution/src/pages/budgets/controller/notify/budget_notify_controller.dart'; 

class AdminBudget extends StatefulWidget {
  const AdminBudget({super.key});

  @override
  State<AdminBudget> createState() => _AdminBudgetState();
}

class _AdminBudgetState extends State<AdminBudget> {
  final BudgetNotifyController budgetNotifyController = Get.find();
  final BudgetPrevisionnelController budgetPrevisionnelController = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Budgets";
  String subTitle = "Direteur de génerale";

  bool isOpen1 = false;
  bool isOpen2 = false;
  bool isOpen3 = false;
  bool isOpen4 = false;
  bool isOpen5 = false;
  bool isOpen6 = false;

  @override
  Widget build(BuildContext context) { 
    final headline6 = Theme.of(context).textTheme.headline6;
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;

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
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Card(
                                  color: Colors.blue.shade700,
                                  child: ExpansionTile(
                                    leading: const Icon(Icons.folder,
                                        color: Colors.white),
                                    title: Text('Dossier Budgets',
                                        style: (Responsive.isDesktop(context))
                                            ? headline6!
                                                .copyWith(color: Colors.white)
                                            : bodyLarge!.copyWith(
                                                color: Colors.white)),
                                    subtitle: Text(
                                        "Vous avez ${budgetNotifyController.itemCountDG} dossiers necessitent votre approbation",
                                        style: bodyMedium!
                                            .copyWith(color: Colors.white70)),
                                    initiallyExpanded: false,
                                    onExpansionChanged: (val) {
                                      setState(() {
                                        isOpen1 = !val;
                                      });
                                    },
                                    trailing: const Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.white),
                                    children: [
                                      TableBudgetPrevisionnelDG(budgetPrevisionnelController: budgetPrevisionnelController)
                                    ],
                                  )),
                            ])),
                  ))
            ],
          )),
    );
  }
}