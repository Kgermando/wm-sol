import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/models/budgets/departement_budget_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/budgets/controller/budget_previsionnel_controller.dart';
import 'package:wm_solution/src/pages/budgets/controller/ligne_budgetaire_controller.dart';
import 'package:wm_solution/src/widgets/btn_widget.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class AjoutLigneBudgetaire extends StatefulWidget {
  const AjoutLigneBudgetaire({super.key, required this.departementBudgetModel});
  final DepartementBudgetModel departementBudgetModel;

  @override
  State<AjoutLigneBudgetaire> createState() => _AjoutLigneBudgetaireState();
}

class _AjoutLigneBudgetaireState extends State<AjoutLigneBudgetaire> {
  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Budgets";

  @override
  Widget build(BuildContext context) {
    final BudgetPrevisionnelController controller = Get.find();
    final LignBudgetaireController lignBudgetaireController = Get.find();

    return controller.obx(
        onLoading: loadingPage(context),
        onEmpty: const Text('Aucune donnée'),
        onError: (error) => loadingError(context, error!),
        (state) => Scaffold(
              key: scaffoldKey,
              appBar: headerBar(context, scaffoldKey, title,
                  widget.departementBudgetModel.title),
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
                              children: [
                                Card(
                                  elevation: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: p20),
                                    child: Form(
                                      key: lignBudgetaireController.formKey,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const TitleWidget(
                                              title: "Ligne Budgetaire"),
                                          const SizedBox(
                                            height: p30,
                                          ),
                                          nomLigneBudgetaireWidget(
                                                  lignBudgetaireController),
                                          // ResponsiveChildWidget(
                                          //     child1: nomLigneBudgetaireWidget(
                                          //         lignBudgetaireController),
                                          //     child2: uniteChoisieWidget(
                                          //         lignBudgetaireController)),
                                          ResponsiveChildWidget(
                                              child1: nombreUniteWidget(
                                                  lignBudgetaireController),
                                              child2: coutUnitaireWidget(
                                                  lignBudgetaireController)),
                                          coutTotalValeur(
                                              lignBudgetaireController),
                                          ResponsiveChildWidget(
                                              child1: caisseWidget(
                                                  lignBudgetaireController),
                                              child2: banqueWidget(
                                                  lignBudgetaireController)),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: finExterieurValeur(
                                                    lignBudgetaireController)
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: p20,
                                          ),
                                          BtnWidget(
                                              title: 'Soumettre',
                                              isLoading:
                                                  lignBudgetaireController
                                                      .isLoading,
                                              press: () {
                                                final form =
                                                    lignBudgetaireController
                                                        .formKey.currentState!;
                                                if (form.validate()) {
                                                  lignBudgetaireController
                                                      .submit(widget
                                                          .departementBudgetModel);
                                                  form.reset();
                                                }
                                              })
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )))
                ],
              ),
            ));
  }

  Widget nomLigneBudgetaireWidget(
      LignBudgetaireController lignBudgetaireController) {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: lignBudgetaireController.nomLigneBudgetaireController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Linge budgetaire',
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

  // Widget uniteChoisieWidget(LignBudgetaireController lignBudgetaireController) {
  //   return Container(
  //       margin: const EdgeInsets.only(bottom: p20),
  //       child: TextFormField(
  //         controller: lignBudgetaireController.uniteChoisieController,
  //         keyboardType: TextInputType.text,
  //         decoration: InputDecoration(
  //           border:
  //               OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
  //           labelText: 'Unité Choisie',
  //         ),
  //         style: const TextStyle(),
  //         validator: (value) {
  //           if (value != null && value.isEmpty) {
  //             return 'Ce champs est obligatoire';
  //           } else {
  //             return null;
  //           }
  //         },
  //       ));
  // }

  Widget nombreUniteWidget(LignBudgetaireController lignBudgetaireController) {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Nombre Unité',
          ),
          style: const TextStyle(),
          validator: (value) {
            if (value != null && value.isEmpty) {
              return 'Ce champs est obligatoire';
            } else {
              return null;
            }
          },
          onChanged: (value) => setState(() {
            lignBudgetaireController.nombreUniteController =
                (value == "") ? 1 : double.parse(value);
          }),
        ));
  }

  Widget coutUnitaireWidget(LignBudgetaireController lignBudgetaireController) {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Cout Unitaire',
          ),
          style: const TextStyle(),
          validator: (value) {
            if (value != null && value.isEmpty) {
              return 'Ce champs est obligatoire';
            } else {
              return null;
            }
          },
          onChanged: (value) => setState(() {
            lignBudgetaireController.coutUnitaireController =
                (value == "") ? 1 : double.parse(value);
          }),
        ));
  }

  Widget caisseWidget(LignBudgetaireController lignBudgetaireController) {
    final headline6 = Theme.of(context).textTheme.headline6;
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: TextFormField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  labelText: 'Caisse',
                ),
                style: const TextStyle(),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Ce champs est obligatoire';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) => setState(() {
                  lignBudgetaireController.caisseController =
                      (value == "") ? 1 : double.parse(value);
                }),
              ),
            ),
            Expanded(
                flex: 1,
                child: Container(
                    margin: const EdgeInsets.only(left: 10.0, bottom: 20.0),
                    child: Text(monnaieStorage.monney, style: headline6)))
          ],
        ));
  }

  Widget banqueWidget(LignBudgetaireController lignBudgetaireController) {
    final headline6 = Theme.of(context).textTheme.headline6;
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: TextFormField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  labelText: 'Banque',
                ),
                style: const TextStyle(),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Ce champs est obligatoire';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) => setState(() {
                  lignBudgetaireController.banqueController =
                      (value == "") ? 1 : double.parse(value);
                }),
              ),
            ),
            Expanded(
                flex: 1,
                child: Container(
                    margin: const EdgeInsets.only(left: 10.0, bottom: 20.0),
                    child: Text(monnaieStorage.monney, style: headline6)))
          ],
        ));
  }

  Widget coutTotalValeur(LignBudgetaireController lignBudgetaireController) {
    final headline6 = Theme.of(context).textTheme.headline6;
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    final coutToal = lignBudgetaireController.nombreUniteController *
        lignBudgetaireController.coutUnitaireController;
    return Container(
        margin: const EdgeInsets.only(left: 10.0, bottom: 20.0),
        child: Text(
            'Coût total: ${NumberFormat.decimalPattern('fr').format(double.parse(coutToal.toStringAsFixed(2)))} ${monnaieStorage.monney}',
            style: Responsive.isDesktop(context)
                ? headline6!.copyWith(color: Colors.blue.shade700)
                : bodyLarge!.copyWith(color: Colors.blue.shade700)));
  }

  Widget finExterieurValeur(LignBudgetaireController lignBudgetaireController) {
    final headline6 = Theme.of(context).textTheme.headline6;
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    final coutToal = lignBudgetaireController.nombreUniteController *
        lignBudgetaireController.coutUnitaireController;
    final fonds = lignBudgetaireController.caisseController +
        lignBudgetaireController.banqueController;
    final fondsAtrouver = coutToal - fonds;
    return Container(
        margin: const EdgeInsets.only(left: 10.0, bottom: 20.0),
        child: Text(
            'Reste à trouver: ${NumberFormat.decimalPattern('fr').format(double.parse(fondsAtrouver.toStringAsFixed(2)))} ${monnaieStorage.monney}',
            style: Responsive.isDesktop(context)
                ? headline6!.copyWith(color: Colors.red.shade700)
                : bodyLarge!.copyWith(color: Colors.red.shade700)));
  }
}
