import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/rh/transport_restauration_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/transport_restauration/transport_rest_pdf.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/personnels_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/transport_rest_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/transport_rest_person_controller.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/print_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class DetailTransportRest extends StatefulWidget {
  const DetailTransportRest(
      {super.key, required this.transportRestaurationModel});
  final TransportRestaurationModel transportRestaurationModel;

  @override
  State<DetailTransportRest> createState() => _DetailTransportRestState();
}

class _DetailTransportRestState extends State<DetailTransportRest> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Ressources Humaines";

  @override
  Widget build(BuildContext context) {
    final TransportRestController controller = Get.find();
    final TransportRestPersonnelsController controllerAgent = Get.find();
    return controllerAgent.obx(
      onLoading: loading(),
      onEmpty: const Text('Aucune donnée'),
      onError: (error) => Text(
          "Une erreur s'est produite $error veiller actualiser votre logiciel. Merçi."),
      (state) => Scaffold(
      key: scaffoldKey,
      appBar: headerBar(
          context, scaffoldKey, title, "${widget.transportRestaurationModel}"),
      drawer: const DrawerMenu(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Ajout personne"),
        tooltip: "Ajout personne à la liste",
        icon: const Icon(Icons.person_add),
        onPressed: () {
          detailAgentDialog(controllerAgent);
        },
      ),
      body: Row(
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
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: p20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  if (Responsive.isDesktop(context))
                                    TitleWidget(title: widget.transportRestaurationModel.title),
                                  if (!Responsive.isDesktop(context))
                                    Container(),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          IconButton(
                                              color:
                                                  Colors.green.shade700,
                                              onPressed: () {
                                                controller.sendDD(widget
                                                    .transportRestaurationModel);
                                              },
                                              icon: const Icon(
                                                  Icons.send)),
                                          PrintWidget(
                                              onPressed: () async {
                                            await TransRestPdf.generate(
                                                state!, widget
                                                    .transportRestaurationModel);
                                          }),
                                        ],
                                      ),
                                      SelectableText(
                                          DateFormat("dd-MM-yyyy HH:mm")
                                              .format(widget
                                                  .transportRestaurationModel
                                                  .created),
                                          textAlign: TextAlign.start),
                                    ],
                                  )
                                ],
                              ),
                            ]
                          ),
                      ),
                    )),
              ))
        ],
      ),
    )) ;
  }

  detailAgentDialog(TransportRestPersonnelsController controllerAgent) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Ajout des personnes à la liste'),
              content: SizedBox(
                  height: 200,
                  width: 500,
                  child: Form(
                    key: controllerAgent.formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(child: nomWidget(controllerAgent)),
                            const SizedBox(
                              width: p10,
                            ),
                            Expanded(child: prenomWidget(controllerAgent))
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(child: matriculeWidget(controllerAgent)),
                            const SizedBox(
                              width: p10,
                            ),
                            Expanded(child: montantWidget(controllerAgent))
                          ],
                        ),
                      ],
                    ),
                  )),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Annuler'),
                ),
                TextButton(
                  onPressed: () {
                    final form = controllerAgent.formKey.currentState!;
                    if (form.validate()) {
                      controllerAgent.submitTransRestAgents(
                          widget.transportRestaurationModel);
                      form.reset();
                    }
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          });
        });
  }

  Widget nomWidget(TransportRestPersonnelsController controllerAgent) {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controllerAgent.nomController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Nom',
          ),
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value != null && value.isEmpty) {
              return 'Ce champs est obligatoire';
            } else {
              return null;
            }
          },
        ));
  }

  Widget prenomWidget(TransportRestPersonnelsController controllerAgent) {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controllerAgent.prenomController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Prenom',
          ),
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value != null && value.isEmpty) {
              return 'Ce champs est obligatoire';
            } else {
              return null;
            }
          },
        ));
  }

  Widget matriculeWidget(TransportRestPersonnelsController controllerAgent) {
    final PersonnelsController controllerPersonnels = Get.find();

    return controllerPersonnels.obx((state) {
      List<String> suggestionList = state!.map((e) => e.matricule).toList();
      return Container(
          margin: const EdgeInsets.only(bottom: p20),
          child: EasyAutocomplete(
            controller: controllerAgent.matriculeController,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              labelText: "Matricule ou identifiant de l'agent",
            ),
            keyboardType: TextInputType.text,
            suggestions: suggestionList,
            validator: (value) => value == null ? "Select Matricule" : null,
          ));
    });
  }

  Widget montantWidget(TransportRestPersonnelsController controllerAgent) {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: TextFormField(
                controller: controllerAgent.montantController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  labelText: 'Montant',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Ce champs est obligatoire';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            const SizedBox(width: p20),
            Expanded(
                child: Text("\$", style: Theme.of(context).textTheme.headline6))
          ],
        ));
  }
}
