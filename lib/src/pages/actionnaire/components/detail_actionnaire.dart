import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/models/actionnaire/actionnaire_cotisation_model.dart';
import 'package:wm_solution/src/models/actionnaire/actionnaire_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/actionnaire/components/table_cotisation_personne.dart';
import 'package:wm_solution/src/pages/actionnaire/controller/actionnaire_controller.dart';
import 'package:wm_solution/src/pages/actionnaire/controller/actionnaire_cotisation_controller.dart';
import 'package:wm_solution/src/pages/actionnaire/controller/actionnaire_transfert_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/btn_widget.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class DetailActionnaire extends StatefulWidget {
  const DetailActionnaire({super.key, required this.actionnaireModel});
  final ActionnaireModel actionnaireModel;

  @override
  State<DetailActionnaire> createState() => _DetailActionnaireState();
}

class _DetailActionnaireState extends State<DetailActionnaire> {
  final ActionnaireController actionnaireController = Get.find();
  final ActionnaireCotisationController controller = Get.find();
  final ActionnaireTransfertController actionnaireTransfertController =
      Get.find();
  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Actionnaire";

  Future<ActionnaireModel> refresh() async {
    final ActionnaireModel dataItem =
        await actionnaireController.detailView(widget.actionnaireModel.id!);
    return dataItem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar:
          headerBar(context, scaffoldKey, title, widget.actionnaireModel.nom),
      drawer: const DrawerMenu(),
      floatingActionButton: speedialWidget(),
      body: controller.obx(
          onLoading: loadingPage(context),
          onEmpty: const Text('Aucune donnée'),
          onError: (error) => loadingError(context, error!),
          (state) => Row(
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
                                            const TitleWidget(
                                                title: 'Actionnaire'),
                                            Column(
                                              children: [
                                                IconButton(
                                                    tooltip: 'Actualiser',
                                                    onPressed: () async {
                                                      refresh().then((value) =>
                                                          Navigator.pushNamed(
                                                              context,
                                                              ActionnaireRoute
                                                                  .actionnaireDetail,
                                                              arguments:
                                                                  value));
                                                    },
                                                    icon: const Icon(
                                                        Icons.refresh,
                                                        color: Colors.green)),
                                                SelectableText(
                                                    DateFormat("dd-MM-yy HH:mm")
                                                        .format(widget
                                                            .actionnaireModel
                                                            .created),
                                                    textAlign: TextAlign.start),
                                              ],
                                            )
                                          ],
                                        ),
                                        dataWidget(),
                                        Divider(
                                          color: mainColor,
                                        ),
                                        const SizedBox(height: p10),
                                        total(state!),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: p20),
                                TableCotisationPersonne(
                                    state: state
                                        .where((element) =>
                                            element.reference ==
                                            widget.actionnaireModel.id!)
                                        .toList())
                              ],
                            ),
                          )))
                ],
              )),
    );
  }

  Widget dataWidget() {
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    return Padding(
      padding: const EdgeInsets.all(p10),
      child: Column(
        children: [
          const SizedBox(height: p30),
          ResponsiveChildWidget(
            flex1: 1,
            flex2: 3,
            child1: Text('Nom :',
                textAlign: TextAlign.start,
                style: bodyLarge!.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(widget.actionnaireModel.nom,
                textAlign: TextAlign.start, style: bodyLarge),
          ),
          Divider(
            color: mainColor,
          ),
          ResponsiveChildWidget(
            flex1: 1,
            flex2: 3,
            child1: Text('PostNom :',
                textAlign: TextAlign.start,
                style: bodyLarge.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(widget.actionnaireModel.postNom,
                textAlign: TextAlign.start, style: bodyLarge),
          ),
          Divider(
            color: mainColor,
          ),
          ResponsiveChildWidget(
            flex1: 1,
            flex2: 3,
            child1: Text('Prenom :',
                textAlign: TextAlign.start,
                style: bodyLarge.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(widget.actionnaireModel.prenom,
                textAlign: TextAlign.start, style: bodyLarge),
          ),
          Divider(
            color: mainColor,
          ),
          ResponsiveChildWidget(
            flex1: 1,
            flex2: 3,
            child1: Text('Email :',
                textAlign: TextAlign.start,
                style: bodyLarge.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(widget.actionnaireModel.email,
                textAlign: TextAlign.start, style: bodyLarge),
          ),
          Divider(
            color: mainColor,
          ),
          ResponsiveChildWidget(
            flex1: 1,
            flex2: 3,
            child1: Text('Telephone :',
                textAlign: TextAlign.start,
                style: bodyLarge.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(widget.actionnaireModel.telephone,
                textAlign: TextAlign.start, style: bodyLarge),
          ),
          Divider(
            color: mainColor,
          ),
          ResponsiveChildWidget(
            flex1: 1,
            flex2: 3,
            child1: Text('Adresse :',
                textAlign: TextAlign.start,
                style: bodyLarge.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(widget.actionnaireModel.adresse,
                textAlign: TextAlign.start, style: bodyLarge),
          ),
          Divider(
            color: mainColor,
          ),
          ResponsiveChildWidget(
            flex1: 1,
            flex2: 3,
            child1: Text('Sexe :',
                textAlign: TextAlign.start,
                style: bodyLarge.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(widget.actionnaireModel.sexe,
                textAlign: TextAlign.start, style: bodyLarge),
          ),
          Divider(
            color: mainColor,
          ),
          ResponsiveChildWidget(
            flex1: 1,
            flex2: 3,
            child1: Text('Matricule :',
                textAlign: TextAlign.start,
                style: bodyLarge.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(widget.actionnaireModel.matricule,
                textAlign: TextAlign.start, style: bodyLarge),
          ),
          Divider(
            color: mainColor,
          ),
          ResponsiveChildWidget(
            flex1: 1,
            flex2: 3,
            child1: Text('Signature :',
                textAlign: TextAlign.start,
                style: bodyLarge.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(widget.actionnaireModel.signature,
                textAlign: TextAlign.start, style: bodyLarge),
          ),
        ],
      ),
    );
  }

  Widget total(List<ActionnaireCotisationModel> state) {
    final headline6 = Theme.of(context).textTheme.headline6;
    var totalCotisation = state
        .where((element) => element.reference == widget.actionnaireModel.id!)
        .toList();
    var totalTransfer = actionnaireTransfertController.actionnaireTransfertList
        .where((element) =>
            element.matriculeRecu == widget.actionnaireModel.matricule)
        .toList();

    double motantCotise = 0.0;
    double motantRecuTransfert = 0.0;

    for (var element in totalCotisation) {
      motantCotise += double.parse(element.montant);
    }
    for (var element in totalTransfer) {
      motantRecuTransfert += double.parse(element.montant);
    }

    double montantTransferer =
        widget.actionnaireModel.cotisations - motantCotise;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total cotiser', style: headline6),
                Text(
                    '${NumberFormat.decimalPattern('fr').format(widget.actionnaireModel.cotisations)} ${monnaieStorage.monney}',
                    style: headline6!.copyWith(color: Colors.red.shade700, fontWeight: FontWeight.bold)),
              ],
            ),
            Divider(
              color: Colors.red.shade700,
            ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Montant transferer', style: headline6),
                  (montantTransferer.isNegative) 
                    ? Text(
                      '${NumberFormat.decimalPattern('fr').format(0.0)} ${monnaieStorage.monney}',
                      style: headline6.copyWith(color: Colors.orange.shade700)) 
                    : Text(
                      '${NumberFormat.decimalPattern('fr').format(montantTransferer)} ${monnaieStorage.monney}',
                      style: headline6.copyWith(color: Colors.orange.shade700)),
                ],
              ),
            Divider(
              color: Colors.red.shade700,
            ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Montant reçu par transfer', style: headline6),
                  Text(
                      '${NumberFormat.decimalPattern('fr').format(motantRecuTransfert)} ${monnaieStorage.monney}',
                      style: headline6.copyWith(color: Colors.brown.shade700)),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget speedialWidget() {
    return SpeedDial(
      closedForegroundColor: themeColor,
      openForegroundColor: Colors.white,
      closedBackgroundColor: themeColor,
      openBackgroundColor: themeColor,
      speedDialChildren: <SpeedDialChild>[
        SpeedDialChild(
          child: const Icon(
            Icons.content_paste_sharp,
            size: 15.0,
          ),
          foregroundColor: Colors.white,
          backgroundColor: Colors.orange.shade700,
          label: 'Ajout cotisation',
          onPressed: () {
            showModalBottomSheet<void>(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return Container(
                  color: Colors.amber.shade100,
                  padding: const EdgeInsets.all(p20),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                                    "Ajouté la cotisation".toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium)),
                          ],
                        ),
                        const SizedBox(
                          height: p20,
                        ),
                        montant(),
                        noteWidget(),
                        moyenPaiementWidget(),
                        numeroTransactionWidget(),
                        const SizedBox(
                          height: p50,
                        ),
                        Obx(() => BtnWidget(
                            title: "Soumettre",
                            press: () {
                              final form = controller.formKey.currentState!;
                              if (form.validate()) {
                                controller
                                    .addCotisation(widget.actionnaireModel);
                                form.reset();
                                Navigator.pop(context, 'ok');
                              }
                            },
                            isLoading: controller.isLoading))
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
        SpeedDialChild(
            child: const Icon(Icons.monetization_on),
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue.shade700,
            label: 'Transferer les parts',
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    color: Colors.amber.shade100,
                    padding: const EdgeInsets.all(p20),
                    child: Form(
                      key: actionnaireTransfertController.formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                      "Transferer les actions".toUpperCase(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium)),
                            ],
                          ),
                          const SizedBox(
                            height: p20,
                          ),
                          montantTransfert(),
                          matriculeRecuTransfert(),
                          const SizedBox(
                            height: p20,
                          ),
                          Obx(() => BtnWidget(
                              title: "Soumettre",
                              press: () {
                                final form = actionnaireTransfertController
                                    .formKey.currentState!;
                                if (form.validate()) {
                                  actionnaireTransfertController
                                      .transfertAction( 
                                          widget.actionnaireModel,
                                          actionnaireTransfertController
                                              .montantController.text,
                                          widget.actionnaireModel.matricule);
                                  form.reset();
                                  Navigator.pop(context, 'ok');
                                }
                              },
                              isLoading: controller.isLoading))
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
      ],
      child: const Icon(
        Icons.menu,
        color: Colors.white,
      ),
    );
  }

  Widget montant() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.montantController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Montant ${monnaieStorage.monney}',
          ),
          validator: (value) {
            if (value != null && value.isEmpty) {
              return 'Ce champs est obligatoire';
            } else {
              return null;
            }
          },
        ));
  }

  Widget noteWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.noteController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Note',
          ),
          keyboardType: TextInputType.text,
          style: const TextStyle(),
          // validator: (value) {
          //   if (value != null && value.isEmpty) {
          //     return 'Ce champs est obligatoire';
          //   } else {
          //     return null;
          //   }
          // },
        ));
  }

  Widget moyenPaiementWidget() {
    List<String> suggestionList = controller.actionnaireCotisationList
        .map((e) => e.moyenPaiement)
        .toSet()
        .toList();
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: EasyAutocomplete(
          controller: controller.moyenPaiementController,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              labelText: "Moyen de Paiement",
              hintText: "Carte bancaire, check, Mobile money ..."),
          keyboardType: TextInputType.text,
          suggestions: suggestionList,
          validator: (value) {
            if (value != null && value.isEmpty) {
              return 'Ce champs est obligatoire';
            } else {
              return null;
            }
          },
        ));
  }

  Widget numeroTransactionWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.numeroTransactionController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Code de refence',
          ),
          keyboardType: TextInputType.text,
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

  Widget montantTransfert() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: actionnaireTransfertController.montantController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Montant ${monnaieStorage.monney}',
          ),
          validator: (value) {
            if (value != null && value.isEmpty) {
              return 'Ce champs est obligatoire';
            } else {
              return null;
            }
          },
        ));
  }

  Widget matriculeRecuTransfert() {
    var actionnaireList = actionnaireController.actionnaireList
        .map((e) => e.matricule)
        .toSet()
        .toList();
    actionnaireList.remove(widget.actionnaireModel.matricule);
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Selectionner le matricule',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: actionnaireTransfertController.matriculeRecu,
        isExpanded: true,
        items: actionnaireList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        validator: (value) =>
            value == null ? "Select matricule reception" : null,
        onChanged: (value) {
          setState(() {
            actionnaireTransfertController.matriculeRecu = value;
          });
        },
      ),
    );
  }
}
