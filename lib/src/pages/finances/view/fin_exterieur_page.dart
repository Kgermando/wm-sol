import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/finances/components/fin_exterieur/table_fin_exterieur.dart';
import 'package:wm_solution/src/pages/finances/controller/fin_exterieur/fin_exterieur_controller.dart';
import 'package:wm_solution/src/widgets/btn_widget.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/models/finances/fin_exterieur_name_model.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class FinExterieurPage extends StatefulWidget {
  const FinExterieurPage({super.key, required this.finExterieurNameModel});
  final FinExterieurNameModel finExterieurNameModel;

  @override
  State<FinExterieurPage> createState() => _FinExterieurPageState();
}

class _FinExterieurPageState extends State<FinExterieurPage> {
  final FinExterieurController controller = Get.put(FinExterieurController());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Finances";
  String subTitle = "Autres finances";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: controller.obx(
          onLoading: loadingPage(context),
          onEmpty: const Text('Aucune donnée'),
          onError: (error) => loadingError(context, error!),
          (data) => Scaffold(
              key: scaffoldKey,
              appBar: headerBar(context, scaffoldKey, title, subTitle),
              drawer: const DrawerMenu(),
              floatingActionButton: speedialWidget(),
              body: Row(
                children: [
                  Visibility(
                      visible: !Responsive.isMobile(context),
                      child: const Expanded(flex: 1, child: DrawerMenu())),
                  Expanded(
                      flex: 5,
                      child: Container(
                          margin: const EdgeInsets.only(
                              top: p20, right: p20, left: p20, bottom: p8),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: TableFinExterieur(
                              finExterieurList: controller.finExterieurList
                                  .where((p0) =>
                                      p0.financeExterieurName ==
                                      widget.finExterieurNameModel.nomComplet)
                                  .toList(),
                              controller: controller,
                              finExterieurNameModel:
                                  widget.finExterieurNameModel))),
                ],
              ))),
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
          child: const Icon(Icons.upload),
          foregroundColor: Colors.white,
          backgroundColor: Colors.yellow.shade700,
          label: 'Retrait',
          onPressed: () {
            retraitDialog();
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.file_download),
          foregroundColor: Colors.white,
          backgroundColor: Colors.green.shade700,
          label: 'Dépôt',
          onPressed: () {
            depotDialog();
          },
        ),
      ],
      child: const Icon(
        Icons.menu,
        color: Colors.white,
      ),
    );
  }

  retraitDialog() {
    return showDialog(
        context: context,
        // barrierDismissible: false,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(p8),
                ),
                backgroundColor: Colors.transparent,
                child: SizedBox(
                  height: 400,
                  child: Form(
                    key: controller.formKeyRetrait,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(p16),
                        child: SizedBox(
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width / 2
                              : MediaQuery.of(context).size.width,
                          child: ListView(
                            children: [
                              const TitleWidget(
                                  title: 'Fin. exterieur Retrait'),
                              const SizedBox(
                                height: p20,
                              ),
                              ResponsiveChildWidget(
                                  child1: nomCompletWidget(),
                                  child2: pieceJustificativeWidget()),
                              ResponsiveChildWidget(
                                  child1: libelleWidget(),
                                  child2: pieceJustificativeWidget()),
                              const SizedBox(
                                height: p20,
                              ),
                              const SizedBox(
                                height: p20,
                              ),
                              BtnWidget(
                                  title: 'Soumettre',
                                  isLoading: controller.isLoading,
                                  press: () {
                                    final form =
                                        controller.formKeyRetrait.currentState!;
                                    if (form.validate()) {
                                      controller.submitRetrait(
                                          widget.finExterieurNameModel);
                                      form.reset();
                                    }
                                  })
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ));
          });
        });
  }

  depotDialog() {
    return showDialog(
        context: context,
        // barrierDismissible: false,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(p8),
                ),
                backgroundColor: Colors.transparent,
                child: SizedBox(
                  height: 400,
                  child: Form(
                    key: controller.formKeyDepot,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(p16),
                        child: SizedBox(
                          width: Responsive.isDesktop(context)
                              ? MediaQuery.of(context).size.width / 2
                              : MediaQuery.of(context).size.width,
                          child: ListView(
                            children: [
                              const TitleWidget(title: 'Fin. exterieur Depôt'),
                              const SizedBox(
                                height: p20,
                              ),
                              ResponsiveChildWidget(
                                  child1: nomCompletWidget(),
                                  child2: pieceJustificativeWidget()),
                              ResponsiveChildWidget(
                                  child1: libelleWidget(),
                                  child2: pieceJustificativeWidget()),
                              const SizedBox(
                                height: p20,
                              ),
                              const SizedBox(
                                height: p20,
                              ),
                              BtnWidget(
                                  title: 'Soumettre',
                                  isLoading: controller.isLoading,
                                  press: () {
                                    final form =
                                        controller.formKeyDepot.currentState!;
                                    if (form.validate()) {
                                      controller.submitDepot(
                                          widget.finExterieurNameModel);
                                      form.reset();
                                    }
                                  })
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ));
          });
        });
  }

  Widget nomCompletWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.nomCompletController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Nom complet',
          ),
          keyboardType: TextInputType.text,
          validator: (value) => value != null && value.isEmpty
              ? 'Ce champs est obligatoire.'
              : null,
          style: const TextStyle(),
        ));
  }

  Widget pieceJustificativeWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.pieceJustificativeController,
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

  Widget libelleWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.libelleController,
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

  Widget montantWidget() {
    final headline6 = Theme.of(context).textTheme.headline6;
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: TextFormField(
                controller: controller.montantController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  labelText: 'Montant',
                ),
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
                  "\$",
                  style: headline6!,
                ))
          ],
        ));
  }
}
