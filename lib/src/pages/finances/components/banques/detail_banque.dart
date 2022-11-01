import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/finances/banque_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/finances/controller/banques/banque_controller.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class DetailBanque extends StatefulWidget {
  const DetailBanque({super.key, required this.banqueModel});
  final BanqueModel banqueModel;

  @override
  State<DetailBanque> createState() => _DetailBanqueState();
}

class _DetailBanqueState extends State<DetailBanque> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Finances"; 

  @override
  Widget build(BuildContext context) {
    final BanqueController controller = Get.put(BanqueController());

    return controller.obx(
        onLoading: loading(),
        onEmpty: const Text('Aucune donnée'),
        onError: (error) => Text(
            "Une erreur s'est produite $error veiller actualiser votre logiciel. Merçi."),
        (state) => Scaffold(
              key: scaffoldKey,
              appBar: headerBar(
                  context, scaffoldKey, title, widget.banqueModel.numeroOperation),
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
                                                title: widget
                                                    .banqueModel.banqueName),
                                            Column(
                                              children: [
                                                SelectableText(
                                                    DateFormat(
                                                            "dd-MM-yyyy HH:mm")
                                                        .format(widget.banqueModel.created),
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
            child1: Text('Banque :',
                textAlign: TextAlign.start,
                style: bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(widget.banqueModel.banqueName,
                textAlign: TextAlign.start, style: bodyMedium),
          ), 
          Divider(color: mainColor),
          ResponsiveChildWidget(
            child1: Text('Nom Complet :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)), 
            child2: SelectableText(widget.banqueModel.nomComplet,
                    textAlign: TextAlign.start, style: bodyMedium),
          ),
          Divider(color: mainColor), 
          ResponsiveChildWidget(
            child1: Text('Pièce justificative :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)), 
            child2: SelectableText(widget.banqueModel.pieceJustificative,
                    textAlign: TextAlign.start, style: bodyMedium),
          ),  
          Divider(color: mainColor),
          ResponsiveChildWidget(
            child1: Text('Libellé :',
                textAlign: TextAlign.start,
                style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(widget.banqueModel.libelle,
                textAlign: TextAlign.start, style: bodyMedium),
          ), 
          Divider(color: mainColor),
          ResponsiveChildWidget(
            child1: Text('Montant :',
                textAlign: TextAlign.start,
                style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(
                "${NumberFormat.decimalPattern('fr').format(double.parse(widget.banqueModel.montant))} \$",
                textAlign: TextAlign.start, style: bodyMedium),
          ),  
          Divider(color: mainColor),
          ResponsiveChildWidget(
            child1: Text('Type d\'opération :',
                textAlign: TextAlign.start,
                style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(
                widget.banqueModel.typeOperation,
                textAlign: TextAlign.start,
                style: bodyMedium.copyWith(color: Colors.purple)),
          ),  
          Divider(color: mainColor),
          ResponsiveChildWidget(
            child1: Text('Numéro d\'opération :',
                textAlign: TextAlign.start,
                style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(widget.banqueModel.numeroOperation,
                textAlign: TextAlign.start, style: bodyMedium),
          ),
          Divider(color: mainColor),
          ResponsiveChildWidget(
            child1: Text('Signature :',
                textAlign: TextAlign.start,
                style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(widget.banqueModel.signature,
                textAlign: TextAlign.start, style: bodyMedium),
          ),  
        ],
      ),
    );
  }
}
