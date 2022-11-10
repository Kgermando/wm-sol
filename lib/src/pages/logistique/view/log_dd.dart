import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/devis/controller/devis_controller.dart';
import 'package:wm_solution/src/pages/devis/controller/devis_notify.dart'; 
import 'package:wm_solution/src/pages/logistique/components/log_dd/table_devis_dd.dart'; 
import 'package:wm_solution/src/pages/logistique/components/log_dd/table_entretien_dd.dart';
import 'package:wm_solution/src/pages/logistique/components/log_dd/table_etat_materiel_dd.dart';
import 'package:wm_solution/src/pages/logistique/components/log_dd/table_immobilier_dd.dart'; 
import 'package:wm_solution/src/pages/logistique/components/log_dd/table_materiel_dd.dart';
import 'package:wm_solution/src/pages/logistique/components/log_dd/table_mobilier_dd.dart';
import 'package:wm_solution/src/pages/logistique/components/log_dd/table_trajet_dd.dart';
import 'package:wm_solution/src/pages/logistique/controller/materiels/materiel_controller.dart';  
import 'package:wm_solution/src/pages/logistique/controller/trajets/trajet_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/entretiens/entretiens_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/etat_materiel/etat_materiel_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/immobiliers/immobilier_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/mobiliers/mobilier_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/notify/notify_log.dart'; 

class LogDD extends StatefulWidget {
  const LogDD({super.key});

  @override
  State<LogDD> createState() => _LogDDState();
}

class _LogDDState extends State<LogDD> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Logistique";
  String subTitle = "Direteur de département";

  bool isOpenLog1 = false;
  bool isOpenLog2 = false;
  bool isOpenLog3 = false;
  bool isOpenLog4 = false;
  bool isOpenLog5 = false;
  bool isOpenLog6 = false;
  bool isOpenLog7 = false;
  bool isOpenLog8 = false;

  @override
  Widget build(BuildContext context) {
    final NotifyLogController controller = Get.put(NotifyLogController());
    final DevisNotifyController devisNotifyController = Get.put(DevisNotifyController());
    final MaterielController materielController = Get.put(MaterielController()); 
    final TrajetController trajetController = Get.put(TrajetController());
    final ImmobilierController immobilierController = Get.put(ImmobilierController());
    final MobilierController mobilierController = Get.put(MobilierController());
    final EntretienController entretienController = Get.put(EntretienController());
    final EtatMaterielController etatMaterielController = Get.put(EtatMaterielController());
    final DevisController devisController = Get.put(DevisController());
    

    final headline6 = Theme.of(context).textTheme.headline6;
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;

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
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              color: Colors.blue.shade700,
                              child: ExpansionTile(
                                leading: const Icon(Icons.folder,
                                    color: Colors.white),
                                title: Text('Dossier materiels',
                                    style: (Responsive.isDesktop(context))
                                        ? headline6!
                                            .copyWith(color: Colors.white)
                                        : bodyLarge!
                                            .copyWith(color: Colors.white)),
                                subtitle: Text(
                                    "Vous avez ${controller.itemCountMaterielDD} dossiers necessitent votre approbation",
                                    style: bodyMedium!
                                        .copyWith(color: Colors.white70)),
                                initiallyExpanded: false,
                                onExpansionChanged: (val) {
                                  setState(() {
                                    isOpenLog1 = !val;
                                  });
                                },
                                trailing: const Icon(Icons.arrow_drop_down,
                                    color: Colors.white),
                                children: [TableMaterielDD(controller: materielController)],
                              ),
                            ), 
                            Card(
                              color: Colors.teal.shade700,
                              child: ExpansionTile(
                                leading: const Icon(Icons.folder,
                                    color: Colors.white),
                                title: Text('Dossier Trajets',
                                    style: (Responsive.isDesktop(context))
                                        ? headline6!
                                            .copyWith(color: Colors.white)
                                        : bodyLarge!
                                            .copyWith(color: Colors.white)),
                                subtitle: Text(
                                    "Vous avez ${controller.itemCountTrajetsDD} dossiers necessitent votre approbation",
                                    style: bodyMedium.copyWith(
                                        color: Colors.white70)),
                                initiallyExpanded: false,
                                onExpansionChanged: (val) {
                                  setState(() {
                                    isOpenLog3 = !val;
                                  });
                                },
                                trailing: const Icon(Icons.arrow_drop_down,
                                    color: Colors.white),
                                children: [TableTrajetDD(trajetController: trajetController)],
                              ),
                            ),
                            Card(
                              color: Colors.lime.shade700,
                              child: ExpansionTile(
                                leading: const Icon(Icons.folder,
                                    color: Colors.white),
                                title: Text('Dossier Immobiliers',
                                    style: (Responsive.isDesktop(context))
                                        ? headline6!
                                            .copyWith(color: Colors.white)
                                        : bodyLarge!
                                            .copyWith(color: Colors.white)),
                                subtitle: Text(
                                    "Vous avez ${controller.itemCountImmobilierDD} dossiers necessitent votre approbation",
                                    style: bodyMedium.copyWith(
                                        color: Colors.white70)),
                                initiallyExpanded: false,
                                onExpansionChanged: (val) {
                                  setState(() {
                                    isOpenLog4 = !val;
                                  });
                                },
                                trailing: const Icon(Icons.arrow_drop_down,
                                    color: Colors.white),
                                children: [TableImmobilierDD(immobilierController: immobilierController)],
                              ),
                            ),
                            Card(
                              color: Colors.blueGrey,
                              child: ExpansionTile(
                                leading: const Icon(Icons.folder,
                                    color: Colors.white),
                                title: Text('Dossier Mobiliers',
                                    style: (Responsive.isDesktop(context))
                                        ? headline6!
                                            .copyWith(color: Colors.white)
                                        : bodyLarge!
                                            .copyWith(color: Colors.white)),
                                subtitle: Text(
                                    "Vous avez ${controller.itemCountMobilierDD} dossiers necessitent votre approbation",
                                    style: bodyMedium.copyWith(
                                        color: Colors.white70)),
                                initiallyExpanded: false,
                                onExpansionChanged: (val) {
                                  setState(() {
                                    isOpenLog5 = !val;
                                  });
                                },
                                trailing: const Icon(Icons.arrow_drop_down,
                                    color: Colors.white),
                                children: [TableMobilierDD(mobilierController: mobilierController)],
                              ),
                            ),
                            Card(
                              color: Colors.brown.shade700,
                              child: ExpansionTile(
                                leading: const Icon(Icons.folder,
                                    color: Colors.white),
                                title: Text('Dossier maintenances',
                                    style: (Responsive.isDesktop(context))
                                        ? headline6!
                                            .copyWith(color: Colors.white)
                                        : bodyLarge!
                                            .copyWith(color: Colors.white)),
                                subtitle: Text(
                                    "Vous avez ${controller.itemCounEntretienDD} dossiers necessitent votre approbation",
                                    style: bodyMedium.copyWith(
                                        color: Colors.white70)),
                                initiallyExpanded: false,
                                onExpansionChanged: (val) {
                                  setState(() {
                                    isOpenLog6 = !val;
                                  });
                                },
                                trailing: const Icon(Icons.arrow_drop_down,
                                    color: Colors.white),
                                children: [TableEntretienDD(entretienController: entretienController)],
                              ),
                            ),
                            Card(
                              color: Colors.grey.shade700,
                              child: ExpansionTile(
                                leading: const Icon(Icons.folder,
                                    color: Colors.white),
                                title: Text('Dossier Etat de materiels',
                                    style: (Responsive.isDesktop(context))
                                        ? headline6!
                                            .copyWith(color: Colors.white)
                                        : bodyLarge!
                                            .copyWith(color: Colors.white)),
                                subtitle: Text(
                                    "Vous avez ${controller.itemCounEtatmaterielDD} dossiers necessitent votre approbation",
                                    style: bodyMedium.copyWith(
                                        color: Colors.white70)),
                                initiallyExpanded: false,
                                onExpansionChanged: (val) {
                                  setState(() {
                                    isOpenLog7 = !val;
                                  });
                                },
                                trailing: const Icon(Icons.arrow_drop_down,
                                    color: Colors.white),
                                children: [TableEtatMaterielDD(etatMaterielController: etatMaterielController)],
                              ),
                            ),
                            Card(
                              color: Colors.purple.shade700,
                              child: ExpansionTile(
                                leading: const Icon(Icons.folder,
                                    color: Colors.white),
                                title: Text('Dossier Devis',
                                    style: (Responsive.isDesktop(context))
                                        ? headline6!
                                            .copyWith(color: Colors.white)
                                        : bodyLarge!
                                            .copyWith(color: Colors.white)),
                                subtitle: Text(
                                    "Vous avez ${devisNotifyController.itemCountDevisDD} dossiers necessitent votre approbation",
                                    style: bodyMedium.copyWith(
                                        color: Colors.white70)),
                                initiallyExpanded: false,
                                onExpansionChanged: (val) {
                                  setState(() {
                                    isOpenLog8 = !val;
                                  });
                                },
                                trailing: const Icon(Icons.arrow_drop_down,
                                    color: Colors.white),
                                children: [TableDevisDD(devisController: devisController)],
                              ),
                            ),
                          ]
                        )
                      ),
                  ))
            ],
          )),
    );
  }
}