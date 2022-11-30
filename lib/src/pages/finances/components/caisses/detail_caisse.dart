import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/models/finances/caisse_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/finances/controller/caisses/caisse_controller.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class DetailCaisse extends StatefulWidget {
  const DetailCaisse({super.key, required this.caisseModel});
  final CaisseModel caisseModel;

  @override
  State<DetailCaisse> createState() => _DetailCaisseState();
}

class _DetailCaisseState extends State<DetailCaisse> {
  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Finances";

  @override
  Widget build(BuildContext context) {
    final CaisseController controller = Get.find();

    return Scaffold(
        key: scaffoldKey,
        appBar: headerBar(
            context, scaffoldKey, title, widget.caisseModel.numeroOperation),
        drawer: const DrawerMenu(),
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
                                        TitleWidget(
                                            title:
                                                widget.caisseModel.caisseName),
                                        Column(
                                          children: [
                                            SelectableText(
                                                DateFormat("dd-MM-yyyy HH:mm")
                                                    .format(widget
                                                        .caisseModel.created),
                                                textAlign: TextAlign.start),
                                          ],
                                        )
                                      ],
                                    ),
                                    dataWidget(),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )))
            ],
          ),
        ));
  }

  Widget dataWidget() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.all(p10),
      child: Column(
        children: [
          ResponsiveChildWidget(
            child1: Text('Caisse :',
                textAlign: TextAlign.start,
                style: bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(widget.caisseModel.caisseName,
                textAlign: TextAlign.start, style: bodyMedium),
          ),
          ResponsiveChildWidget(
            child1: Text('Nom Complet :',
                textAlign: TextAlign.start,
                style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(widget.caisseModel.nomComplet,
                textAlign: TextAlign.start, style: bodyMedium),
          ),
          Divider(color: mainColor),
          ResponsiveChildWidget(
            child1: Text('Pièce justificative :',
                textAlign: TextAlign.start,
                style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(widget.caisseModel.pieceJustificative,
                textAlign: TextAlign.start, style: bodyMedium),
          ),
          Divider(color: mainColor),
          ResponsiveChildWidget(
            child1: Text('Libellé :',
                textAlign: TextAlign.start,
                style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(widget.caisseModel.libelle,
                textAlign: TextAlign.start, style: bodyMedium),
          ),
          Divider(color: mainColor),
          ResponsiveChildWidget(
            child1: Text('Montant :',
                textAlign: TextAlign.start,
                style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(
                "${NumberFormat.decimalPattern('fr').format(double.parse(widget.caisseModel.montant))} ${monnaieStorage.monney}",
                textAlign: TextAlign.start,
                style: bodyMedium),
          ),
          Divider(color: mainColor),
          ResponsiveChildWidget(
            child1: Text('Type d\'opération :',
                textAlign: TextAlign.start,
                style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(widget.caisseModel.typeOperation,
                textAlign: TextAlign.start,
                style: bodyMedium.copyWith(color: Colors.purple)),
          ),
          Divider(color: mainColor),
          ResponsiveChildWidget(
            child1: Text('Numéro d\'opération :',
                textAlign: TextAlign.start,
                style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(widget.caisseModel.numeroOperation,
                textAlign: TextAlign.start, style: bodyMedium),
          ),
          Divider(color: mainColor),
          ResponsiveChildWidget(
            child1: Text('Signature :',
                textAlign: TextAlign.start,
                style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(widget.caisseModel.signature,
                textAlign: TextAlign.start, style: bodyMedium),
          ),
        ],
      ),
    );
  }
}
