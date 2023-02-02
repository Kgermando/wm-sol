import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/models/rh/transport_restauration_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/transport_restauration/approbation_transport_rest.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/transport_restauration/transport_rest_pdf.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/personnels/personnels_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/transport_rest/transport_rest_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/transport_rest/transport_rest_person_controller.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/print_widget.dart';
import 'package:wm_solution/src/widgets/responsive_child3_widget.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class DetailTransportRest extends StatefulWidget {
  const DetailTransportRest(
      {super.key, required this.transportRestaurationModel});
  final TransportRestaurationModel transportRestaurationModel;

  @override
  State<DetailTransportRest> createState() => _DetailTransportRestState();
}

class _DetailTransportRestState extends State<DetailTransportRest> {
  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());
  final ProfilController profilController = Get.put(ProfilController());
  final TransportRestController controller = Get.put(TransportRestController());
  final TransportRestPersonnelsController controllerAgent =
      Get.put(TransportRestPersonnelsController());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  String title = "Ressources Humaines";

  final ScrollController controllerTable = ScrollController();

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: headerBar(context, scaffoldKey, title,
          widget.transportRestaurationModel.title),
      drawer: const DrawerMenu(),
      floatingActionButton:
        (widget.transportRestaurationModel.isSubmit == "true")
            ? Container()
            : FloatingActionButton.extended(
                label: const Text("Ajouter une personne"),
                tooltip: "Ajout personne à la liste",
                icon: const Icon(Icons.add),
                onPressed: () {
                  ajoutPersonDialog(controller, controllerAgent);
                },
              ),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
                visible: !Responsive.isMobile(context),
                child: const Expanded(flex: 1, child: DrawerMenu())),
            Expanded(
                flex: 5,
                child: controllerAgent.obx(
                    onLoading: loadingPage(context),
                    onEmpty: const Text('Aucune donnée'),
                    onError: (error) => loadingError(context, error!),
                    (state) => SingleChildScrollView(
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
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                if (!Responsive.isMobile(
                                                    context))
                                                  TitleWidget(
                                                      title: widget
                                                          .transportRestaurationModel
                                                          .title),
                                                Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        if (widget.transportRestaurationModel
                                                                    .isSubmit ==
                                                                "false" ||
                                                            widget.transportRestaurationModel
                                                                    .approbationDG ==
                                                                "Unapproved" ||
                                                            widget
                                                                    .transportRestaurationModel
                                                                    .approbationDD ==
                                                                "Unapproved" ||
                                                            widget.transportRestaurationModel
                                                                    .approbationBudget ==
                                                                "Unapproved" ||
                                                            widget.transportRestaurationModel
                                                                    .approbationFin ==
                                                                "Unapproved")
                                                          IconButton(
                                                              color: Colors.teal
                                                                  .shade700,
                                                              onPressed: () {
                                                                controller.sendDD(
                                                                    widget
                                                                        .transportRestaurationModel);
                                                              },
                                                              icon: const Icon(
                                                                  Icons.send)),
                                                        if (widget
                                                                .transportRestaurationModel
                                                                .isSubmit ==
                                                            "false" || widget.transportRestaurationModel
                                                                    .approbationDG ==
                                                                "Unapproved" ||
                                                            widget.transportRestaurationModel
                                                                    .approbationDD ==
                                                                "Unapproved" || widget.transportRestaurationModel
                                                                    .approbationBudget ==
                                                                "Unapproved" || widget.transportRestaurationModel
                                                                    .approbationFin ==
                                                                "Unapproved")
                                                          IconButton(
                                                              tooltip:
                                                                  'Supprimer',
                                                              onPressed:
                                                                  () async {
                                                                alertDeleteDialog();
                                                              },
                                                              icon: const Icon(
                                                                  Icons.delete),
                                                              color: Colors.red
                                                                  .shade700),
                                                        PrintWidget(onPressed:
                                                            () async {
                                                          await TransRestPdf.generate(
                                                              state!,
                                                              widget
                                                                  .transportRestaurationModel,
                                                              monnaieStorage);
                                                        }),
                                                      ],
                                                    ),
                                                    SelectableText(
                                                        DateFormat(
                                                                "dd-MM-yyyy HH:mm")
                                                            .format(widget
                                                                .transportRestaurationModel
                                                                .created),
                                                        textAlign:
                                                            TextAlign.start),
                                                  ],
                                                )
                                              ],
                                            ),
                                            dataWidget(controller),
                                            tableListAgents(
                                                controllerAgent,
                                                controllerAgent
                                                    .transRestAgentList),
                                          ]),
                                    ),
                                  ),
                                  const SizedBox(height: p30),
                                  if (widget.transportRestaurationModel
                                          .isSubmit ==
                                      "true")  
                                   ApprobatioTransportRest(
                                        transportRestaurationModel:
                                            widget.transportRestaurationModel,
                                        controller: controller,
                                        profilController: profilController,
                                        state: state!)  
                                ],
                              )),
                        )))
          ],
        ));
  }

  alertDeleteDialog() {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Etes-vous sûr de vouloir faire ceci ?',
                  style: TextStyle(color: Colors.red)),
              content: const SizedBox(
                  // height: 100,
                  width: 100,
                  child: Text("Cette action permet de supprimer le document")),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Annuler',
                      style: TextStyle(color: Colors.red)),
                ),
                Obx(() => controller.isLoading
                    ? loadingMini()
                    : TextButton(
                        onPressed: () {
                          controller.deleteData(
                              widget.transportRestaurationModel.id!);
                          Navigator.pop(context, 'ok');
                        },
                        child: const Text('OK',
                            style: TextStyle(color: Colors.red)),
                      )),
              ],
            );
          });
        });
  }

  Widget dataWidget(TransportRestController controller) {
    final ProfilController profilController = Get.find();
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.all(p10),
      child: Column(
        children: [
          ResponsiveChildWidget(
            flex1: 1,
            flex2: 3,
            child1: Text('Intitlé :',
                textAlign: TextAlign.start,
                style: bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(widget.transportRestaurationModel.title,
                textAlign: TextAlign.start, style: bodyMedium),
          ),
          Divider(
            color: mainColor,
          ),
          Obx(() => ResponsiveChild3Widget(
              flex1: 1,
              flex2: 3,
              flex3: 3,
              child1: Text(
                'Observation :',
                style: bodyMedium.copyWith(fontWeight: FontWeight.bold),
              ),
              child2:
                  (widget.transportRestaurationModel.observation == 'false' &&
                          profilController.user.departement == "Finances")
                      ? checkboxRead(controller)
                      : Container(),
              child3: (widget.transportRestaurationModel.observation == 'true')
                  ? SelectableText(
                      'Payé',
                      style: bodyMedium.copyWith(
                          color: Colors.greenAccent.shade700),
                    )
                  : SelectableText(
                      'Non payé',
                      style:
                          bodyMedium.copyWith(color: Colors.redAccent.shade700),
                    ))),
          Divider(
            color: mainColor,
          ),
          ResponsiveChildWidget(
            flex1: 1,
            flex2: 3,
            child1: Text('Signature :',
                textAlign: TextAlign.start,
                style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(widget.transportRestaurationModel.signature,
                textAlign: TextAlign.start, style: bodyMedium),
          ),
          Divider(
            color: mainColor,
          ),
        ],
      ),
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.red;
    }
    return Colors.green;
  }

  checkboxRead(TransportRestController controller) {
    if (widget.transportRestaurationModel.observation == 'true') {
      isChecked = true;
    } else if (widget.transportRestaurationModel.observation == 'false') {
      isChecked = false;
    }
    return ListTile(
      leading: Checkbox(
        checkColor: Colors.white,
        fillColor: MaterialStateProperty.resolveWith(getColor),
        value: isChecked,
        onChanged: (bool? value) {
          setState(() {
            isChecked = value!;
            controller.submitObservation(widget.transportRestaurationModel);
          });
        },
      ),
      title: const Text("Confirmation de Paiement"),
    );
  }

  Widget tableListAgents(TransportRestPersonnelsController controllerAgent,
      List<TransRestAgentsModel> state) {
    int i = 1;
    return Padding(
      padding: const EdgeInsets.all(p10),
      child: Table(
        border: TableBorder.all(),
        columnWidths: const {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(3),
          2: FlexColumnWidth(3),
          3: FlexColumnWidth(2),
          4: FlexColumnWidth(2),
          5: FlexColumnWidth(1),
        },
        children: [
          tableRowHeader(),
          for (var item in state.where((element) =>
              element.reference == widget.transportRestaurationModel.id))
            tableRow(i++, controllerAgent, item)
        ],
      ),
    );
  }

  TableRow tableRowHeader() {
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    return TableRow(children: [
      Container(
        padding: const EdgeInsets.all(p10),
        width: 100,
        child: AutoSizeText("N°",
            style: bodyLarge!.copyWith(fontWeight: FontWeight.bold)),
      ),
      Container(
        padding: const EdgeInsets.all(p10),
        width: 200,
        child: AutoSizeText("Nom",
            style: bodyLarge.copyWith(fontWeight: FontWeight.bold)),
      ),
      Container(
        padding: const EdgeInsets.all(p10),
        width: 200,
        child: AutoSizeText("Prenom",
            style: bodyLarge.copyWith(fontWeight: FontWeight.bold)),
      ),
      Container(
        padding: const EdgeInsets.all(p10),
        width: 200,
        child: AutoSizeText("Matricule",
            style: bodyLarge.copyWith(fontWeight: FontWeight.bold)),
      ),
      Container(
        padding: const EdgeInsets.all(p10),
        width: 200,
        child: AutoSizeText("Montant",
            style: bodyLarge.copyWith(fontWeight: FontWeight.bold)),
      ),
      Container(
        padding: const EdgeInsets.all(p10),
        width: 200,
        child: AutoSizeText("Retirer",
            style: bodyLarge.copyWith(fontWeight: FontWeight.bold)),
      ),
    ]);
  }

  TableRow tableRow(int i, TransportRestPersonnelsController controllerAgent,
      TransRestAgentsModel item) {
    return TableRow(children: [
      Container(
        padding: const EdgeInsets.all(p10),
        width: 100,
        child: AutoSizeText("$i"),
      ),
      Container(
        padding: const EdgeInsets.all(p10),
        width: 200,
        child: AutoSizeText(item.nom),
      ),
      Container(
        padding: const EdgeInsets.all(p10),
        width: 200,
        child: AutoSizeText(item.prenom),
      ),
      Container(
        padding: const EdgeInsets.all(p10),
        width: 200,
        child: AutoSizeText(item.matricule),
      ),
      Container(
        padding: const EdgeInsets.all(p10),
        width: 200,
        child: AutoSizeText(
            "${NumberFormat.decimalPattern('fr').format(double.parse(item.montant))} ${monnaieStorage.monney}"),
      ),
      Container(
        padding: const EdgeInsets.all(p10),
        width: 200,
        child: (widget.transportRestaurationModel.isSubmit == "true")
            ? IconButton(
                color: Colors.green.shade700,
                onPressed: () {},
                icon: const Icon(Icons.check_box))
            : IconButton(
                color: Colors.red.shade700,
                onPressed: () {
                  controllerAgent.deleteTransRestAgents(item.id!);
                },
                icon: const Icon(Icons.delete)),
      ),
    ]);
  }

  checkboxAgentPaye(TransportRestPersonnelsController controllerAgent,
      TransRestAgentsModel item) {
    bool isCheckedItem = false;
    if (item.observation == 'true') {
      isCheckedItem = true;
    } else if (item.observation == 'false') {
      isCheckedItem = false;
    }
    return ListTile(
      leading: Checkbox(
        checkColor: Colors.white,
        fillColor: MaterialStateProperty.resolveWith(getColor),
        value: isCheckedItem,
        onChanged: (bool? value) {
          setState(() {
            isCheckedItem = value!;
            controllerAgent.updateTransRestAgents(item);
          });
        },
      ),
      title: const Text("Confirmation de Paiement"),
    );
  }

  ajoutPersonDialog(TransportRestController controller,
      TransportRestPersonnelsController controllerAgent) {
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
                            Expanded(child: prenomWidget(controllerAgent)),
                            const SizedBox(
                              width: p10,
                            ),
                            Expanded(child: nomWidget(controllerAgent))
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
                Obx(() => TextButton(
                  onPressed: () {
                    controllerAgent.submitTransRestAgents(
                        widget.transportRestaurationModel);
                  },
                  child: (controllerAgent.isLoading) ? loadingMini() : const Text('OK'),
                ),) 
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
    final PersonnelsController controllerPersonnels =
        Get.put(PersonnelsController());

    List<String> suggestionList =
        controllerPersonnels.personnelsList.map((e) => e.matricule).toList();
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: EasyAutocomplete( 
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: "Matricule",
            hintText: "-"),
          keyboardType: TextInputType.text,
          suggestions: suggestionList,
          progressIndicatorBuilder: loading(),
          validator: (value) {
            if (value != null && value.isEmpty) {
              return 'Mettre un tiret (-) si manquant';
            } else {
              return null;
            }
          },
          onChanged: (value) {
            controllerAgent.matricule = value;
          },
        ));
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
                child: Text(monnaieStorage.monney,
                    style: Theme.of(context).textTheme.headline6))
          ],
        ));
  }

  
}
