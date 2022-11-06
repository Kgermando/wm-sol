import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/budgets/components/budget_previsionnel/table_budget_previsionnel.dart';
import 'package:wm_solution/src/pages/budgets/controller/budget_previsionnel_controller.dart';
import 'package:wm_solution/src/widgets/button_widget.dart';
import 'package:wm_solution/src/widgets/loading.dart';

class BudgetPrevisionnelPage extends StatefulWidget {
  const BudgetPrevisionnelPage({super.key});

  @override
  State<BudgetPrevisionnelPage> createState() => _BudgetPrevisionnelPageState();
}

class _BudgetPrevisionnelPageState extends State<BudgetPrevisionnelPage> {
  final BudgetPrevisionnelController controller =
      Get.put(BudgetPrevisionnelController());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Budgets";
  String subTitle = "budgets previsionnels";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: controller.obx(
          onLoading: loadingPage(context),
          onEmpty: const Text('Aucune donnée'),
          onError: (error) => loadingError(context, error!),
          (data) => Scaffold(
              key: scaffoldKey,
              appBar: headerBar(context, scaffoldKey, title, subTitle),
              drawer: const DrawerMenu(),
              floatingActionButton: FloatingActionButton.extended(
                label: const Text("Nouveau budget"),
                tooltip: "Générer un nouveau budget",
                icon: const Icon(Icons.add),
                onPressed: () {
                  newFicheDialog();
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

  newFicheDialog() {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          String getPlageDate() {
            if (controller.dateRange == null) {
              return 'Date de Debut et Fin';
            } else {
              return '${DateFormat('dd/MM/yyyy').format(controller.dateRange!.start)} - ${DateFormat('dd/MM/yyyy').format(controller.dateRange!.end)}';
            }
          }

          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Génerer le Budget previsionnel'),
              content: SizedBox(
                  height: 300,
                  width: 500,
                  child: Form(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          titleWidget(),
                          departmentWidget(),
                          Container(
                            margin: const EdgeInsets.only(bottom: p20),
                            child: ButtonWidget(
                              text: getPlageDate(),
                              onClicked: () => setState(() {
                                pickDateRange(context);
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              }),
                            ),
                          )
                        ],
                      ))),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Annuler'),
                ),
                TextButton(
                  onPressed: () {
                    final form = controller.formKey.currentState!;
                    if (form.validate()) {
                      controller.submit();
                      form.reset();
                      Navigator.pop(context, 'ok');
                    }
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          });
        });
  }

  Widget titleWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.titleController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Titre',
          ),
          style: const TextStyle(),
          validator: (value) {
            if (value != null && value.isEmpty) {
              return 'Ce champs est obligatoire';
            } else {
              return null;
            }
          },
        ));
  }

  Widget departmentWidget() {
    return Container(
      margin: const EdgeInsets.only(bottom: p20),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Département',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: controller.departement,
        isExpanded: true,
        items: controller.departementList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        validator: (value) => value == null ? "Select departement" : null,
        onChanged: (value) {
          setState(() {
            controller.departement = value!;
          });
        },
      ),
    );
  }

  Future pickDateRange(BuildContext context) async {
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
