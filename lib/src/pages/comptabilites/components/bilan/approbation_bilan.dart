import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/models/comptabilites/bilan_model.dart';  
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/bilans/bilan_controller.dart';
import 'package:wm_solution/src/widgets/loading.dart';  
import 'package:wm_solution/src/widgets/responsive_child3_widget.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class ApprobationCompteResultat extends StatefulWidget {
  const ApprobationCompteResultat(
      {super.key,
      required this.data,
      required this.controller,
      required this.profilController});
  final BilanModel data;
  final BilanController controller;
  final ProfilController profilController;

  @override
  State<ApprobationCompteResultat> createState() => _ApprobationCompteResultatState();
}

class _ApprobationCompteResultatState extends State<ApprobationCompteResultat> {
  @override
  Widget build(BuildContext context) {
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    List<dynamic> depList =
        jsonDecode(widget.profilController.user.departement);
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
                                    widget.data
                                        .approbationDD,
                                    style: bodyLarge!.copyWith(
                                        color:
                                            (widget.data
                                                        .approbationDD ==
                                                    "Unapproved")
                                                ? Colors.red.shade700
                                                : Colors.green.shade700)),
                              ],
                            ),
                            child2: (widget.data
                                        .approbationDD ==
                                    "Unapproved")
                                ? Column(
                                    children: [
                                      const Text("Motif"),
                                      const SizedBox(height: p20),
                                      Text(widget.data
                                          .motifDD),
                                    ],
                                  )
                                : Container(),
                            child3: Column(
                              children: [
                                const Text("Signature"),
                                const SizedBox(height: p20),
                                Text(widget
                                    .data.signatureDD),
                              ],
                            )),
                        if (depList.contains('Comptabilites') &&
                                  widget.data.approbationDD == '-' &&
                                  widget.profilController.user.fonctionOccupe ==
                                      "Directeur de finance" ||
                              depList.contains('Comptabilites') &&
                                  widget.data.approbationDD == '-' &&
                                  widget.profilController.user.fonctionOccupe ==
                                      "Directeur de departement" ||
                              depList.contains('Comptabilites') &&
                                  widget.data.approbationDD == '-' &&
                                  widget.profilController.user.fonctionOccupe ==
                                      "Directeur générale")
                          Padding(
                              padding: const EdgeInsets.all(p10),
                              child: ResponsiveChildWidget(
                                  child1: approbationDDWidget(widget.controller),
                                  child2: (widget.controller.approbationDD ==
                                          "Unapproved")
                                      ? motifDDWidget(widget.controller)
                                      : Container())),
                      ],
                    )
                  )
                ), 
            ],
          ),
        ),
      ),
    );
  } 

  Widget approbationDDWidget(BilanController controller) {
    List<String> approbationList = ['Approved', 'Unapproved', '-'];
    return Obx(() => controller.isLoading
        ? loading()
        : Container(
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
              controller.submitDD(widget.data);
            }
          });
        },
      ),
    )) ;
  }

  Widget motifDDWidget(BilanController controller) {
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
                  controller.submitDD(widget.data);
                },
                icon: Icon(Icons.send, color: Colors.red.shade700)),
          )
        ],
      ));
  }

} 