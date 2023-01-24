import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/logistiques/approvisionnement_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/logistique/components/approvisionnements/table_history_approvision.dart';
import 'package:wm_solution/src/pages/logistique/controller/approvisions/approvision_reception_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/approvisions/approvisionnement_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';

class DetailApprovisionnement extends StatefulWidget {
  const DetailApprovisionnement(
      {super.key, required this.approvisionnementModel});
  final ApprovisionnementModel approvisionnementModel;

  @override
  State<DetailApprovisionnement> createState() =>
      _DetailApprovisionnementState();
}

class _DetailApprovisionnementState extends State<DetailApprovisionnement> {
  final ApprovisionnementController controller = Get.put(ApprovisionnementController());
  final ApprovisionReceptionController approvisionReceptionController =
      Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Logistique";

  Future<ApprovisionnementModel> refresh() async {
    final ApprovisionnementModel dataItem =
        await controller.detailView(widget.approvisionnementModel.id!);
    return dataItem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
              key: scaffoldKey,
              appBar: headerBar(context, scaffoldKey, title,
                  widget.approvisionnementModel.provision),
              drawer: const DrawerMenu(),
              floatingActionButton: speedialWidget(),
              body: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                      visible: !Responsive.isMobile(context),
                      child: const Expanded(flex: 1, child: DrawerMenu())),
                  Expanded(
                      flex: 5,
                      child: approvisionReceptionController.obx(
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
                                              MainAxisAlignment.end,
                                          children: [
                                            Column(
                                              children: [
                                                IconButton(
                                                    tooltip: 'Actualiser',
                                                    onPressed: () async {
                                                      refresh().then((value) =>
                                                          Navigator.pushNamed(
                                                              context,
                                                              LogistiqueRoutes
                                                                  .logApprovisionnementDetail,
                                                              arguments:
                                                                  value));
                                                    },
                                                    icon: const Icon(
                                                        Icons.refresh,
                                                        color: Colors.green)),
                                                SelectableText(
                                                    DateFormat(
                                                            "dd-MM-yyyy HH:mm")
                                                        .format(widget
                                                            .approvisionnementModel
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
                              TableHistoryApprovision(
                                approvisionnementList: controller
                                        .approvisionnementList
                                        .where((element) =>
                                            element.provision ==
                                            widget.approvisionnementModel
                                                .provision)
                                        .toList(),
                                controller: controller)
                              ],
                            ),
                          ))) )
                ],
              ),
            )
    
    ;
  }

  Widget dataWidget() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.all(p10),
      child: Column(
        children: [
          ResponsiveChildWidget(
              child1: Text('Produit :',
                  textAlign: TextAlign.start,
                  style: bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.approvisionnementModel.provision,
                  textAlign: TextAlign.start, style: bodyMedium)),
          Divider(
            color: mainColor,
          ),
          ResponsiveChildWidget(
              child1: Text('Quantité Total :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(
                  '${double.parse(widget.approvisionnementModel.quantityTotal).toStringAsFixed(0)} ${widget.approvisionnementModel.unite}',
                  textAlign: TextAlign.start,
                  style: bodyMedium)),
          Divider(
            color: mainColor,
          ),
          ResponsiveChildWidget(
              child1: Text('Quantité disponible :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(
                  '${double.parse(widget.approvisionnementModel.quantity).toStringAsFixed(0)} ${widget.approvisionnementModel.unite}',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(color: Colors.blueGrey))),
          Divider(
            color: mainColor,
          ),
          ResponsiveChildWidget(
              child1: Text('Signature :',
                  textAlign: TextAlign.start,
                  style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              child2: SelectableText(widget.approvisionnementModel.signature,
                  textAlign: TextAlign.start, style: bodyMedium)),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  SpeedDial speedialWidget() {
    return SpeedDial(
      closedForegroundColor: themeColor,
      openForegroundColor: Colors.white,
      closedBackgroundColor: themeColor,
      openBackgroundColor: themeColor,
      speedDialChildren: <SpeedDialChild>[
        SpeedDialChild(
          child: const Icon(Icons.shopping_cart_checkout),
          foregroundColor: Colors.white,
          backgroundColor: Colors.teal.shade700,
          label: 'Sortie',
          onPressed: () {
            qtyQtockDialog();
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.add_shopping_cart),
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue.shade700,
          label: 'Entrée',
          onPressed: () {
            newDialog();
          },
        ),
      ],
      child: const Icon(
        Icons.menu,
        color: Colors.white,
      ),
    );
  }

  qtyQtockDialog() {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              title: Text(
                  "${widget.approvisionnementModel.provision} ${widget.approvisionnementModel.unite}"),
              content: Form(
                key: approvisionReceptionController.receptionFormKey,
                child: SizedBox(
                  height: 300,
                  width: 300,
                  child: Column(
                    children: [qtyReceptionWidget(), departementWidget()],
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Annuler'),
                ),
                TextButton(
                  onPressed: () {
                    final form = approvisionReceptionController
                        .receptionFormKey.currentState!;
                    if (form.validate()) {
                      approvisionReceptionController
                          .submit(widget.approvisionnementModel);
                      controller.submitReste(widget.approvisionnementModel,
                          approvisionReceptionController.qtyController);

                      form.reset();
                    }
                    Navigator.pop(context, 'ok');
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          });
        });
  }

  newDialog() {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              scrollable: true,
              title: Text('Ravitaillement', style: TextStyle(color: mainColor)),
              content: SizedBox(
                  height: Responsive.isDesktop(context) ? 350 : 600,
                  width: 500,
                  child: Form(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Text(widget.approvisionnementModel.provision,
                              style: Theme.of(context).textTheme.headlineSmall),
                          quantityWidget(),
                          const SizedBox(
                            height: p20,
                          ),
                        ],
                      ))),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Annuler'),
                ),
                TextButton(
                  onPressed: () {
                    final form = controller.formKey.currentState!;
                    if (form.validate()) {
                      controller
                          .submitRavitaillement(widget.approvisionnementModel);
                      form.reset();
                    }
                    Navigator.pop(context, 'ok');
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          });
        });
  }

  Widget quantityWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: Container(
              margin: const EdgeInsets.only(bottom: p20),
              child: TextFormField(
                controller: controller.quantityController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  labelText: 'Quantité',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
                style: const TextStyle(),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Ce champs est obligatoire';
                  } else {
                    return null;
                  }
                },
              )),
        ),
        Expanded(
            child: Text(widget.approvisionnementModel.unite,
                style: Theme.of(context).textTheme.headlineSmall))
      ],
    );
  }

  Widget departementWidget() {
    return Container(
      margin: const EdgeInsets.only(bottom: p20),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Département',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: approvisionReceptionController.departement,
        isExpanded: true,
        items:
            approvisionReceptionController.departementList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        validator: (value) => value == null ? "Select département" : null,
        onChanged: (value) {
          setState(() {
            approvisionReceptionController.departement = value!;
          });
        },
      ),
    );
  }

  Widget qtyReceptionWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: approvisionReceptionController.qtyController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Qty',
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
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
}
