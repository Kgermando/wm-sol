import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/budgets/components/budget_previsionnel/table_budget_previsionnel.dart';
import 'package:wm_solution/src/pages/budgets/controller/budget_previsionnel_controller.dart';
import 'package:wm_solution/src/widgets/loading.dart';

class BudgetPrevisionnelPage extends StatefulWidget {
  const BudgetPrevisionnelPage({super.key});

  @override
  State<BudgetPrevisionnelPage> createState() => _BudgetPrevisionnelPageState();
}

class _BudgetPrevisionnelPageState extends State<BudgetPrevisionnelPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Budgets";
  String subTitle = "budgets previsionnels";

  @override
  Widget build(BuildContext context) {
    final BudgetPrevisionnelController controller = Get.put(BudgetPrevisionnelController());
    return SafeArea(
      child: controller.obx(
          onLoading: loading(),
          onEmpty: const Text('Aucune donnée'),
          onError: (error) => Text(
              "Une erreur s'est produite $error veiller actualiser votre logiciel. Merçi."),
          (data) => Scaffold(
              key: scaffoldKey,
              appBar: headerBar(context, scaffoldKey, title, subTitle),
              drawer: const DrawerMenu(),
              floatingActionButton: FloatingActionButton.extended(
                label: const Text("Nouveau budget"),
                tooltip: "Générer un nouveau budget",
                icon: const Icon(Icons.add),
                onPressed: () {
                  newFicheDialog(controller);
                },
              ),
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
                          child: TableBudgetPrevisionnel(
                              departementBudgetList:
                                  controller.departementBudgetList,
                              controller: controller))),
                ],
              ))),
    );
  }

  newFicheDialog(BudgetPrevisionnelController controller) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Génerer la fiche de presence'),
              content: SizedBox(
                  height: 200,
                  width: 300,
                  child: controller.isLoading
                      ? loading()
                      : Form(
                          key: controller.formKey,
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              AutoSizeText(
                                "Feuille du ${DateFormat("dd-MM-yyyy HH:mm").format(DateTime.now())}",
                                style: TextStyle(color: Colors.red.shade700),
                              ),
                              const SizedBox(height: p20),
                              const Icon(Icons.co_present, size: p50)
                            ],
                          ))),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Annuler'),
                ),
                TextButton(
                  onPressed: () {
                    controller.submit();
                    Navigator.pop(context, 'ok');
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          });
        });
  }

  Future pickDateRange(BudgetPrevisionnelController controller) async {
    final initialDateRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now().add(const Duration(hours: 24 * 3)),
    );
    final newDateRange = await showDateRangePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.input,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 20),
      initialDateRange: controller.dateRange ?? initialDateRange,
    );

    if (newDateRange == null) return;

    setState(() => controller.dateRange = newDateRange);
  }
}