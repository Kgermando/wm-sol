import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/models/devis/devis_list_objets_model.dart';
import 'package:wm_solution/src/models/devis/devis_models.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/logistique/components/devis/approbation_devis.dart';
import 'package:wm_solution/src/pages/logistique/controller/devis/devis_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/devis/devis_list_objet_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/responsive_child3_widget.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class DetailDevis extends StatefulWidget {
  const DetailDevis({super.key, required this.devisModel});
  final DevisModel devisModel;

  @override
  State<DetailDevis> createState() => _DetailDevisState();
}

class _DetailDevisState extends State<DetailDevis> {
  final DevisController controller = Get.find();
  final DevisListObjetController devisListObjetController = Get.find();
  final ProfilController profilController = Get.find();
  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Devis";

  bool isChecked = false;

  Future<DevisModel> refresh() async {
    final DevisModel dataItem =
        await controller.detailView(widget.devisModel.id!);
    return dataItem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: headerBar(context, scaffoldKey, title, widget.devisModel.title),
      drawer: const DrawerMenu(),
      floatingActionButton: (widget.devisModel.isSubmit == 'false')
          ? addObjetDevisButton()
          : Container(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
              visible: !Responsive.isMobile(context),
              child: const Expanded(flex: 1, child: DrawerMenu())),
          Expanded(
              flex: 5,
              child: devisListObjetController.obx(
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: p20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TitleWidget(
                                            title:
                                                "Ticket n° ${widget.devisModel.id}"),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                IconButton(
                                                    tooltip: 'Actualiser',
                                                    color:
                                                        Colors.green.shade700,
                                                    onPressed: () {
                                                      refresh().then((value) =>
                                                          Navigator.pushNamed(
                                                              context,
                                                              DevisRoutes
                                                                  .devisDetail,
                                                              arguments:
                                                                  value));
                                                    },
                                                    icon: const Icon(
                                                        Icons.refresh)),
                                                if (widget.devisModel
                                                            .isSubmit ==
                                                        "false" ||
                                                    widget.devisModel
                                                            .approbationDG ==
                                                        "Unapproved" ||
                                                    widget.devisModel
                                                            .approbationDD ==
                                                        "Unapproved" ||
                                                    widget.devisModel
                                                            .approbationBudget ==
                                                        "Unapproved" ||
                                                    widget.devisModel
                                                            .approbationFin ==
                                                        "Unapproved")
                                                  IconButton(
                                                      tooltip:
                                                          'Soumettre chez le DD',
                                                      color:
                                                          Colors.teal.shade700,
                                                      onPressed: () {
                                                        controller.sendDD(
                                                            widget.devisModel);
                                                      },
                                                      icon: const Icon(
                                                          Icons.send)),
                                                if (widget.devisModel
                                                            .isSubmit ==
                                                        "false" ||
                                                    widget.devisModel
                                                            .approbationDG ==
                                                        "Unapproved" ||
                                                    widget.devisModel
                                                            .approbationDD ==
                                                        "Unapproved" ||
                                                    widget.devisModel
                                                            .approbationBudget ==
                                                        "Unapproved" ||
                                                    widget.devisModel
                                                            .approbationFin ==
                                                        "Unapproved")
                                                  deleteButton(controller),
                                              ],
                                            ),
                                            SelectableText(
                                                DateFormat("dd-MM-yyyy").format(
                                                    widget.devisModel.created),
                                                textAlign: TextAlign.start),
                                          ],
                                        )
                                      ],
                                    ),
                                    dataWidget(controller, profilController),
                                    SizedBox(
                                      height: 400,
                                      width: double.infinity,
                                      child: SingleChildScrollView(
                                          child: tableDevisListObjet(
                                              devisListObjetController)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: p20),
                            if (widget.devisModel.isSubmit == 'true')
                              ApprobationDevis(
                                devisModel: widget.devisModel,
                                controller: controller,
                                profilController: profilController,
                                state: state!,
                              )
                          ],
                        ),
                      ))))
        ],
      ),
    );
  }

  Widget dataWidget(
      DevisController controller, ProfilController profilController) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.all(p10),
      child: Column(
        children: [
          ResponsiveChildWidget(
              flex1: 1,
              flex2: 3,
              child1: Text('Titre :',
                  textAlign: TextAlign.start,
                  style: bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.devisModel.title,
                  textAlign: TextAlign.start, style: bodyMedium)),
          Divider(color: mainColor),
          ResponsiveChildWidget(
              flex1: 1,
              flex2: 3,
              child1: Text('Priorité :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.devisModel.priority,
                  textAlign: TextAlign.start, style: bodyMedium)),
          Divider(color: mainColor),
          ResponsiveChildWidget(
              flex1: 1,
              flex2: 3,
              child1: Text('Département :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.devisModel.departement,
                  textAlign: TextAlign.start, style: bodyMedium)),
          Divider(color: mainColor),
          ResponsiveChild3Widget(
              flex1: 1,
              flex2: 3,
              child1: Text('Observation :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: (widget.devisModel.observation == 'false' &&
                      profilController.user.departement == "Finances")
                  ? checkboxRead(controller)
                  : Container(),
              child3: (widget.devisModel.observation == 'true')
                  ? SelectableText(
                      'Payé',
                      style: bodyMedium.copyWith(
                          color: Colors.greenAccent.shade700),
                    )
                  : SelectableText(
                      'Non payé',
                      style:
                          bodyMedium.copyWith(color: Colors.redAccent.shade700),
                    )),
          Divider(color: mainColor),
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

  checkboxRead(DevisController controller) {
    if (widget.devisModel.observation == 'true') {
      isChecked = true;
    } else if (widget.devisModel.observation == 'false') {
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
            if (isChecked) {
              controller.submitObservation(widget.devisModel, 'true');
            } else {
              controller.submitObservation(widget.devisModel, 'false');
            }
          });
        },
      ),
      title: const Text("Confirmation de payement"),
    );
  }

  Widget deleteButton(DevisController controller) {
    return IconButton(
      icon: Icon(Icons.delete, color: Colors.red.shade700),
      tooltip: "Supprimer",
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Etes-vous sûr de faire cette action ?',
              style: TextStyle(color: Colors.red)),
          content: const Text(
              'Cette action permet de permet de mettre ce fichier en corbeille.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                controller.devisAPi.deleteData(widget.devisModel.id!);
                Navigator.pop(context);
              },
              child: Obx(() => controller.isLoading
                  ? loading()
                  : const Text('OK', style: TextStyle(color: Colors.red))),
            ),
          ],
        ),
      ),
    );
  }

  FloatingActionButton addObjetDevisButton() {
    return FloatingActionButton.extended(
      tooltip: "Ajout objet",
      label: const Text("Ajouter états de besoin"),
      icon: const Icon(Icons.add),
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Ajout votre devis', style: TextStyle(color: mainColor)),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            devisListObjetController.montantGlobal =
                devisListObjetController.quantity *
                    devisListObjetController.montantUnitaire;
            return SizedBox(
              height: 200,
              width: 500,
              child: devisListObjetController.isLoading
                  ? loading()
                  : Form(
                      key: devisListObjetController.formKey,
                      child: Column(
                        children: [
                          ResponsiveChildWidget(
                              flex1: 1,
                              flex2: 3,
                              child1: Container(
                                  margin: const EdgeInsets.only(
                                      bottom: p20, left: p20),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      labelText: 'Quantité',
                                    ),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        devisListObjetController.quantity =
                                            (value == "")
                                                ? 1
                                                : double.parse(value);
                                      });
                                    },
                                  )),
                              child2: Container(
                                  margin: const EdgeInsets.only(
                                      bottom: p20, left: p20),
                                  child: TextFormField(
                                    controller: devisListObjetController
                                        .designationController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      labelText: 'Désignation',
                                    ),
                                    keyboardType: TextInputType.text,
                                  ))),
                          ResponsiveChildWidget(
                              child1: Container(
                                  margin: const EdgeInsets.only(
                                      bottom: p20, left: p20),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      labelText: 'Montant unitaire',
                                    ),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        devisListObjetController
                                                .montantUnitaire =
                                            (value == "")
                                                ? 1
                                                : double.parse(value);
                                      });
                                    },
                                  )),
                              child2: Container(
                                  margin: const EdgeInsets.only(
                                      bottom: p20, left: p20),
                                  child: Column(
                                    children: [
                                      Text("Montant global",
                                          style: TextStyle(
                                              color: Colors.red.shade700)),
                                      Text(
                                          "${NumberFormat.decimalPattern('fr').format(double.parse(devisListObjetController.montantGlobal.toStringAsFixed(2)))} ${monnaieStorage.monney}",
                                          style: TextStyle(
                                              color: Colors.red.shade700)),
                                    ],
                                  )))
                        ],
                      ),
                    ),
            );
          }),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
            Obx(
              () => TextButton(
                onPressed: () {
                  devisListObjetController.submitObjet(widget.devisModel);
                  Navigator.pop(context, 'ok');
                },
                child: devisListObjetController.isLoading
                    ? loadingMini()
                    : const Text('OK'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget editObjetDevis(DevisListObjetsModel devisListObjetsModel) {
    return IconButton(
      tooltip: "Modification objet",
      icon: const Icon(
        Icons.edit,
        color: Colors.purple,
      ),
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Modification', style: TextStyle(color: mainColor)),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            devisListObjetController.quantity =
                double.parse(devisListObjetsModel.quantity);
            devisListObjetController.designationController =
                TextEditingController(text: devisListObjetsModel.designation);
            devisListObjetController.montantUnitaire =
                double.parse(devisListObjetsModel.montantUnitaire);

            devisListObjetController.montantGlobal =
                devisListObjetController.quantity *
                    devisListObjetController.montantUnitaire;
            return SizedBox(
              height: 200,
              width: 500,
              child: devisListObjetController.isLoading
                  ? loading()
                  : Form(
                      key: devisListObjetController.formKey,
                      child: Column(
                        children: [
                          ResponsiveChildWidget(
                              flex1: 1,
                              flex2: 3,
                              child1: Container(
                                  margin: const EdgeInsets.only(
                                      bottom: p20, left: p20),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      labelText: 'Quantité',
                                    ),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        devisListObjetController.quantity =
                                            (value == "")
                                                ? 1
                                                : double.parse(value);
                                      });
                                    },
                                  )),
                              child2: Container(
                                  margin: const EdgeInsets.only(
                                      bottom: p20, left: p20),
                                  child: TextFormField(
                                    controller: devisListObjetController
                                        .designationController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      labelText: 'Désignation',
                                    ),
                                    keyboardType: TextInputType.text,
                                  ))),
                          ResponsiveChildWidget(
                              child1: Container(
                                  margin: const EdgeInsets.only(
                                      bottom: p20, left: p20),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      labelText: 'Montant unitaire',
                                    ),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        devisListObjetController
                                                .montantUnitaire =
                                            (value == "")
                                                ? 1
                                                : double.parse(value);
                                      });
                                    },
                                  )),
                              child2: Container(
                                  margin: const EdgeInsets.only(
                                      bottom: p20, left: p20),
                                  child: Column(
                                    children: [
                                      Text("Montant global",
                                          style: TextStyle(
                                              color: Colors.red.shade700)),
                                      Text(
                                          "${NumberFormat.decimalPattern('fr').format(double.parse(devisListObjetController.montantGlobal.toStringAsFixed(2)))} ${monnaieStorage.monney}",
                                          style: TextStyle(
                                              color: Colors.red.shade700)),
                                    ],
                                  )))
                        ],
                      ),
                    ),
            );
          }),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
            Obx(
              () => TextButton(
                onPressed: () {
                  devisListObjetController
                      .submitUpdateObjet(devisListObjetsModel);
                },
                child: devisListObjetController.isLoading
                    ? loadingMini()
                    : const Text('OK'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget tableDevisListObjet(
      DevisListObjetController devisListObjetController) {
    return Table(
      border: TableBorder.all(color: mainColor),
      columnWidths: const {
        0: FixedColumnWidth(50.0), // fixed to 100 width
        1: FlexColumnWidth(200.0),
        2: FixedColumnWidth(150.0), //fixed to 100 width
        3: FixedColumnWidth(150.0),
        4: FixedColumnWidth(50.0),
        5: FixedColumnWidth(50.0)
      },
      children: [
        tableDevisHeader(),
        for (var item in devisListObjetController.devisListObjetList
            .where((element) => element.reference == widget.devisModel.id))
          tableDevisBody(item)
      ],
    );
  }

  TableRow tableDevisBody(DevisListObjetsModel devisListObjetsModel) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return TableRow(
      children: [
        Container(
          padding: const EdgeInsets.all(16.0 * 0.75),
          // decoration:
          //     BoxDecoration(border: Border.all(color: mainColor)),
          child: AutoSizeText(
            double.parse(devisListObjetsModel.quantity).toStringAsFixed(0),
            maxLines: 1,
            textAlign: TextAlign.center,
            style: bodyMedium,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16.0 * 0.75),
          // decoration:
          //     BoxDecoration(border: Border.all(color: mainColor)),
          child: AutoSizeText(
            devisListObjetsModel.designation,
            maxLines: 3,
            textAlign: TextAlign.center,
            style: bodyMedium,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16.0 * 0.75),
          // decoration:
          //     BoxDecoration(border: Border.all(color: mainColor)),
          child: AutoSizeText(
            "${NumberFormat.decimalPattern('fr').format(double.parse(double.parse(devisListObjetsModel.montantUnitaire).toStringAsFixed(2)))} ${monnaieStorage.monney}",
            maxLines: 1,
            textAlign: TextAlign.center,
            style: bodyMedium,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16.0 * 0.75),
          // decoration:
          //     BoxDecoration(border: Border.all(color: mainColor)),
          child: AutoSizeText(
            "${NumberFormat.decimalPattern('fr').format(double.parse(double.parse(devisListObjetsModel.montantGlobal).toStringAsFixed(2)))} ${monnaieStorage.monney}",
            maxLines: 1,
            textAlign: TextAlign.center,
            style: bodyMedium,
          ),
        ),
        if (widget.devisModel.isSubmit == 'false')
          Container(
              padding: const EdgeInsets.all(16.0 * 0.75),
              // decoration:
              //     BoxDecoration(border: Border.all(color: mainColor)),
              child: editObjetDevis(devisListObjetsModel)),
        if (widget.devisModel.isSubmit == 'false')
          Container(
            padding: const EdgeInsets.all(16.0 * 0.75),
            child: Obx(() => devisListObjetController.isLoading
                ? loadingMini()
                : IconButton(
                    onPressed: () {
                      devisListObjetController
                          .deleteData(devisListObjetsModel.id!); 
                    },
                    icon: const Icon(Icons.delete, color: Colors.red))),
          ),
        if (widget.devisModel.isSubmit == 'true')
          Container(
            padding: const EdgeInsets.all(16.0 * 0.75),
            child: const Icon(
              Icons.indeterminate_check_box,
              color: Colors.green,
            ),
          ),
        if (widget.devisModel.isSubmit == 'true')
          Container(
            padding: const EdgeInsets.all(16.0 * 0.75),
            child: const Icon(
              Icons.check_box,
              color: Colors.green,
            ),
          )
      ],
    );
  }

  TableRow tableDevisHeader() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return TableRow(children: [
      Container(
        padding: const EdgeInsets.all(16.0 * 0.75),
        // decoration:
        //     BoxDecoration(border: Border.all(color: mainColor)),
        child: AutoSizeText(
          "Qty".toUpperCase(),
          maxLines: 1,
          textAlign: TextAlign.center,
          style: bodyMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(16.0 * 0.75),
        // decoration:
        //     BoxDecoration(border: Border.all(color: mainColor)),
        child: AutoSizeText(
          "Désignation".toUpperCase(),
          maxLines: 1,
          textAlign: TextAlign.center,
          style: bodyMedium.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(16.0 * 0.75),
        // decoration:
        //     BoxDecoration(border: Border.all(color: mainColor)),
        child: AutoSizeText(
          "Montant unitaire".toUpperCase(),
          maxLines: 1,
          textAlign: TextAlign.center,
          style: bodyMedium.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(16.0 * 0.75),
        // decoration:
        //     BoxDecoration(border: Border.all(color: mainColor)),
        child: AutoSizeText(
          "Montant global".toUpperCase(),
          maxLines: 1,
          textAlign: TextAlign.center,
          style: bodyMedium.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(16.0 * 0.75),
        child: AutoSizeText(
          "Edit",
          maxLines: 1,
          textAlign: TextAlign.center,
          style: bodyMedium.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(16.0 * 0.75),
        child: AutoSizeText(
          "-",
          maxLines: 1,
          textAlign: TextAlign.center,
          style: bodyMedium.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    ]);
  }
}
