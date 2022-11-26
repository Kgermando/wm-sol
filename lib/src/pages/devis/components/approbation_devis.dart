import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/models/devis/devis_models.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/budgets/controller/budget_previsionnel_controller.dart';
import 'package:wm_solution/src/pages/budgets/controller/ligne_budgetaire_controller.dart';
import 'package:wm_solution/src/pages/devis/controller/devis_controller.dart';
import 'package:wm_solution/src/widgets/responsive_child3_widget.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class ApprobationDevis extends StatefulWidget {
  const ApprobationDevis(
      {super.key, required this.devisModel, required this.controller, required this.profilController});
  final DevisModel devisModel;
  final DevisController controller;
  final ProfilController profilController;

  @override
  State<ApprobationDevis> createState() => _ApprobationDevisState();
}

class _ApprobationDevisState extends State<ApprobationDevis> {
  @override
  Widget build(BuildContext context) {
    return approbationWidget(widget.controller, widget.profilController);
  }

  Widget approbationWidget(
      DevisController controller, ProfilController profilController) {
        List<dynamic> depList = jsonDecode(profilController.user.departement);
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(p10),
        border: Border.all(
          color: Colors.red.shade700,
          width: 2.0,
        ),
      ),
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: p20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TitleWidget(title: "Approbations"),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.add_task, color: Colors.green.shade700)),
                ],
              ),
              const SizedBox(height: p20),
              Divider(color: Colors.red[10]),
              Padding(
                  padding: const EdgeInsets.all(p10),
                  child: ResponsiveChildWidget(
                      flex1: 1,
                      flex2: 4,
                      child1: Text("Directeur générale", style: bodyLarge),
                      child2: Column(
                        children: [
                          ResponsiveChild3Widget(
                              flex1: 2,
                              flex2: 3,
                              flex3: 2,
                              child1: Column(
                                children: [
                                  const Text("Approbation"),
                                  const SizedBox(height: p20),
                                  Text(
                                      widget.devisModel
                                          .approbationDG,
                                      style: bodyLarge!.copyWith(
                                          color:
                                              (widget.devisModel
                                                          .approbationDG ==
                                                      "Unapproved")
                                                  ? Colors.red.shade700
                                                  : Colors.green.shade700)),
                                ],
                              ),
                              child2: (widget.devisModel
                                          .approbationDG ==
                                      "Unapproved")
                                  ? Column(
                                      children: [
                                        const Text("Motif"),
                                        const SizedBox(height: p20),
                                        Text(widget.devisModel
                                            .motifDG),
                                      ],
                                    )
                                  : Container(),
                              child3: (widget.devisModel
                                          .approbationDG ==
                                      "Unapproved")
                                  ? Column(
                                      children: [
                                        const Text("Signature"),
                                        const SizedBox(height: p20),
                                        Text(widget.devisModel
                                            .signatureDG),
                                      ],
                                    )
                                  : Container()),
                          if (widget.devisModel.approbationDD == "Approved" &&
                              widget.devisModel.approbationDG == '-' &&
                              profilController.user.fonctionOccupe ==
                                  "Directeur générale")
                            Padding(
                                padding: const EdgeInsets.all(p10),
                                child: ResponsiveChildWidget(
                                    child1: approbationDGWidget(controller),
                                    child2: (controller.approbationDG ==
                                            "Unapproved")
                                        ? motifDGWidget(controller)
                                        : Container())),
                        ],
                      ))),
              const SizedBox(height: p20),
              Divider(color: Colors.red[10]),
              Padding(
                  padding: const EdgeInsets.all(p10),
                  child: ResponsiveChildWidget(
                      flex1: 1,
                      flex2: 4,
                      child1:
                          Text("Directeur de departement", style: bodyLarge),
                      child2: Column(
                        children: [
                          ResponsiveChild3Widget(
                              flex1: 2,
                              flex2: 3,
                              flex3: 2,
                              child1: Column(
                                children: [
                                  const Text("Approbation"),
                                  const SizedBox(height: p20),
                                  Text(
                                      widget.devisModel
                                          .approbationDD,
                                      style: bodyLarge.copyWith(
                                          color:
                                              (widget.devisModel
                                                          .approbationDD ==
                                                      "Unapproved")
                                                  ? Colors.red.shade700
                                                  : Colors.green.shade700)),
                                ],
                              ),
                              child2: (widget.devisModel
                                          .approbationDD ==
                                      "Unapproved")
                                  ? Column(
                                      children: [
                                        const Text("Motif"),
                                        const SizedBox(height: p20),
                                        Text(widget.devisModel
                                            .motifDD),
                                      ],
                                    )
                                  : Container(),
                              child3: Column(
                                children: [
                                  const Text("Signature"),
                                  const SizedBox(height: p20),
                                  Text(widget
                                      .devisModel.signatureDD),
                                ],
                              )),
                          if (widget.devisModel.approbationDD ==
                                  '-' &&
                              profilController.user.fonctionOccupe ==
                                  "Directeur de departement")
                            Padding(
                                padding: const EdgeInsets.all(p10),
                                child: ResponsiveChildWidget(
                                    child1: approbationDDWidget(controller),
                                    child2: (controller.approbationDD ==
                                            "Unapproved")
                                        ? motifDDWidget(controller)
                                        : Container())),
                        ],
                      ))),
              const SizedBox(height: p20),
              Divider(color: Colors.red[10]),
              Padding(
                  padding: const EdgeInsets.all(p10),
                  child: ResponsiveChildWidget(
                      flex1: 1,
                      flex2: 4,
                      child1: Text("Budget", style: bodyLarge),
                      child2: Column(
                        children: [
                          ResponsiveChild3Widget(
                              child1: Column(
                                children: [
                                  const Text("Approbation"),
                                  const SizedBox(height: p20),
                                  Text(
                                      widget.devisModel
                                          .approbationBudget,
                                      style: bodyLarge.copyWith(
                                          color:
                                              (widget.devisModel
                                                          .approbationBudget ==
                                                      "Unapproved")
                                                  ? Colors.red.shade700
                                                  : Colors.green.shade700)),
                                ],
                              ),
                              child2: (widget.devisModel
                                          .approbationBudget ==
                                      "Unapproved")
                                  ? Column(
                                      children: [
                                        const Text("Motif"),
                                        const SizedBox(height: p20),
                                        Text(widget.devisModel
                                            .motifBudget),
                                      ],
                                    )
                                  : Container(),
                              child3: Column(
                                children: [
                                  const Text("Signature"),
                                  const SizedBox(height: p20),
                                  Text(widget.devisModel
                                      .signatureBudget),
                                ],
                              )),
                          const SizedBox(height: p20),
                          ResponsiveChildWidget(
                              flex1: 2,
                              flex2: 2,
                              child1: Column(
                                children: [
                                  const Text("Ligne Budgetaire"),
                                  const SizedBox(height: p20),
                                  Text(
                                      widget.devisModel
                                          .ligneBudgetaire,
                                      style: bodyLarge.copyWith(
                                          color: Colors.purple.shade700)),
                                ],
                              ),
                              child2: Column(
                                children: [
                                  const Text("Ressource"),
                                  const SizedBox(height: p20),
                                  Text(
                                      widget
                                          .devisModel.ressource,
                                      style: bodyLarge.copyWith(
                                          color: Colors.purple.shade700)),
                                ],
                              )),
                          if (widget.devisModel.approbationDG == "Approved" &&
                                  widget.devisModel
                                      .approbationBudget ==
                                  '-' &&
                              profilController.user.fonctionOccupe ==
                                  "Directeur de budget" ||
                              depList.contains('Budgets') &&
                              widget.devisModel.approbationBudget == '-' &&
                                  profilController.user.fonctionOccupe ==
                                      "Directeur de finance" ||
                              depList.contains('Budgets') &&
                              widget.devisModel.approbationBudget == '-' &&
                              profilController.user.fonctionOccupe ==
                                      "Directeur de departement" ||
                              depList.contains('Budgets') &&
                              widget.devisModel.approbationBudget == '-' &&
                              profilController.user.fonctionOccupe ==
                                      "Directeur générale")
                            Padding(
                              padding: const EdgeInsets.all(p10),
                              child: Form(
                                key: controller.formKeyBudget,
                                child: Column(
                                  children: [
                                    ResponsiveChildWidget(
                                        child1:
                                            ligneBudgtaireWidget(controller),
                                        child2: resourcesWidget(controller)),
                                    ResponsiveChildWidget(
                                        child1:
                                            approbationBudgetWidget(controller),
                                        child2: (controller.approbationBudget ==
                                                "Unapproved")
                                            ? motifBudgetWidget(controller)
                                            : Container())
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ))),
              const SizedBox(height: p20),
              Divider(color: Colors.red[10]),
              Padding(
                padding: const EdgeInsets.all(p10),
                child: ResponsiveChildWidget(
                    flex1: 1,
                    flex2: 4,
                    child1: Text("Finance", style: bodyLarge),
                    child2: Column(
                      children: [
                        ResponsiveChild3Widget(
                            flex1: 2,
                            flex2: 3,
                            flex3: 2,
                            child1: Column(
                              children: [
                                const Text("Approbation"),
                                const SizedBox(height: p20),
                                Text(
                                    widget.devisModel
                                        .approbationFin,
                                    style: bodyLarge.copyWith(
                                        color: (widget
                                                    .devisModel
                                                    .approbationFin ==
                                                "Unapproved")
                                            ? Colors.red.shade700
                                            : Colors.green.shade700)),
                              ],
                            ),
                            child2: (widget.devisModel
                                        .approbationFin ==
                                    "Unapproved")
                                ? Column(
                                    children: [
                                      const Text("Motif"),
                                      const SizedBox(height: p20),
                                      Text(widget
                                          .devisModel.motifFin),
                                    ],
                                  )
                                : Container(),
                            child3: Column(
                              children: [
                                const Text("Signature"),
                                const SizedBox(height: p20),
                                Text(widget
                                    .devisModel.signatureFin),
                              ],
                            )),
                        if (widget.devisModel.approbationBudget == "Approved" &&
                                widget.devisModel.approbationFin ==
                                '-' &&
                            profilController.user.fonctionOccupe ==
                                "Directeur de finance" ||
                            depList.contains('Finances') &&
                            widget.devisModel.approbationFin == '-' &&
                                profilController.user.fonctionOccupe ==
                                    "Directeur de budget" ||
                            depList.contains('Finances') &&
                            widget.devisModel.approbationFin == '-' &&
                                profilController.user.fonctionOccupe ==
                                    "Directeur de departement" ||
                            depList.contains('Finances') &&
                            widget.devisModel.approbationFin == '-' &&
                                profilController.user.fonctionOccupe ==
                                    "Directeur générale")
                          Padding(
                              padding: const EdgeInsets.all(p10),
                              child: ResponsiveChildWidget(
                                  child1: approbationFinWidget(controller),
                                  child2: (controller.approbationFin ==
                                          "Unapproved")
                                      ? motifFinWidget(controller)
                                      : Container())),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget approbationDGWidget(DevisController controller) {
    List<String> approbationList = ['Approved', 'Unapproved', '-'];
    return Container(
      margin: const EdgeInsets.only(bottom: p10),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Approbation',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: controller.approbationDG,
        isExpanded: true,
        items: approbationList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            controller.approbationDG = value!;
            if (controller.approbationDG == "Approved") {
              controller.submitDG(widget.devisModel);
            }
          });
        },
      ),
    );
  }

  Widget motifDGWidget(DevisController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p10),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: TextFormField(
                controller: controller.motifDGController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  labelText: 'Ecrivez le motif...',
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Ce champs est obligatoire';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                  tooltip: 'Soumettre le Motif',
                  onPressed: () {
                    controller.submitDG(widget.devisModel);
                  },
                  icon: Icon(Icons.send, color: Colors.red.shade700)),
            )
          ],
        ));
  }

  Widget approbationDDWidget(DevisController controller) {
    List<String> approbationList = ['Approved', 'Unapproved', '-'];
    return Container(
      margin: const EdgeInsets.only(bottom: p10),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Approbation',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: controller.approbationDD,
        isExpanded: true,
        items: approbationList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            controller.approbationDD = value!;
            if (controller.approbationDD == "Approved") {
              controller.submitDD(widget.devisModel);
            }
          });
        },
      ),
    );
  }

  Widget motifDDWidget(DevisController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p10),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: TextFormField(
                controller: controller.motifDDController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  labelText: 'Ecrivez le motif...',
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Ce champs est obligatoire';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                  tooltip: 'Soumettre le Motif',
                  onPressed: () {
                    controller.submitDD(widget.devisModel);
                  },
                  icon: Icon(Icons.send, color: Colors.red.shade700)),
            )
          ],
        ));
  }

  Widget approbationBudgetWidget(DevisController controller) {
    List<String> approbationList = ['Approved', 'Unapproved', '-'];
    return Container(
      margin: const EdgeInsets.only(bottom: p10),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Approbation',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: controller.approbationBudget,
        isExpanded: true,
        items: approbationList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            controller.approbationBudget = value!;
            final form = controller.formKeyBudget.currentState!;
            if (form.validate()) {
              if (controller.approbationBudget == "Approved") {
                controller.submitBudget(widget.devisModel);
              }
            }
          });
        },
      ),
    );
  }

  Widget motifBudgetWidget(DevisController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p10),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: TextFormField(
                controller: controller.motifBudgetController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  labelText: 'Ecrivez le motif...',
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Ce champs est obligatoire';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                  tooltip: 'Soumettre le Motif',
                  onPressed: () {
                    controller.submitBudget(widget.devisModel);
                  },
                  icon: Icon(Icons.send, color: Colors.red.shade700)),
            )
          ],
        ));
  }

  Widget approbationFinWidget(DevisController controller) {
    List<String> approbationList = ['Approved', 'Unapproved', '-'];
    return Container(
      margin: const EdgeInsets.only(bottom: p10),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Approbation',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: controller.approbationFin,
        isExpanded: true,
        items: approbationList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            controller.approbationFin = value!;
            if (controller.approbationFin == "Approved") {
              controller.submitFin(widget.devisModel);
            }
          });
        },
      ),
    );
  }

  Widget motifFinWidget(DevisController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p10),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: TextFormField(
                controller: controller.motifFinController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  labelText: 'Ecrivez le motif...',
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Ce champs est obligatoire';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                  tooltip: 'Soumettre le Motif',
                  onPressed: () {
                    controller.submitFin(widget.devisModel);
                  },
                  icon: Icon(Icons.send, color: Colors.red.shade700)),
            )
          ],
        ));
  }

  // Soumettre une ligne budgetaire
  Widget ligneBudgtaireWidget(DevisController controller) {
    final BudgetPrevisionnelController budgetPrevisionnelController =
        Get.find();
    final LignBudgetaireController lignBudgetaireController = Get.find();

    return budgetPrevisionnelController.obx((state) {
      return lignBudgetaireController.obx((ligne) {
        List<String> dataList = [];
        for (var i in state!) {
          dataList = ligne!
              .where((element) =>
                  element.periodeBudgetDebut.microsecondsSinceEpoch ==
                      i.periodeDebut.microsecondsSinceEpoch &&
                  i.approbationDG == "Approved" &&
                  i.approbationDD == "Approved" &&
                  DateTime.now().isBefore(element.periodeBudgetFin) &&
                  element.departement == "Ressources Humaines")
              .map((e) => e.nomLigneBudgetaire)
              .toList();
        }
        return Container(
          margin: const EdgeInsets.only(bottom: p10),
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Ligne Budgetaire',
              labelStyle: const TextStyle(),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              contentPadding: const EdgeInsets.only(left: 5.0),
            ),
            value: controller.ligneBudgtaire,
            isExpanded: true,
            items: dataList.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            validator: (value) =>
                value == null ? "Select Ligne Budgetaire" : null,
            onChanged: (value) {
              setState(() {
                controller.ligneBudgtaire = value!;
              });
            },
          ),
        );
      });
    });
  }

  Widget resourcesWidget(DevisController controller) {
    List<String> dataList = ['caisse', 'banque', 'finExterieur'];
    return Container(
      margin: const EdgeInsets.only(bottom: p10),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Resource',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: controller.ressource,
        isExpanded: true,
        items: dataList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        validator: (value) => value == null ? "Select Resource" : null,
        onChanged: (value) {
          setState(() {
            controller.ressource = value!;
          });
        },
      ),
    );
  }
}
