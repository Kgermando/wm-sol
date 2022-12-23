import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/controllers/departement_notify_controller.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/administration/components/logistique/table_devis_dg.dart'; 
import 'package:wm_solution/src/pages/administration/components/logistique/table_immobilier_dg.dart';
import 'package:wm_solution/src/pages/administration/components/logistique/table_materiel_dg.dart';
import 'package:wm_solution/src/pages/devis/controller/devis_controller.dart'; 
import 'package:wm_solution/src/pages/logistique/controller/immobiliers/immobilier_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/materiels/materiel_controller.dart'; 

class AdminLogistique extends StatefulWidget {
  const AdminLogistique({super.key});

  @override
  State<AdminLogistique> createState() => _AdminLogistiqueState();
}

class _AdminLogistiqueState extends State<AdminLogistique> {
  final DepartementNotifyCOntroller controller = Get.find(); 
  final MaterielController materielController = Get.find();
  final ImmobilierController immobilierController = Get.find();
  final DevisController devisController = Get.find();
  
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Logistique";
   String subTitle = "Direteur de génerale";

  bool isOpen1 = false;
  bool isOpen2 = false;
  bool isOpen3 = false;
  bool isOpen4 = false;
  bool isOpen5 = false;
  bool isOpen6 = false;

  @override
  Widget build(BuildContext context) { 
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
                                  title: Text('Dossier Materiels',
                                      style: headline6!
                                          .copyWith(color: Colors.white)),
                                  subtitle:Obx(() => Text(
                                      "Vous avez ${controller.itemCountMaterielDG} dossiers necessitent votre approbation",
                                      style: bodyMedium!
                                          .copyWith(color: Colors.white))) ,
                                  initiallyExpanded: false,
                                  onExpansionChanged: (val) {
                                    setState(() {
                                      isOpen1 = !val;
                                    });
                                  },
                                  trailing: const Icon(Icons.arrow_drop_down,
                                      color: Colors.white),
                                  children: [TableMaterielDG(controller: materielController)],
                                ),
                              ),
                              Card(
                                color: Colors.lime.shade700,
                                child: ExpansionTile(
                                  leading: const Icon(Icons.folder,
                                      color: Colors.white),
                                  title: Text('Dossier Immobiliers',
                                      style: (Responsive.isDesktop(context))
                                          ? headline6.copyWith(
                                              color: Colors.white)
                                          : bodyLarge!
                                              .copyWith(color: Colors.white)),
                                  subtitle:Obx(() => Text(
                                      "Vous avez ${controller.itemCountImmobilierDG} dossiers necessitent votre approbation",
                                      style: bodyMedium!.copyWith(
                                          color: Colors.white70))) ,
                                  initiallyExpanded: false,
                                  onExpansionChanged: (val) {
                                    setState(() {
                                      isOpen2 = !val;
                                    });
                                  },
                                  trailing: const Icon(Icons.arrow_drop_down,
                                      color: Colors.white),
                                  children: [TableImmobilierDG(immobilierController: immobilierController)],
                                ),
                              ),
                              Card(
                                color: Colors.orange.shade700,
                                child: ExpansionTile(
                                  leading: const Icon(Icons.folder,
                                      color: Colors.white),
                                  title: Text(
                                      'Dossier sur les Devis',
                                      style: (Responsive.isDesktop(context))
                                          ? headline6.copyWith(
                                              color: Colors.white)
                                          : bodyLarge!
                                              .copyWith(color: Colors.white)),
                                  subtitle: Obx(() => Text(
                                      "Vous avez ${controller.itemLogCountDevisDG} dossiers necessitent votre approbation",
                                      style: bodyMedium!.copyWith(
                                          color: Colors.white70))) ,
                                  initiallyExpanded: false,
                                  onExpansionChanged: (val) {
                                    setState(() {
                                      isOpen3 = !val;
                                    });
                                  },
                                  trailing: const Icon(Icons.arrow_drop_down,
                                      color: Colors.white),
                                  children: [
                                    TableDevisDG(devisController: devisController)
                                  ],
                                ),
                              ),
                            ])),
                  ))
            ],
          )),
    );
  }
}