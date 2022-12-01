import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/models/logistiques/entretien_model.dart';
import 'package:wm_solution/src/models/logistiques/objet_remplace_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/logistique/components/entretiens/approbation_entretien.dart';
import 'package:wm_solution/src/pages/logistique/controller/entretiens/entretiens_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/entretiens/objet_remplace_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/materiels/materiel_controller.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class DetailEntretien extends StatefulWidget {
  const DetailEntretien({super.key, required this.entretienModel});
  final EntretienModel entretienModel;

  @override
  State<DetailEntretien> createState() => _DetailEntretienState();
}

class _DetailEntretienState extends State<DetailEntretien> {
  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());
  final EntretienController controller = Get.find();
  final ObjetRemplaceController objetRemplaceController = Get.find();
  final MaterielController materielController = Get.find();
  final ProfilController profilController = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Logistique";

  @override
  Widget build(BuildContext context) {
    return objetRemplaceController.obx(
        onLoading: loadingPage(context),
        onEmpty: const Text('Aucune donnée'),
        onError: (error) => loadingError(context, error!),
        (state) => Scaffold(
              key: scaffoldKey,
              appBar: headerBar(
                  context, scaffoldKey, title, widget.entretienModel.nom),
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
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TitleWidget(
                                                title:
                                                    widget.entretienModel.nom),
                                            Column(
                                              children: [
                                                if (widget.entretienModel
                                                        .approbationDD ==
                                                    "Unapproved")
                                                  Row(
                                                    children: [
                                                      IconButton(
                                                          tooltip: 'Actualiser',
                                                          color: Colors
                                                              .green.shade700,
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          icon: const Icon(
                                                              Icons.refresh)),
                                                      if (widget.entretienModel
                                                              .isSubmit ==
                                                          'false')
                                                        IconButton(
                                                            tooltip:
                                                                'Soumettre chez le DD',
                                                            color: Colors
                                                                .teal.shade700,
                                                            onPressed: () {
                                                              controller.sendDD(
                                                                  widget
                                                                      .entretienModel);
                                                            },
                                                            icon: const Icon(
                                                                Icons.send)),
                                                      // IconButton(
                                                      //     tooltip: 'Modifier',
                                                      //     onPressed: () {
                                                      //       Get.toNamed(
                                                      //           LogistiqueRoutes
                                                      //               .logEntretienUpdate,
                                                      //           arguments: widget
                                                      //               .entretienModel);
                                                      //     },
                                                      //     icon: const Icon(
                                                      //         Icons.edit)),
                                                      IconButton(
                                                          tooltip: 'Supprimer',
                                                          onPressed: () async {
                                                            alertDeleteDialog(
                                                                controller);
                                                          },
                                                          icon: const Icon(
                                                              Icons.delete),
                                                          color: Colors
                                                              .red.shade700),
                                                    ],
                                                  ),
                                                SelectableText(
                                                    DateFormat("dd-MM-yyyy")
                                                        .format(widget
                                                            .entretienModel
                                                            .created),
                                                    textAlign: TextAlign.start),
                                              ],
                                            )
                                          ],
                                        ),
                                        dataWidget()
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: p20),
                                // TableObjetRemplace(
                                //     objetRemplaceList: objetRemplaceController
                                //         .objetRemplaceList,
                                //     entretienModel: widget.entretienModel),

                                objetRemplaceWidget(objetRemplaceController),
                                const SizedBox(height: p20),
                                if (widget.entretienModel.isSubmit == 'true')
                                  ApprobationEntretien(
                                      data: widget.entretienModel,
                                      controller: controller,
                                      profilController: profilController)
                              ],
                            ),
                          )))
                ],
              ),
            ));
  }

  alertDeleteDialog(EntretienController controller) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Etes-vous sûr de vouloir faire ceci ?',
                  style: TextStyle(color: Colors.red)),
              content: const SizedBox(
                  height: 100,
                  width: 100,
                  child: Text("Cette action permet de supprimer le document")),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Annuler',
                      style: TextStyle(color: Colors.red)),
                ),
                TextButton(
                  onPressed: () {
                    controller.entretienApi
                        .deleteData(widget.entretienModel.id!);
                    Navigator.pop(context, 'ok');
                  },
                  child: const Text('OK', style: TextStyle(color: Colors.red)),
                ),
              ],
            );
          });
        });
  }

  Widget dataWidget() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.all(p10),
      child: Column(
        children: [
          ResponsiveChildWidget(
              child1: Text('Nom Complet :',
                  textAlign: TextAlign.start,
                  style: bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.entretienModel.nom,
                  textAlign: TextAlign.start, style: bodyMedium)),
          Divider(
            color: mainColor,
          ),
          ResponsiveChildWidget(
              child1: Text("Type d'Objet :",
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.entretienModel.typeObjet,
                  textAlign: TextAlign.start, style: bodyMedium)),
          Divider(
            color: mainColor,
          ),
          ResponsiveChildWidget(
              child1: Text('Type de Maintenance :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.entretienModel.typeMaintenance,
                  textAlign: TextAlign.start, style: bodyMedium)),
          Divider(
            color: mainColor,
          ),
          ResponsiveChildWidget(
              child1: Text('Signature :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.entretienModel.signature,
                  textAlign: TextAlign.start, style: bodyMedium)),
        ],
      ),
    );
  }

  Widget objetRemplaceWidget(ObjetRemplaceController objetRemplaceController) {
    return Container(
      padding: const EdgeInsets.all(p20),
      color: Colors.blue[100],
      child: Column(
        children: [
          tableWidget(),
          const SizedBox(height: p20),
          if (widget.entretienModel.isSubmit == 'false')
            Form(
              key: objetRemplaceController.formObjetKey,
              child: Column(
                children: [
                  ResponsiveChildWidget(
                      child1: nomObjetWidget(), child2: coutWidget()),
                  ResponsiveChildWidget(
                      child1: caracteristiqueWidget(),
                      child2: observationWidget()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                          onPressed: () {
                            final formObjetKey = objetRemplaceController
                                .formObjetKey.currentState!;
                            if (formObjetKey.validate()) {
                              objetRemplaceController
                                  .submitObjetRemplace(widget.entretienModel);
                              formObjetKey.reset();
                            }
                          },
                          icon: const Icon(
                            Icons.save,
                            color: Colors.white,
                          ),
                          label: Text("Ajout l'objet",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.white))),
                    ],
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget tableWidget() {
    var dataList = objetRemplaceController.objetRemplaceList
        .where((p0) => p0.reference == widget.entretienModel.id)
        .toList();
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          TitleWidget(
              title: Responsive.isDesktop(context)
                  ? "Ajouter les objets remplacés"
                  : "Add objet"),
        ]),
        if (!Responsive.isMobile(context)) tableWidgetDesktop(dataList),
        if (Responsive.isMobile(context))
          Scrollbar(
              controller: objetRemplaceController.controllerTable,
              child: tableWidgetMobile(dataList))
      ],
    );
  }

  Widget tableWidgetDesktop(List<ObjetRemplaceModel> objetRemplace) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.only(bottom: p20),
      child: Table(
        border: TableBorder.all(color: mainColor),
        columnWidths: const {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(4),
          3: FlexColumnWidth(4),
          4: FlexColumnWidth(1),
        },
        children: [
          TableRow(children: [
            Container(
              padding: const EdgeInsets.all(p10),
              child: Text("Nom", textAlign: TextAlign.start, style: bodyMedium),
            ),
            Container(
              padding: const EdgeInsets.all(p10),
              child:
                  Text("Coût", textAlign: TextAlign.center, style: bodyMedium),
            ),
            Container(
              padding: const EdgeInsets.all(p10),
              child: Text("Caracteristique",
                  textAlign: TextAlign.start, style: bodyMedium),
            ),
            Container(
              padding: const EdgeInsets.all(p10),
              child: Text("Observation",
                  textAlign: TextAlign.start, style: bodyMedium),
            ),
            Container(
              padding: const EdgeInsets.all(p10),
              child: Text("Retirer",
                  textAlign: TextAlign.start, style: bodyMedium),
            ),
          ]),
          for (var item in objetRemplace)
            tableDataWidget(item.nom, item.cout, item.caracteristique,
                item.observation, item.id!)
        ],
      ),
    );
  }

  Widget tableWidgetMobile(List<ObjetRemplaceModel> objetRemplace) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: objetRemplaceController.controllerTable,
      child: Container(
        constraints:
            BoxConstraints(minWidth: MediaQuery.of(context).size.width * 2),
        child: Table(
          border: TableBorder.all(color: mainColor),
          columnWidths: const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(4),
            3: FlexColumnWidth(4),
            4: FlexColumnWidth(1),
          },
          children: [
            TableRow(children: [
              Container(
                padding: const EdgeInsets.all(p10),
                child:
                    Text("Nom", textAlign: TextAlign.start, style: bodyMedium),
              ),
              Container(
                padding: const EdgeInsets.all(p10),
                child: Text("Coût",
                    textAlign: TextAlign.center, style: bodyMedium),
              ),
              Container(
                padding: const EdgeInsets.all(p10),
                child: Text("Caracteristique",
                    textAlign: TextAlign.start, style: bodyMedium),
              ),
              Container(
                padding: const EdgeInsets.all(p10),
                child: Text("Observation",
                    textAlign: TextAlign.start, style: bodyMedium),
              ),
              Container(
                padding: const EdgeInsets.all(p10),
                child: Text("Retirer",
                    textAlign: TextAlign.start, style: bodyMedium),
              ),
            ]),
            for (var item in objetRemplace)
              tableDataWidget(item.nom, item.cout, item.caracteristique,
                  item.observation, item.id!)
          ],
        ),
      ),
    );
  }

  TableRow tableDataWidget(
      String nom, String cout, String caraterique, String observation, int id) {
    double coutProduit = (cout == '') ? double.parse('0') : double.parse(cout);
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;

    return TableRow(children: [
      Container(
        padding: const EdgeInsets.all(p10),
        child:
            SelectableText(nom, textAlign: TextAlign.start, style: bodyMedium),
      ),
      Container(
        padding: const EdgeInsets.all(p10),
        child: SelectableText(
            "${NumberFormat.decimalPattern('fr').format(coutProduit)} ${monnaieStorage.monney}",
            textAlign: TextAlign.center,
            style: bodyMedium),
      ),
      Container(
        padding: const EdgeInsets.all(p10),
        child: SelectableText(caraterique,
            textAlign: TextAlign.start, style: bodyMedium),
      ),
      Container(
        padding: const EdgeInsets.all(p10),
        child: SelectableText(observation,
            textAlign: TextAlign.start, style: bodyMedium),
      ),
      if (widget.entretienModel.isSubmit == 'false')
        Container(
            padding: const EdgeInsets.all(p10),
            child: IconButton(
                tooltip: "Actualiser après suppression",
                color: Colors.red,
                onPressed: () {
                  objetRemplaceController.objetRemplaceApi.deleteData(id);
                },
                icon: const Icon(Icons.delete))),
      if (widget.entretienModel.isSubmit == 'true')
        Container(
          padding: const EdgeInsets.all(p10),
          child: const Icon(
            Icons.check_box,
            color: Colors.green,
          ),
        )
    ]);
  }

  Widget nomObjetWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: objetRemplaceController.nomObjetController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Nom',
          ),
          keyboardType: TextInputType.text,
          style: const TextStyle(),
        ));
  }

  Widget coutWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: Container(
              margin: const EdgeInsets.only(bottom: p20),
              child: TextFormField(
                controller: objetRemplaceController.coutController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  labelText: 'Coût',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
                style: const TextStyle(),
              )),
        ),
        const SizedBox(width: p20),
        Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(bottom: p8),
              child: Text(monnaieStorage.monney,
                  style: Theme.of(context).textTheme.headline6),
            ))
      ],
    );
  }

  Widget caracteristiqueWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: objetRemplaceController.caracteristiqueController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Caracteristique',
          ),
          keyboardType: TextInputType.text,
          style: const TextStyle(),
        ));
  }

  Widget observationWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: objetRemplaceController.observationController,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              labelText: 'Observation',
              hintText: 'En etat de marche, pause probleme de compatibilité'),
          keyboardType: TextInputType.text,
          style: const TextStyle(),
        ));
  }
}
