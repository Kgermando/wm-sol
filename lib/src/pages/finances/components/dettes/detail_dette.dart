import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/models/finances/dette_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/finances/components/creance_dette/table_dette_paiement.dart';
import 'package:wm_solution/src/pages/finances/components/dettes/approbation_dette.dart';
import 'package:wm_solution/src/pages/finances/controller/creance_dettes/creance_dette_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/dettes/dette_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/btn_widget.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/responsive_child3_widget.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class DetailDette extends StatefulWidget {
  const DetailDette({super.key, required this.detteModel});
  final DetteModel detteModel;

  @override
  State<DetailDette> createState() => _DetailDetteState();
}

class _DetailDetteState extends State<DetailDette> {
   final DetteController controller = Get.put(DetteController());
  final CreanceDetteController creanceDetteController = Get.find();
  final ProfilController profilController = Get.find();

  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Finances";

  bool isChecked = false;

  Future<DetteModel> refresh() async {
    final DetteModel dataItem =
        await controller.detailView(widget.detteModel.id!);
    return dataItem;
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
        key: scaffoldKey,
        appBar: headerBar(
            context, scaffoldKey, title, widget.detteModel.numeroOperation),
        drawer: const DrawerMenu(),
        floatingActionButton: Responsive.isMobile(context) 
          ? FloatingActionButton( 
              tooltip: "Ajout le paiement", 
              onPressed: () {
                dialongCreancePaiement(creanceDetteController);
              },
            )
          : FloatingActionButton.extended(
          label: const Text("Ajouter le paiement"),
          tooltip: "Ajout le paiement",
          icon: const Icon(Icons.add_card),
          onPressed: () {
            dialongCreancePaiement(creanceDetteController);
          },
        ),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: p20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const TitleWidget(title: "Dette"),
                                        Column(
                                          children: [
                                            IconButton(
                                                tooltip: 'Actualiser',
                                                onPressed: () async {
                                                  refresh().then((value) =>
                                                      Navigator.pushNamed(
                                                          context,
                                                          FinanceRoutes
                                                              .transactionsDetteDetail,
                                                          arguments: value));
                                                },
                                                icon: const Icon(Icons.refresh,
                                                    color: Colors.green)),
                                            SelectableText(
                                                DateFormat("dd-MM-yyyy HH:mm")
                                                    .format(widget
                                                        .detteModel.created),
                                                textAlign: TextAlign.start),
                                          ],
                                        )
                                      ],
                                    ),
                                    dataWidget(
                                        controller,
                                        creanceDetteController,
                                        profilController),
                                    totalMontant(
                                        controller, creanceDetteController),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: p20),
                            TableDettePaiement(
                                controller: creanceDetteController,
                                detteModel: widget.detteModel),
                            const SizedBox(height: p20),
                            ApprobationDette(
                                data: widget.detteModel,
                                controller: controller,
                                profilController: profilController)
                          ],
                        ),
                      )))
            ],
          ),
        ));
  }

  Widget totalMontant(DetteController controller,
      CreanceDetteController creanceDetteController) {
    double totalCreanceDette = 0.0;

    for (var item in creanceDetteController.creanceDetteList.where((e) =>
        e.creanceDette == "dettes" && e.reference == widget.detteModel.id)) {
      totalCreanceDette += double.parse(item.montant);
    }
    double total = 0.0;
    total = double.parse(widget.detteModel.montant) - totalCreanceDette;

    final headline6 = Theme.of(context).textTheme.headline6;
    return Padding(
      padding: const EdgeInsets.all(p10),
      child: Column(
        children: [
          ResponsiveChildWidget(
            flex1: 3,
            flex2: 1,
            child1: Text("TOTAL RESTANT :",
                textAlign: TextAlign.start,
                style: headline6!.copyWith(fontWeight: FontWeight.bold)),
            child2: Container(
              decoration: BoxDecoration(
                  border: Border(
                left: BorderSide(
                  color: mainColor,
                  width: 2,
                ),
              )),
              child: SelectableText(
                  "${NumberFormat.decimalPattern('fr').format(total)} ${monnaieStorage.monney}",
                  textAlign: TextAlign.center,
                  style: headline6.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.red.shade700)),
            ),
          )
        ],
      ),
    );
  }

  Widget dataWidget(
      DetteController controller,
      CreanceDetteController creanceDetteController,
      ProfilController profilController) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    double totalCreanceDette = 0.0;
    double total = 0.0;

    for (var item in creanceDetteController.creanceDetteList
        .where((e) => e.creanceDette == "creances")) {
      totalCreanceDette += double.parse(item.montant);
    }

    total = double.parse(widget.detteModel.montant) - totalCreanceDette;
    return Padding(
      padding: const EdgeInsets.all(p10),
      child: Column(
        children: [
          ResponsiveChildWidget(
            child1: Text('Titre :',
                textAlign: TextAlign.start,
                style: bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(widget.detteModel.nomComplet,
                textAlign: TextAlign.start, style: bodyMedium),
          ),
          Divider(color: mainColor),
          ResponsiveChildWidget(
            child1: Text('Pièce justificative :',
                textAlign: TextAlign.start,
                style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(widget.detteModel.pieceJustificative,
                textAlign: TextAlign.start, style: bodyMedium),
          ),
          Divider(color: mainColor),
          ResponsiveChildWidget(
            child1: Text('Libellé :',
                textAlign: TextAlign.start,
                style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(widget.detteModel.libelle,
                textAlign: TextAlign.start, style: bodyMedium),
          ),
          Divider(color: mainColor),
          ResponsiveChildWidget(
            child1: Text('Montant :',
                textAlign: TextAlign.start,
                style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(
                "${NumberFormat.decimalPattern('fr').format(double.parse(widget.detteModel.montant))} ${monnaieStorage.monney}",
                textAlign: TextAlign.start,
                style: bodyMedium),
          ),
          Divider(color: mainColor),
          ResponsiveChildWidget(
            child1: Text('Numéro d\'opération :',
                textAlign: TextAlign.start,
                style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(widget.detteModel.numeroOperation,
                textAlign: TextAlign.start, style: bodyMedium),
          ),
          Divider(color: mainColor),
          ResponsiveChildWidget(
            child1: Text('Signature :',
                textAlign: TextAlign.start,
                style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(widget.detteModel.signature,
                textAlign: TextAlign.start, style: bodyMedium),
          ),
          Divider(color: mainColor),
          ResponsiveChild3Widget(
            child1: Text('Statut :',
                textAlign: TextAlign.start,
                style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
            child2: (total == 0.0 &&
                    widget.detteModel.statutPaie == 'false' &&
                    profilController.user.departement == "Finances")
                ? checkboxRead(controller)
                : Container(),
            child3: (widget.detteModel.statutPaie == 'true')
                ? SelectableText('Payé',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(color: Colors.blue.shade700))
                : SelectableText('Non Payé',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(color: Colors.orange.shade700)),
          ),
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

  checkboxRead(DetteController controller) {
    if (widget.detteModel.statutPaie == 'true') {
      isChecked = true;
    } else if (widget.detteModel.statutPaie == 'false') {
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
            controller.submitobservation(widget.detteModel);
          });
        },
      ),
      title: const Text("Confirmation de Paiement"),
    );
  }

  dialongCreancePaiement(CreanceDetteController creanceDetteController) {
    return showDialog(
        context: context,
        // barrierDismissible: false,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            double totalCreanceDette = 0.0;

            for (var item in creanceDetteController.creanceDetteList) {
              totalCreanceDette += double.parse(item.montant);
            }
            double total = 0.0;
            total = double.parse(widget.detteModel.montant) - totalCreanceDette;
            return AlertDialog(
                content: SizedBox(
              height: (Responsive.isDesktop(context)) ? 400 : 480,
              child: Form(
                key: creanceDetteController.formKey,
                child: Padding(
                  padding: const EdgeInsets.all(p16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                              (Responsive.isDesktop(context))
                                  ? 'Ajout Paiement'
                                  : 'Paiement',
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(
                        height: p20,
                      ),
                      ResponsiveChildWidget(
                          child1: nomCompletWidget(creanceDetteController),
                          child2: libelleWidget(creanceDetteController)),
                      ResponsiveChildWidget(
                          child1:
                              pieceJustificativeWidget(creanceDetteController),
                          child2: montantWidget(creanceDetteController, total)),
                      const SizedBox(
                        height: p20,
                      ),
                      if (widget.detteModel.approbationDG == "-" ||
                          widget.detteModel.approbationDD == "-")
                        Text('Dette Non approuvé!',
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    color: Colors.red.shade700,
                                    fontWeight: FontWeight.bold)),
                      if (widget.detteModel.approbationDG == "Approved" &&
                          widget.detteModel.approbationDD == "Approved")
                        Obx(() => BtnWidget(
                            title: 'Soumettre',
                            isLoading: creanceDetteController.isLoading,
                            press: () {
                              final form =
                                  creanceDetteController.formKey.currentState!;
                              if (form.validate()) {
                                creanceDetteController
                                    .submitDette(widget.detteModel);
                                form.reset();
                              }
                            })) 
                    ],
                  ),
                ),
              ),
            ));
          });
        });
  }

  Widget nomCompletWidget(CreanceDetteController creanceDetteController) {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: creanceDetteController.nomCompletController,
          maxLength: 100,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Titre',
          ),
          keyboardType: TextInputType.text,
          validator: (value) => value != null && value.isEmpty
              ? 'Ce champs est obligatoire.'
              : null,
          style: const TextStyle(),
        ));
  }

  Widget pieceJustificativeWidget(
      CreanceDetteController creanceDetteController) {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: creanceDetteController.pieceJustificativeController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'N° de la pièce justificative',
          ),
          keyboardType: TextInputType.text,
          validator: (value) => value != null && value.isEmpty
              ? 'Ce champs est obligatoire.'
              : null,
          style: const TextStyle(),
        ));
  }

  Widget libelleWidget(CreanceDetteController creanceDetteController) {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: creanceDetteController.libelleController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Libellé',
          ),
          keyboardType: TextInputType.text,
          validator: (value) => value != null && value.isEmpty
              ? 'Ce champs est obligatoire.'
              : null,
          style: const TextStyle(),
        ));
  }

  Widget montantWidget(
      CreanceDetteController creanceDetteController, double total) {
    final headline6 = Theme.of(context).textTheme.headline6;
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: TextFormField(
                controller: creanceDetteController.montantController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    labelText: 'Montant',
                    hintText:
                        'Restant ${NumberFormat.decimalPattern('fr').format(total)} ${monnaieStorage.monney}'),
                validator: (value) => value != null && value.isEmpty
                    ? 'Ce champs est obligatoire.'
                    : null,
                style: const TextStyle(),
              ),
            ),
            const SizedBox(width: p20),
            Expanded(
                flex: 1,
                child: Text(
                  monnaieStorage.monney,
                  style: headline6!,
                ))
          ],
        ));
  }
}
