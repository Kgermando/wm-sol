import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/logistique/components/dashboard/materiel_pie.dart';
import 'package:wm_solution/src/pages/logistique/components/dashboard/etat_materiel_pie.dart';
import 'package:wm_solution/src/pages/logistique/controller/dashboard/dashboard_log_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/dash_number_widget.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart'; 

class DashboardLog extends StatefulWidget {
  const DashboardLog({super.key});

  @override
  State<DashboardLog> createState() => _DashboardLogState();
}

class _DashboardLogState extends State<DashboardLog> {
  final DashboardLogController controller = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Logistique";
  String subTitle = "Dashboard";

  final ScrollController controllerTable = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: scaffoldKey,
          appBar: headerBar(context, scaffoldKey, title, subTitle),
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: p20),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  alignment: WrapAlignment.spaceEvenly,
                                  children: [
                                    DashNumberWidget(
                                        gestureTapCallback: () {
                                          Get.toNamed(LogistiqueRoutes
                                              .logMateriel);  
                                        },
                                        number: '${controller.materielCount}',
                                        title: 'Total Materiel',
                                        icon: Icons.car_rental,
                                        color: Colors.blue.shade700),
                                    DashNumberWidget(
                                        gestureTapCallback: () {
                                          Get.toNamed(
                                              LogistiqueRoutes.logMateriel);
                                        },
                                        number: '${controller.materielCountRoulant}',
                                        title: 'Materiel roulant',
                                        icon: Icons.car_rental,
                                        color: Colors.blueGrey.shade700),
                                    DashNumberWidget(
                                        gestureTapCallback: () {
                                          Get.toNamed(LogistiqueRoutes
                                              .logMobilierMateriel);  
                                        },
                                        number: '${controller.mobilierCount}',
                                        title: 'Total mobilier',
                                        icon: Icons.desktop_mac,
                                        color: Colors.grey.shade700),
                                    DashNumberWidget(
                                        gestureTapCallback: () {
                                          Get.toNamed(
                                              LogistiqueRoutes.logImmobilierMateriel); 
                                        },
                                        number: '${controller.immobilierCount}',
                                        title: 'Total immobilier',
                                        icon: Icons.house_sharp,
                                        color: Colors.brown.shade700),
                                    DashNumberWidget(
                                        gestureTapCallback: () {
                                          Get.toNamed(
                                              LogistiqueRoutes.logEtatMateriel);
                                        },
                                        number:
                                            '${controller.etatMaterielActif}',
                                        title: 'Materiels actifs',
                                        icon: Icons.check,
                                        color: Colors.green.shade700),
                                    DashNumberWidget(
                                        gestureTapCallback: () {
                                          Get.toNamed(
                                              LogistiqueRoutes.logEtatMateriel); 
                                        },
                                        number:
                                            '${controller.etatMaterielInActif}',
                                        title: 'Materiels inactifs',
                                        icon:
                                            Icons.indeterminate_check_box_sharp,
                                        color: Colors.pink.shade700),
                                    DashNumberWidget(
                                        gestureTapCallback: () {
                                          Get.toNamed(
                                              LogistiqueRoutes.logEtatMateriel);
                                        },
                                        number:
                                            '${controller.etatMaterielDeclaser}',
                                        title: 'Materiels déclassés',
                                        icon: Icons.not_interested,
                                        color: Colors.red.shade700),
                                  ],
                                ), 
                                const SizedBox(
                                  height: 20.0,
                                ),
                                const ResponsiveChildWidget(
                                  child1: EtatMaterielPie(), 
                                  child2: MaterielPie()
                                ) 
                              ]),
                        )),
                  ))
            ],
          )),
    );
  }

  TableRow tableCarburant() {
    final headline6 = Theme.of(context).textTheme.headline6;
    return TableRow(children: [
      Card(
        elevation: 10.0,
        shadowColor: mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: Responsive.isMobile(context) ? 100 : 50,
          color: mainColor,
          padding: const EdgeInsets.all(16.0 * 0.75),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Responsive.isMobile(context)
                  ? Container()
                  : const Icon(Icons.ev_station_sharp),
              Responsive.isMobile(context)
                  ? Container()
                  : const SizedBox(width: p10),
              Expanded(
                child: AutoSizeText(
                  "CARBURANTS",
                  maxLines: 2,
                  style: headline6!.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
      Card(
        elevation: 10.0,
        shadowColor: mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: Responsive.isMobile(context) ? 100 : 50,
          padding: const EdgeInsets.all(16.0 * 0.75),
          decoration: BoxDecoration(border: Border.all(color: mainColor)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Responsive.isMobile(context)
                  ? Container()
                  : const Icon(Icons.ev_station_sharp),
              Responsive.isMobile(context)
                  ? Container()
                  : const SizedBox(width: p10),
              Expanded(
                child: AutoSizeText(
                  "Ravitailements".toUpperCase(),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: headline6.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
      Card(
        elevation: 10.0,
        shadowColor: mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: Responsive.isMobile(context) ? 100 : 50,
          padding: const EdgeInsets.all(16.0 * 0.75),
          decoration: BoxDecoration(border: Border.all(color: mainColor)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Responsive.isMobile(context)
                  ? Container()
                  : const Icon(Icons.ev_station_sharp),
              Responsive.isMobile(context)
                  ? Container()
                  : const SizedBox(width: p10),
              Expanded(
                child: AutoSizeText(
                  "Consommations".toUpperCase(),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: headline6.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
      Card(
        elevation: 10.0,
        shadowColor: mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: Responsive.isMobile(context) ? 100 : 50,
          padding: const EdgeInsets.all(16.0 * 0.75),
          decoration: BoxDecoration(border: Border.all(color: mainColor)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Responsive.isMobile(context)
                  ? Container()
                  : const Icon(Icons.ev_station_sharp),
              Responsive.isMobile(context)
                  ? Container()
                  : const SizedBox(width: p10),
              Expanded(
                child: AutoSizeText(
                  "Disponibles".toUpperCase(),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: headline6.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }

  TableRow tableCellEssence() {
    final headline6 = Theme.of(context).textTheme.headline6;
    return TableRow(children: [
      Card(
        elevation: 10.0,
        shadowColor: Colors.orange.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          color: Colors.orange.shade700,
          padding: const EdgeInsets.all(16.0 * 0.75),
          child: AutoSizeText(
            "Essence",
            maxLines: 2,
            style: headline6!.copyWith(color: Colors.white),
          ),
        ),
      ),
      Card(
        elevation: 10.0,
        shadowColor: Colors.orange.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          padding: const EdgeInsets.all(16.0 * 0.75),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.orange.shade700)),
          child: AutoSizeText(
            "${NumberFormat.decimalPattern('fr').format(controller.entrerEssence)} L",
            maxLines: 2,
            textAlign: TextAlign.center,
            style: headline6,
          ),
        ),
      ),
      Card(
        elevation: 10.0,
        shadowColor: Colors.orange.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          padding: const EdgeInsets.all(16.0 * 0.75),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.orange.shade700)),
          child: AutoSizeText(
            "${NumberFormat.decimalPattern('fr').format(controller.sortieEssence)} L",
            maxLines: 2,
            textAlign: TextAlign.center,
            style: headline6,
          ),
        ),
      ),
      Card(
        elevation: 10.0,
        shadowColor: Colors.orange.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          padding: const EdgeInsets.all(16.0 * 0.75),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.orange.shade700)),
          child: AutoSizeText(
            "${NumberFormat.decimalPattern('fr').format(controller.entrerEssence - controller.sortieEssence)} L",
            maxLines: 2,
            textAlign: TextAlign.center,
            style: headline6,
          ),
        ),
      ),
    ]);
  }

  TableRow tableCellMazoute() {
    final headline6 = Theme.of(context).textTheme.headline6;
    return TableRow(children: [
      Card(
        elevation: 10.0,
        shadowColor: Colors.teal.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          color: Colors.teal.shade700,
          padding: const EdgeInsets.all(16.0 * 0.75),
          child: AutoSizeText(
            "Mazoute",
            maxLines: 2,
            style: headline6!.copyWith(color: Colors.white),
          ),
        ),
      ),
      Card(
        elevation: 10.0,
        shadowColor: Colors.teal.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          padding: const EdgeInsets.all(16.0 * 0.75),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.teal.shade700)),
          child: AutoSizeText(
            "${NumberFormat.decimalPattern('fr').format(controller.entrerMazoute)} L",
            maxLines: 2,
            textAlign: TextAlign.center,
            style: headline6,
          ),
        ),
      ),
      Card(
        elevation: 10.0,
        shadowColor: Colors.teal.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          padding: const EdgeInsets.all(16.0 * 0.75),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.teal.shade700)),
          child: AutoSizeText(
            "${NumberFormat.decimalPattern('fr').format(controller.sortieMazoute)} L",
            maxLines: 2,
            textAlign: TextAlign.center,
            style: headline6,
          ),
        ),
      ),
      Card(
        elevation: 10.0,
        shadowColor: Colors.teal.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          padding: const EdgeInsets.all(16.0 * 0.75),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.teal.shade700)),
          child: AutoSizeText(
            "${NumberFormat.decimalPattern('fr').format(controller.entrerMazoute - controller.sortieMazoute)} L",
            maxLines: 2,
            textAlign: TextAlign.center,
            style: headline6,
          ),
        ),
      ),
    ]);
  }

  TableRow tableCellPetrole() {
    final headline6 = Theme.of(context).textTheme.headline6;
    return TableRow(children: [
      Card(
        elevation: 10.0,
        shadowColor: Colors.lime.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          color: Colors.lime.shade700,
          padding: const EdgeInsets.all(16.0 * 0.75),
          child: AutoSizeText(
            "Petrole",
            maxLines: 2,
            style: headline6!.copyWith(color: Colors.white),
          ),
        ),
      ),
      Card(
        elevation: 10.0,
        shadowColor: Colors.lime.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          padding: const EdgeInsets.all(16.0 * 0.75),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.lime.shade700)),
          child: AutoSizeText(
            "${NumberFormat.decimalPattern('fr').format(controller.entrerPetrole)} L",
            maxLines: 2,
            textAlign: TextAlign.center,
            style: headline6,
          ),
        ),
      ),
      Card(
        elevation: 10.0,
        shadowColor: Colors.lime.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          padding: const EdgeInsets.all(16.0 * 0.75),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.lime.shade700)),
          child: AutoSizeText(
            "${NumberFormat.decimalPattern('fr').format(controller.sortiePetrole)} L",
            maxLines: 2,
            textAlign: TextAlign.center,
            style: headline6,
          ),
        ),
      ),
      Card(
        elevation: 10.0,
        shadowColor: Colors.lime.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          padding: const EdgeInsets.all(16.0 * 0.75),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.lime.shade700)),
          child: AutoSizeText(
            "${NumberFormat.decimalPattern('fr').format(controller.entrerPetrole - controller.sortiePetrole)} L",
            maxLines: 2,
            textAlign: TextAlign.center,
            style: headline6,
          ),
        ),
      ),
    ]);
  }

  TableRow tableCellHuileMoteur() {
    final headline6 = Theme.of(context).textTheme.headline6;
    return TableRow(children: [
      Card(
        elevation: 10.0,
        shadowColor: Colors.indigo.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          color: Colors.indigo.shade700,
          padding: const EdgeInsets.all(16.0 * 0.75),
          child: AutoSizeText(
            "Huile Moteur",
            maxLines: 2,
            style: headline6!.copyWith(color: Colors.white),
          ),
        ),
      ),
      Card(
        elevation: 10.0,
        shadowColor: Colors.indigo.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          padding: const EdgeInsets.all(16.0 * 0.75),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.indigo.shade700)),
          child: AutoSizeText(
            "${NumberFormat.decimalPattern('fr').format(controller.entrerHuilleMoteur)} L",
            maxLines: 2,
            textAlign: TextAlign.center,
            style: headline6,
          ),
        ),
      ),
      Card(
        elevation: 10.0,
        shadowColor: Colors.indigo.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          padding: const EdgeInsets.all(16.0 * 0.75),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.indigo.shade700)),
          child: AutoSizeText(
            "${NumberFormat.decimalPattern('fr').format(controller.sortieHuilleMoteur)} L",
            maxLines: 2,
            textAlign: TextAlign.center,
            style: headline6,
          ),
        ),
      ),
      Card(
        elevation: 10.0,
        shadowColor: Colors.indigo.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 300,
          height: 50,
          padding: const EdgeInsets.all(16.0 * 0.75),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.indigo.shade700)),
          child: AutoSizeText(
            "${NumberFormat.decimalPattern('fr').format(controller.entrerHuilleMoteur - controller.sortieHuilleMoteur)} L",
            maxLines: 2,
            textAlign: TextAlign.center,
            style: headline6,
          ),
        ),
      ),
    ]);
  }
}
