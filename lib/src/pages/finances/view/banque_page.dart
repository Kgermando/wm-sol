import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/finances/components/banques/table_banque.dart';
import 'package:wm_solution/src/pages/finances/controller/banques/banque_controller.dart';
import 'package:wm_solution/src/widgets/btn_widget.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/models/finances/banque_name_model.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class BanquePage extends StatefulWidget {
  const BanquePage({super.key, required this.banqueNameModel});
  final BanqueNameModel banqueNameModel;

  @override
  State<BanquePage> createState() => _BanquePageState();
}

class _BanquePageState extends State<BanquePage> {
  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());
  final BanqueController controller = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Finances";
  String subTitle = "Banques";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: controller.obx(
            onLoading: loadingPage(context),
            onEmpty: const Text('Aucune donnée'),
            onError: (error) => loadingError(context, error!),
            (data) => Container(
                            margin: const EdgeInsets.only(
                                top: p20, right: p20, left: p20, bottom: p8),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: TableBanque(
                                banqueList: controller.banqueList
                                    .where((p0) =>
                                        p0.banqueName ==
                                        widget.banqueNameModel.nomComplet)
                                    .toList(),
                                controller: controller,
                                banqueNameModel: widget.banqueNameModel))) ),
                  ],
                )
        
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
                              const TitleWidget(title: 'Banque Retrait'),
                              const SizedBox(
                                height: p20,
                              ),
                              ResponsiveChildWidget(
                                  child1: nomCompletWidget(),
                                  child2: pieceJustificativeWidget()),
                              ResponsiveChildWidget(
                                  child1: libelleWidget(),
                                  child2: montantWidget()),
                              const SizedBox(
                                height: p20,
                              ),
                              const SizedBox(
                                height: p20,
                              ),
                              Obx(() => BtnWidget(
                                  title: 'Soumettre',
                                  isLoading: controller.isLoading,
                                  press: () {
                                    final form =
                                        controller.formKeyRetrait.currentState!;
                                    if (form.validate()) {
                                      controller.submitRetrait(
                                          widget.banqueNameModel);
                                      form.reset();
                                    }
                                  })) 
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
                              const TitleWidget(title: 'Banque Depôt'),
                              const SizedBox(
                                height: p20,
                              ),
                              ResponsiveChildWidget(
                                  child1: nomCompletWidget(),
                                  child2: pieceJustificativeWidget()),
                              ResponsiveChildWidget(
                                  child1: libelleWidget(),
                                  child2: montantWidget()),
                              const SizedBox(
                                height: p20,
                              ),
                              const SizedBox(
                                height: p20,
                              ),
                              Obx(() => BtnWidget(
                                  title: 'Soumettre',
                                  isLoading: controller.isLoading,
                                  press: () {
                                    final form =
                                        controller.formKeyDepot.currentState!;
                                    if (form.validate()) {
                                      controller
                                          .submitDepot(widget.banqueNameModel);
                                      form.reset();
                                    }
                                  }))  
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
            labelText: 'Titre',
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
                  monnaieStorage.monney,
                  style: headline6!,
                ))
          ],
        ));
  }
}
