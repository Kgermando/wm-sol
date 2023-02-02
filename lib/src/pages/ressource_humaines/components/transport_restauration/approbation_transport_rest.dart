import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/models/rh/transport_restauration_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/budgets/controller/ligne_budgetaire_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/transport_rest/transport_rest_controller.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/responsive_child3_widget.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class ApprobatioTransportRest extends StatefulWidget {
  const ApprobatioTransportRest(
      {super.key,
      required this.transportRestaurationModel,
      required this.controller,
      required this.profilController, required this.state});
  final TransportRestaurationModel transportRestaurationModel;
  final TransportRestController controller;
  final ProfilController profilController;
  final List<TransRestAgentsModel> state;

  @override
  State<ApprobatioTransportRest> createState() =>
      _ApprobatioTransportRestState();
}

class _ApprobatioTransportRestState extends State<ApprobatioTransportRest> {
  @override
  Widget build(BuildContext context) {
    return approbationWidget(widget.controller, widget.profilController);
  }

  Widget approbationWidget(
      TransportRestController controller, ProfilController profilController) {
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
                                      widget.transportRestaurationModel
                                          .approbationDG,
                                      style: bodyLarge!.copyWith(
                                          color:
                                              (widget.transportRestaurationModel
                                                          .approbationDG ==
                                                      "Unapproved")
                                                  ? Colors.red.shade700
                                                  : Colors.green.shade700)),
                                ],
                              ),
                              child2: (widget.transportRestaurationModel
                                          .approbationDG ==
                                      "Unapproved")
                                  ? Column(
                                      children: [
                                        const Text("Motif"),
                                        const SizedBox(height: p20),
                                        Text(widget.transportRestaurationModel
                                            .motifDG),
                                      ],
                                    )
                                  : Container(),
                              child3: Column(
                                children: [
                                  const Text("Signature"),
                                  const SizedBox(height: p20),
                                  Text(widget
                                      .transportRestaurationModel.signatureDG),
                                ],
                              )),
                          if (widget.transportRestaurationModel.approbationDD ==
                                  "Approved" &&
                              widget.transportRestaurationModel.approbationDG ==
                                  '-' &&
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
                                      widget.transportRestaurationModel
                                          .approbationDD,
                                      style: bodyLarge.copyWith(
                                          color:
                                              (widget.transportRestaurationModel
                                                          .approbationDD ==
                                                      "Unapproved")
                                                  ? Colors.red.shade700
                                                  : Colors.green.shade700)),
                                ],
                              ),
                              child2: (widget.transportRestaurationModel
                                          .approbationDD ==
                                      "Unapproved")
                                  ? Column(
                                      children: [
                                        const Text("Motif"),
                                        const SizedBox(height: p20),
                                        Text(widget.transportRestaurationModel
                                            .motifDD),
                                      ],
                                    )
                                  : Container(),
                              child3: Column(
                                children: [
                                  const Text("Signature"),
                                  const SizedBox(height: p20),
                                  Text(widget
                                      .transportRestaurationModel.signatureDD),
                                ],
                              )),
                          if (depList
                                      .contains('Exploitations') &&
                                  widget.transportRestaurationModel
                                          .approbationDD ==
                                      '-' &&
                                  profilController
                                          .user.fonctionOccupe ==
                                      "Directeur de finance" ||
                              depList.contains('Exploitations') &&
                                  widget.transportRestaurationModel
                                          .approbationDD ==
                                      '-' &&
                                  profilController.user.fonctionOccupe ==
                                      "Directeur de departement" ||
                              depList.contains('Exploitations') &&
                                  widget.transportRestaurationModel
                                          .approbationDD ==
                                      '-' &&
                                  profilController.user.fonctionOccupe ==
                                      "Directeur générale")
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
                                      widget.transportRestaurationModel
                                          .approbationBudget,
                                      style: bodyLarge.copyWith(
                                          color:
                                              (widget.transportRestaurationModel
                                                          .approbationBudget ==
                                                      "Unapproved")
                                                  ? Colors.red.shade700
                                                  : Colors.green.shade700)),
                                ],
                              ),
                              child2: (widget.transportRestaurationModel
                                          .approbationBudget ==
                                      "Unapproved")
                                  ? Column(
                                      children: [
                                        const Text("Motif"),
                                        const SizedBox(height: p20),
                                        Text(widget.transportRestaurationModel
                                            .motifBudget),
                                      ],
                                    )
                                  : Container(),
                              child3: Column(
                                children: [
                                  const Text("Signature"),
                                  const SizedBox(height: p20),
                                  Text(widget.transportRestaurationModel
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
                                      widget.transportRestaurationModel
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
                                          .transportRestaurationModel.ressource,
                                      style: bodyLarge.copyWith(
                                          color: Colors.purple.shade700)),
                                ],
                              )),
                          if (widget.transportRestaurationModel.approbationDG ==
                                      "Approved" &&
                                  widget.transportRestaurationModel
                                          .approbationBudget ==
                                      '-' &&
                                  profilController.user.fonctionOccupe ==
                                      "Directeur de budget" ||
                              depList.contains('Budgets') &&
                                  widget.transportRestaurationModel
                                          .approbationBudget ==
                                      '-' &&
                                  profilController.user.fonctionOccupe ==
                                      "Directeur de finance" ||
                              depList.contains('Budgets') &&
                                  widget.transportRestaurationModel
                                          .approbationBudget ==
                                      '-' &&
                                  profilController.user.fonctionOccupe ==
                                      "Directeur de departement" ||
                              depList.contains('Budgets') &&
                                  widget.transportRestaurationModel
                                          .approbationBudget ==
                                      '-' &&
                                  profilController.user.fonctionOccupe ==
                                      "Directeur générale")
                            Padding(
                              padding: const EdgeInsets.all(p10),
                              child: Form(
                                key: controller.formKeyBudget,
                                child: Column(
                                  children: [
                                    ResponsiveChildWidget(
                                        child1: ligneBudgtaireWidget(
                                            controller),
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
                                    widget.transportRestaurationModel
                                        .approbationFin,
                                    style: bodyLarge.copyWith(
                                        color: (widget
                                                    .transportRestaurationModel
                                                    .approbationFin ==
                                                "Unapproved")
                                            ? Colors.red.shade700
                                            : Colors.green.shade700)),
                              ],
                            ),
                            child2: (widget.transportRestaurationModel
                                        .approbationFin ==
                                    "Unapproved")
                                ? Column(
                                    children: [
                                      const Text("Motif"),
                                      const SizedBox(height: p20),
                                      Text(widget
                                          .transportRestaurationModel.motifFin),
                                    ],
                                  )
                                : Container(),
                            child3: Column(
                              children: [
                                const Text("Signature"),
                                const SizedBox(height: p20),
                                Text(widget
                                    .transportRestaurationModel.signatureFin),
                              ],
                            )),
                        if (widget.transportRestaurationModel.approbationBudget ==
                                    "Approved" &&
                                widget.transportRestaurationModel.approbationFin ==
                                    '-' &&
                                profilController.user.fonctionOccupe ==
                                    "Directeur de finance" ||
                            depList.contains('Finances') &&
                                widget.transportRestaurationModel.approbationFin ==
                                    '-' &&
                                profilController.user.fonctionOccupe ==
                                    "Directeur de budget" ||
                            depList.contains('Finances') &&
                                widget.transportRestaurationModel
                                        .approbationFin ==
                                    '-' &&
                                profilController.user.fonctionOccupe ==
                                    "Directeur de departement" ||
                            depList.contains('Finances') &&
                                widget.transportRestaurationModel
                                        .approbationFin ==
                                    '-' &&
                                profilController.user.fonctionOccupe ==
                                    "Directeur générale")
                          Padding(
                              padding: const EdgeInsets.all(p10),
                              child: ResponsiveChildWidget(
                                  child1: approbationFinWidget(controller),
                                  child2:
                                      (controller.approbationFin == "Unapproved")
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

  Widget approbationDGWidget(TransportRestController controller) {
    List<String> approbationList = ['Approved', 'Unapproved', '-'];
    return Obx(() => controller.isLoading
        ? loading()
        : Container(
            margin: const EdgeInsets.only(bottom: p10),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Approbation',
                labelStyle: const TextStyle(),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
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
                    controller.submitDG(widget.transportRestaurationModel);
                  }
                });
              },
            ),
          ));
  }

  Widget motifDGWidget(TransportRestController controller) {
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
                    controller.submitDG(widget.transportRestaurationModel);
                  },
                  icon: Icon(Icons.send, color: Colors.red.shade700)),
            )
          ],
        ));
  }

  Widget approbationDDWidget(TransportRestController controller) {
    List<String> approbationList = ['Approved', 'Unapproved', '-'];
    return Obx(() => controller.isLoading
        ? loading()
        : Container(
            margin: const EdgeInsets.only(bottom: p10),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Approbation',
                labelStyle: const TextStyle(),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
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
                    controller.submitDD(widget.transportRestaurationModel);
                  }
                });
              },
            ),
          ));
  }

  Widget motifDDWidget(TransportRestController controller) {
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
                    controller.submitDD(widget.transportRestaurationModel);
                  },
                  icon: Icon(Icons.send, color: Colors.red.shade700)),
            )
          ],
        ));
  }

  Widget approbationBudgetWidget(TransportRestController controller) {
    List<String> approbationList = ['Approved', 'Unapproved', '-'];
    return Obx(() => controller.isLoading
        ? loading()
        : Container(
            margin: const EdgeInsets.only(bottom: p10),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Approbation',
                labelStyle: const TextStyle(),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
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
                      controller
                          .submitBudget(widget.transportRestaurationModel);
                    }
                  }
                });
              },
            ),
          ));
  }

  Widget motifBudgetWidget(TransportRestController controller) {
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
                    controller.submitBudget(widget.transportRestaurationModel);
                  },
                  icon: Icon(Icons.send, color: Colors.red.shade700)),
            )
          ],
        ));
  }

  Widget approbationFinWidget(TransportRestController controller) {
    List<String> approbationList = ['Approved', 'Unapproved', '-'];
    return Obx(() => controller.isLoading
        ? loading()
        : Container(
            margin: const EdgeInsets.only(bottom: p10),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Approbation',
                labelStyle: const TextStyle(),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
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
                    controller.submitFin(widget.transportRestaurationModel);
                  }
                });
              },
            ),
          ));
  }

  Widget motifFinWidget(TransportRestController controller) {
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
                    controller.submitFin(widget.transportRestaurationModel);
                  },
                  icon: Icon(Icons.send, color: Colors.red.shade700)),
            )
          ],
        ));
  }

  // Soumettre une ligne budgetaire
  Widget ligneBudgtaireWidget(
      TransportRestController controller) {
    final LignBudgetaireController lignBudgetaireController =
        Get.put(LignBudgetaireController());
    List<String> dataList = [];

    double totalMontant = 0.0;
    for (var element in widget.state
        .where((element) =>
            element.reference == widget.transportRestaurationModel.id)
        .toList()) {
      totalMontant += double.parse(element.montant);
    }

    return lignBudgetaireController.obx(
        onLoading: loadingPage(context),
        onEmpty: const Text('Aucune donnée'),
        onError: (error) => loadingError(context, error!), (ligne) {
      dataList = ligne!
          .where((p0) {
            // Check somme total depenses
            double sortieTotal =
                p0.caisseSortie + p0.banqueSortie + p0.finExterieurSortie;
            // check reste du budget dans chaque ligne budgetaire
            double reste = double.parse(p0.coutTotal) - sortieTotal;

            return DateTime.now().isBefore(p0.periodeBudgetFin) &&
                double.parse(p0.coutTotal) > sortieTotal &&
                reste > totalMontant;
          })
          .map((e) => e.nomLigneBudgetaire)
          .toList();
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
  }

  Widget resourcesWidget(TransportRestController controller) {
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
