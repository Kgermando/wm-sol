import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/controllers/departement_notify_controller.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/marketing/controller/campaigns/compaign_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/devis/devis_controller.dart';
import 'package:wm_solution/src/pages/exploitations/controller/projets/projet_controller.dart';
import 'package:wm_solution/src/pages/finances/components/observation/table_campaigns_obs.dart';
import 'package:wm_solution/src/pages/finances/components/observation/table_devis_obs.dart';
import 'package:wm_solution/src/pages/finances/components/observation/table_projet_obs.dart';
import 'package:wm_solution/src/pages/finances/components/observation/table_salaire_obs.dart';
import 'package:wm_solution/src/pages/finances/components/observation/table_transport_rest_obs.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/salaires/salaire_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/transport_rest/transport_rest_controller.dart'; 

class ObservationPage extends StatefulWidget {
  const ObservationPage({super.key});

  @override
  State<ObservationPage> createState() => _ObservationPageState();
}

class _ObservationPageState extends State<ObservationPage> {
  final DepartementNotifyCOntroller controller = Get.find();
  final SalaireController salaireController = Get.find();
  final TransportRestController transportRestController = Get.find();
  final DevisController devisController = Get.find();
  final CampaignController campaignController = Get.find();
  final ProjetController projetController = Get.find();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Finance";
  String subTitle = "observations";
  bool isOpen1 = false;
  bool isOpen2 = false;
  bool isOpen3 = false;
  bool isOpen4 = false;
  bool isOpen5 = false;

  @override
  Widget build(BuildContext context) {
    final headline6 = Theme.of(context).textTheme.headline6;
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: p20),
                          child: Obx(() => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Card(
                                  color: Colors.red.shade700,
                                  child: ExpansionTile(
                                    leading: const Icon(Icons.folder,
                                        color: Colors.white),
                                    title: Text('Dossier Salaires',
                                        style: headline6!
                                            .copyWith(color: Colors.white)),
                                    subtitle: Text(
                                        "Vous avez ${controller.itemCountSalaireObs} dossiers necessitent votre approbation",
                                        style: bodyMedium!
                                            .copyWith(color: Colors.white70)),
                                    initiallyExpanded: false,
                                    onExpansionChanged: (val) {
                                      setState(() {
                                        isOpen1 = !val;
                                      });
                                    },
                                    trailing: const Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.white,
                                    ),
                                    children: [
                                      TableSalaireObs(salaireController: salaireController)
                                    ],
                                  ),
                                ),
                                Card(
                                  color: Colors.blue.shade700,
                                  child: ExpansionTile(
                                    leading: const Icon(Icons.folder,
                                        color: Colors.white),
                                    title: Text(
                                        'Dossier Transports & Restaurations',
                                        style: headline6.copyWith(
                                            color: Colors.white)),
                                    subtitle: Text(
                                        "Vous avez ${controller.itemCountTransRestObs} dossiers necessitent votre approbation",
                                        style: bodyMedium.copyWith(
                                            color: Colors.white70)),
                                    initiallyExpanded: false,
                                    onExpansionChanged: (val) {
                                      setState(() {
                                        isOpen2 = !val;
                                      });
                                    },
                                    trailing: const Icon(Icons.arrow_drop_down,
                                        color: Colors.white),
                                    children: [
                                      TableTransportRestObs(transportRestController: transportRestController)
                                    ],
                                  ),
                                ),
                                Card(
                                  color: Colors.green.shade700,
                                  child: ExpansionTile(
                                    leading: const Icon(Icons.folder,
                                        color: Colors.white),
                                    title: Text('Dossier Campagne',
                                        style: headline6.copyWith(
                                            color: Colors.white)),
                                    subtitle: Text(
                                        "Vous avez ${controller.campaignCountObs} dossiers necessitent votre approbation",
                                        style: bodyMedium.copyWith(
                                            color: Colors.white70)),
                                    initiallyExpanded: false,
                                    onExpansionChanged: (val) {
                                      setState(() {
                                        isOpen3 = !val;
                                      });
                                    },
                                    trailing: const Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.white,
                                    ),
                                    children: [
                                      TableCampaignObs(controller: campaignController)
                                    ],
                                  ),
                                ),
                                Card(
                                  color: Colors.grey.shade700,
                                  child: ExpansionTile(
                                    leading: const Icon(Icons.folder,
                                        color: Colors.white),
                                    title: Text('Dossier Projets',
                                        style: headline6.copyWith(
                                            color: Colors.white)),
                                    subtitle: Text(
                                        "Vous avez ${controller.itemCountProjetObs} dossiers necessitent votre approbation",
                                        style: bodyMedium.copyWith(
                                            color: Colors.white70)),
                                    initiallyExpanded: false,
                                    onExpansionChanged: (val) {
                                      setState(() {
                                        isOpen4 = !val;
                                      });
                                    },
                                    trailing: const Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.white,
                                    ),
                                    children: [
                                      TableProjetObs(controller: projetController)
                                    ],
                                  ),
                                ), 
                              Card(
                                  color: Colors.teal.shade700,
                                  child: ExpansionTile(
                                    leading: const Icon(Icons.folder,
                                        color: Colors.white),
                                    title: Text('Dossier dévis',
                                        style: headline6.copyWith(
                                            color: Colors.white)),
                                    subtitle: Text(
                                        "Vous avez ${controller.itemLogCountDevisObs} dossiers necessitent votre approbation",
                                        style: bodyMedium.copyWith(
                                            color: Colors.white70)),
                                    initiallyExpanded: false,
                                    onExpansionChanged: (val) {
                                      setState(() {
                                        isOpen5 = !val;
                                      });
                                    },
                                    trailing: const Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.white,
                                    ),
                                    children: [
                                      TableDevisObs(devisController: devisController)
                                    ],
                                  ),
                                ),
                            ])) ,
                        )),
                  ))
            ],
          )),
    ); 
  }
}