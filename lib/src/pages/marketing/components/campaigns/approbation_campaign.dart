import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/models/marketing/campaign_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/budgets/controller/ligne_budgetaire_controller.dart';
import 'package:wm_solution/src/pages/marketing/controller/campaigns/compaign_controller.dart';
import 'package:wm_solution/src/widgets/responsive_child3_widget.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class ApprobationCampaign extends StatefulWidget {
  const ApprobationCampaign(
      {super.key,
      required this.campaignModel,
      required this.controller,
      required this.profilController});
  final CampaignModel campaignModel;
  final CampaignController controller;
  final ProfilController profilController;

  @override
  State<ApprobationCampaign> createState() => _ApprobationCampaignState();
}

class _ApprobationCampaignState extends State<ApprobationCampaign> {
  @override
  Widget build(BuildContext context) {
    return approbationWidget(widget.controller, widget.profilController);
  }

  Widget approbationWidget(
      CampaignController controller, ProfilController profilController) {
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
                                  Text(widget.campaignModel.approbationDG,
                                      style: bodyLarge!.copyWith(
                                          color: (widget.campaignModel
                                                      .approbationDG ==
                                                  "Unapproved")
                                              ? Colors.red.shade700
                                              : Colors.green.shade700)),
                                ],
                              ),
                              child2: (widget.campaignModel.approbationDG ==
                                      "Unapproved")
                                  ? Column(
                                      children: [
                                        const Text("Motif"),
                                        const SizedBox(height: p20),
                                        Text(widget.campaignModel.motifDG),
                                      ],
                                    )
                                  : Container(),
                              child3: Column(
                                children: [
                                  const Text("Signature"),
                                  const SizedBox(height: p20),
                                  Text(widget.campaignModel.signatureDG),
                                ],
                              )),
                          if (widget.campaignModel.approbationDD ==
                                  "Approved" &&
                              widget.campaignModel.approbationDG == '-' &&
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
                                  Text(widget.campaignModel.approbationDD,
                                      style: bodyLarge.copyWith(
                                          color: (widget.campaignModel
                                                      .approbationDD ==
                                                  "Unapproved")
                                              ? Colors.red.shade700
                                              : Colors.green.shade700)),
                                ],
                              ),
                              child2: (widget.campaignModel.approbationDD ==
                                      "Unapproved")
                                  ? Column(
                                      children: [
                                        const Text("Motif"),
                                        const SizedBox(height: p20),
                                        Text(widget.campaignModel.motifDD),
                                      ],
                                    )
                                  : Container(),
                              child3: Column(
                                children: [
                                  const Text("Signature"),
                                  const SizedBox(height: p20),
                                  Text(widget.campaignModel.signatureDD),
                                ],
                              )),
                          if (widget.campaignModel.approbationDD == '-' &&
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
                                  Text(widget.campaignModel.approbationBudget,
                                      style: bodyLarge.copyWith(
                                          color: (widget.campaignModel
                                                      .approbationBudget ==
                                                  "Unapproved")
                                              ? Colors.red.shade700
                                              : Colors.green.shade700)),
                                ],
                              ),
                              child2: (widget.campaignModel.approbationBudget ==
                                      "Unapproved")
                                  ? Column(
                                      children: [
                                        const Text("Motif"),
                                        const SizedBox(height: p20),
                                        Text(widget.campaignModel.motifBudget),
                                      ],
                                    )
                                  : Container(),
                              child3: Column(
                                children: [
                                  const Text("Signature"),
                                  const SizedBox(height: p20),
                                  Text(widget.campaignModel.signatureBudget),
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
                                  Text(widget.campaignModel.ligneBudgetaire,
                                      style: bodyLarge.copyWith(
                                          color: Colors.purple.shade700)),
                                ],
                              ),
                              child2: Column(
                                children: [
                                  const Text("Ressource"),
                                  const SizedBox(height: p20),
                                  Text(widget.campaignModel.ressource,
                                      style: bodyLarge.copyWith(
                                          color: Colors.purple.shade700)),
                                ],
                              )),
                          if (widget.campaignModel.approbationDG ==
                                      "Approved" &&
                                  widget.campaignModel.approbationBudget ==
                                      '-' &&
                                  profilController.user.fonctionOccupe ==
                                      "Directeur de budget" ||
                              depList.contains('Budgets') &&
                                  widget.campaignModel.approbationBudget ==
                                      '-' &&
                                  profilController.user.fonctionOccupe ==
                                      "Directeur de finance" ||
                              depList.contains('Budgets') &&
                                  widget.campaignModel.approbationBudget ==
                                      '-' &&
                                  profilController.user.fonctionOccupe ==
                                      "Directeur de departement" ||
                              depList.contains('Budgets') &&
                                  widget.campaignModel.approbationBudget ==
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
                                Text(widget.campaignModel.approbationFin,
                                    style: bodyLarge.copyWith(
                                        color: (widget.campaignModel
                                                    .approbationFin ==
                                                "Unapproved")
                                            ? Colors.red.shade700
                                            : Colors.green.shade700)),
                              ],
                            ),
                            child2: (widget.campaignModel.approbationFin ==
                                    "Unapproved")
                                ? Column(
                                    children: [
                                      const Text("Motif"),
                                      const SizedBox(height: p20),
                                      Text(widget.campaignModel.motifFin),
                                    ],
                                  )
                                : Container(),
                            child3: Column(
                              children: [
                                const Text("Signature"),
                                const SizedBox(height: p20),
                                Text(widget.campaignModel.signatureFin),
                              ],
                            )),
                        if (widget.campaignModel.approbationBudget ==
                                    "Approved" &&
                                widget.campaignModel.approbationFin == '-' &&
                                profilController.user.fonctionOccupe ==
                                    "Directeur de finance" ||
                            depList.contains('Finances') &&
                                widget.campaignModel.approbationFin == '-' &&
                                profilController.user.fonctionOccupe ==
                                    "Directeur de budget" ||
                            depList.contains('Finances') &&
                                widget.campaignModel.approbationFin == '-' &&
                                profilController.user.fonctionOccupe ==
                                    "Directeur de departement" ||
                            depList.contains('Finances') &&
                                widget.campaignModel.approbationFin == '-' &&
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

  Widget approbationDGWidget(CampaignController controller) {
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
              controller.submitDG(widget.campaignModel);
            }
          });
        },
      ),
    );
  }

  Widget motifDGWidget(CampaignController controller) {
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
                    controller.submitDG(widget.campaignModel);
                  },
                  icon: Icon(Icons.send, color: Colors.red.shade700)),
            )
          ],
        ));
  }

  Widget approbationDDWidget(CampaignController controller) {
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
              controller.submitDD(widget.campaignModel);
            }
          });
        },
      ),
    );
  }

  Widget motifDDWidget(CampaignController controller) {
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
                    controller.submitDD(widget.campaignModel);
                  },
                  icon: Icon(Icons.send, color: Colors.red.shade700)),
            )
          ],
        ));
  }

  Widget approbationBudgetWidget(CampaignController controller) {
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
                controller.submitBudget(widget.campaignModel);
              }
            }
          });
        },
      ),
    );
  }

  Widget motifBudgetWidget(CampaignController controller) {
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
                    controller.submitBudget(widget.campaignModel);
                  },
                  icon: Icon(Icons.send, color: Colors.red.shade700)),
            )
          ],
        ));
  }

  Widget approbationFinWidget(CampaignController controller) {
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
              controller.submitFin(widget.campaignModel);
            }
          });
        },
      ),
    );
  }

  Widget motifFinWidget(CampaignController controller) {
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
                    controller.submitFin(widget.campaignModel);
                  },
                  icon: Icon(Icons.send, color: Colors.red.shade700)),
            )
          ],
        ));
  }

  // Soumettre une ligne budgetaire
  Widget ligneBudgtaireWidget(CampaignController controller) {
    final LignBudgetaireController lignBudgetaireController =
        Get.put(LignBudgetaireController());
    List<String> dataList = [];

    return lignBudgetaireController.obx((ligne) {
      dataList = ligne!
          .where((p0) {
            double sortieTotal =
                p0.caisseSortie + p0.banqueSortie + p0.finExterieurSortie;

            double reste = double.parse(p0.coutTotal) - sortieTotal;

            return DateTime.now().isBefore(p0.periodeBudgetFin) &&
                double.parse(p0.coutTotal) > sortieTotal &&
                reste > double.parse(widget.campaignModel.coutCampaign);
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

  Widget resourcesWidget(CampaignController controller) {
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
