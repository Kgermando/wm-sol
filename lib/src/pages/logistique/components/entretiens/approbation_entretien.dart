import 'package:flutter/material.dart';
import 'package:wm_solution/src/constants/app_theme.dart'; 
import 'package:wm_solution/src/models/logistiques/entretien_model.dart';  
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart'; 
import 'package:wm_solution/src/pages/logistique/controller/entretiens/entretiens_controller.dart';  
import 'package:wm_solution/src/widgets/responsive_child3_widget.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class ApprobationEntretien extends StatefulWidget {
  const ApprobationEntretien(
      {super.key,
      required this.data,
      required this.controller,
      required this.profilController});
  final EntretienModel data;
  final EntretienController controller;
  final ProfilController profilController;

  @override
  State<ApprobationEntretien> createState() => _ApprobationEntretienState();
}

class _ApprobationEntretienState extends State<ApprobationEntretien> {
  @override
  Widget build(BuildContext context) {
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
                        if (widget.data.approbationDD == '-' &&
                            widget.profilController.user.fonctionOccupe ==
                                "Directeur de departement")
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

  Widget approbationDDWidget(EntretienController controller) {
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
              controller.submitDD(widget.data);
            }
          });
        },
      ),
    );
  }

  Widget motifDDWidget(EntretienController controller) {
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