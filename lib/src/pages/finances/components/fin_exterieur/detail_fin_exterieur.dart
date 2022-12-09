import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/models/finances/fin_exterieur_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/finances/controller/fin_exterieur/fin_exterieur_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class DetailFinExterieur extends StatefulWidget {
  const DetailFinExterieur({super.key, required this.financeExterieurModel});
  final FinanceExterieurModel financeExterieurModel;

  @override
  State<DetailFinExterieur> createState() => _DetailFinExterieurState();
}

class _DetailFinExterieurState extends State<DetailFinExterieur> {
   final FinExterieurController controller = Get.put(FinExterieurController());
  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Finances";

    Future<FinanceExterieurModel> refresh() async {
    final FinanceExterieurModel dataItem =
        await controller.detailView(widget.financeExterieurModel.id!);
    return dataItem;
  }


  @override
  Widget build(BuildContext context) { 
    return Scaffold(
        key: scaffoldKey,
        appBar: headerBar(context, scaffoldKey, title,
            widget.financeExterieurModel.numeroOperation),
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
                                                  title: widget
                                                      .financeExterieurModel
                                                      .financeExterieurName),
                                              Column(
                                                children: [
                                                  IconButton(
                                                      tooltip: 'Actualiser',
                                                      onPressed: () async {
                                                        refresh().then((value) =>
                                                            Navigator.pushNamed(
                                                                context,
                                                                FinanceRoutes
                                                                    .transactionsFinancementExterneDetail,
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
                                                              .financeExterieurModel
                                                              .created),
                                                      textAlign:
                                                          TextAlign.start),
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
                )));
  }

  Widget dataWidget() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.all(p10),
      child: Column(
        children: [
          ResponsiveChildWidget(
            child1: Text('Compte :',
                textAlign: TextAlign.start,
                style: bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(
                widget.financeExterieurModel.financeExterieurName,
                textAlign: TextAlign.start,
                style: bodyMedium),
          ),
          Divider(color: mainColor),
          ResponsiveChildWidget(
            child1: Text('Titre :',
                textAlign: TextAlign.start,
                style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(widget.financeExterieurModel.nomComplet,
                textAlign: TextAlign.start, style: bodyMedium),
          ),
          Divider(color: mainColor),
          ResponsiveChildWidget(
            child1: Text('Pièce justificative :',
                textAlign: TextAlign.start,
                style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(
                widget.financeExterieurModel.pieceJustificative,
                textAlign: TextAlign.start,
                style: bodyMedium),
          ),
          Divider(color: mainColor),
          ResponsiveChildWidget(
            child1: Text('Libellé :',
                textAlign: TextAlign.start,
                style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(widget.financeExterieurModel.libelle,
                textAlign: TextAlign.start, style: bodyMedium),
          ),
          if (widget.financeExterieurModel.montantRetrait == "Depot")
            Divider(color: mainColor),
          if (widget.financeExterieurModel.montantRetrait == "Depot")
          ResponsiveChildWidget(
            child1: Text('Montant :',
                textAlign: TextAlign.start,
                style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(
                "${NumberFormat.decimalPattern('fr').format(double.parse(widget.financeExterieurModel.montantDepot))} ${monnaieStorage.monney}",
                textAlign: TextAlign.start,
                style: bodyMedium),
          ),
          if (widget.financeExterieurModel.montantRetrait == "Retrait")
          Divider(color: mainColor),
          if(widget.financeExterieurModel.montantRetrait == "Retrait")
          ResponsiveChildWidget(
            child1: Text('Montant :',
                textAlign: TextAlign.start,
                style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(
                "${NumberFormat.decimalPattern('fr').format(double.parse(widget.financeExterieurModel.montantRetrait))} ${monnaieStorage.monney}",
                textAlign: TextAlign.start,
                style: bodyMedium),
          ),
          Divider(color: mainColor),
          ResponsiveChildWidget(
            child1: Text('Type d\'opération :',
                textAlign: TextAlign.start,
                style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(widget.financeExterieurModel.typeOperation,
                textAlign: TextAlign.start,
                style: bodyMedium.copyWith(color: Colors.purple)),
          ),
          Divider(color: mainColor),
          ResponsiveChildWidget(
            child1: Text('Numéro d\'opération :',
                textAlign: TextAlign.start,
                style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(widget.financeExterieurModel.numeroOperation,
                textAlign: TextAlign.start, style: bodyMedium),
          ),
          Divider(color: mainColor),
          ResponsiveChildWidget(
            child1: Text('Signature :',
                textAlign: TextAlign.start,
                style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(widget.financeExterieurModel.signature,
                textAlign: TextAlign.start, style: bodyMedium),
          ),
        ],
      ),
    );
  }
}
