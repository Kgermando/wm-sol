import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/devis/controller/devis_controller.dart'; 
import 'package:wm_solution/src/pages/devis/controller/devis_notify.dart';
import 'package:wm_solution/src/pages/finances/components/dd_finance/table_creance_dd.dart';
import 'package:wm_solution/src/pages/finances/components/dd_finance/table_dette_dd.dart';
import 'package:wm_solution/src/pages/finances/components/dd_finance/table_devis_finance.dart';
import 'package:wm_solution/src/pages/finances/components/dd_finance/table_salaire_finance.dart';
import 'package:wm_solution/src/pages/finances/components/dd_finance/table_transport_rest_finance.dart';
import 'package:wm_solution/src/pages/finances/controller/creances/creance_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/dettes/dette_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/notify/finance_notify_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/notify/rh_notify_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/salaires/salaire_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/transport_rest/transport_rest_controller.dart';


class DDFinance extends StatefulWidget {
  const DDFinance({super.key});

  @override
  State<DDFinance> createState() => _DDFinanceState();
}

class _DDFinanceState extends State<DDFinance> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Finance";
  String subTitle = "Direteur de département";

  bool isOpen1 = false;
  bool isOpen2 = false;
  bool isOpen3 = false;
  bool isOpen4 = false;
  bool isOpen5 = false;
  bool isOpen6 = false;
  bool isOpen7 = false;

  @override
  Widget build(BuildContext context) {
    final FinanceNotifyController financeNotifyController = Get.put(FinanceNotifyController());
    final RHNotifyController rhNotifyController = Get.put(RHNotifyController());
    final SalaireController salaireController = Get.put(SalaireController());
    final TransportRestController transportRestController =
        Get.put(TransportRestController()); 
    final DevisNotifyController devisNotifyController = Get.put(DevisNotifyController());
    final DevisController devisController = Get.put(DevisController()); 
    final CreanceController creanceController =
        Get.put(CreanceController());
    final DetteController detteController =
        Get.put(DetteController());  

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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: p20),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Card(
                                  color: Colors.purple.shade700,
                                  child: ExpansionTile(
                                    leading: const Icon(Icons.folder,
                                        color: Colors.white),
                                    title: Text('Dossier Salaires',
                                        style: (Responsive.isDesktop(context))
                                            ? headline6!
                                                .copyWith(color: Colors.white)
                                            : bodyLarge!
                                                .copyWith(color: Colors.white)),
                                    subtitle: Text(
                                        "Vous avez ${rhNotifyController.itemCountSalaireFin} dossiers necessitent votre approbation",
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
                                      TableSalaireFinance(salaireController: salaireController)
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
                                        style: (Responsive.isDesktop(context))
                                            ? headline6!
                                                .copyWith(color: Colors.white)
                                            : bodyLarge!
                                                .copyWith(color: Colors.white)),
                                    subtitle: Text(
                                        "Vous avez ${rhNotifyController.itemCountTransRestFin} dossiers necessitent votre approbation",
                                        style: bodyMedium.copyWith(
                                            color: Colors.white70)),
                                    initiallyExpanded: false,
                                    onExpansionChanged: (val) {
                                      setState(() {
                                        isOpen5 = !val;
                                      });
                                    },
                                    trailing: const Icon(Icons.arrow_drop_down,
                                        color: Colors.white),
                                    children: [
                                      TableTransportRestFinance(transportRestController: transportRestController)
                                    ],
                                  ),
                                ),
                                // Card(
                                //   color: Colors.green.shade700,
                                //   child: ExpansionTile(
                                //     leading: const Icon(Icons.folder,
                                //         color: Colors.white),
                                //     title: Text('Dossier Campaigns',
                                //         style: (Responsive.isDesktop(context))
                                //             ? headline6!
                                //                 .copyWith(color: Colors.white)
                                //             : bodyLarge!
                                //                 .copyWith(color: Colors.white)),
                                //     subtitle: Text(
                                //         "Vous avez $campaignCount dossiers necessitent votre approbation",
                                //         style: bodyMedium.copyWith(
                                //             color: Colors.white70)),
                                //     initiallyExpanded: false,
                                //     onExpansionChanged: (val) {
                                //       setState(() {
                                //         isOpen2 = !val;
                                //       });
                                //     },
                                //     trailing: const Icon(
                                //       Icons.arrow_drop_down,
                                //       color: Colors.white,
                                //     ),
                                //     children: const [TableCampaignFin()],
                                //   ),
                                // ),
                                // Card(
                                //   color: Colors.grey.shade700,
                                //   child: ExpansionTile(
                                //     leading: const Icon(Icons.folder,
                                //         color: Colors.white),
                                //     title: Text('Dossier Projets',
                                //         style: (Responsive.isDesktop(context))
                                //             ? headline6!
                                //                 .copyWith(color: Colors.white)
                                //             : bodyLarge!
                                //                 .copyWith(color: Colors.white)),
                                //     subtitle: Text(
                                //         "Vous avez $projetCount dossiers necessitent votre approbation",
                                //         style: bodyMedium.copyWith(
                                //             color: Colors.white70)),
                                //     initiallyExpanded: false,
                                //     onExpansionChanged: (val) {
                                //       setState(() {
                                //         isOpen4 = !val;
                                //       });
                                //     },
                                //     trailing: const Icon(
                                //       Icons.arrow_drop_down,
                                //       color: Colors.white,
                                //     ),
                                //     children: const [TableProjetFin()],
                                //   ),
                                // ),
                                Card(
                                  color: Colors.grey.shade700,
                                  child: ExpansionTile(
                                    leading: const Icon(Icons.folder,
                                        color: Colors.white),
                                    title: Text('Dossier Etat de besoins',
                                        style: (Responsive.isDesktop(context))
                                            ? headline6!
                                                .copyWith(color: Colors.white)
                                            : bodyLarge!
                                                .copyWith(color: Colors.white)),
                                    subtitle: Text(
                                        "Vous avez ${devisNotifyController.itemCountDevisFin} dossiers necessitent votre approbation",
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
                                      TableDevisFinance(devisController: devisController)
                                    ],
                                  ),
                                ),
                                Card(
                                  color: Colors.red.shade700,
                                  child: ExpansionTile(
                                    leading: const Icon(Icons.folder,
                                        color: Colors.white),
                                    title: Text('Dossier Dette',
                                        style: (Responsive.isDesktop(context))
                                            ? headline6!
                                                .copyWith(color: Colors.white)
                                            : bodyLarge!
                                                .copyWith(color: Colors.white)),
                                    subtitle: Text(
                                        "Vous avez ${financeNotifyController.detteCount} dossiers necessitent votre approbation",
                                        style: bodyMedium.copyWith(
                                            color: Colors.white70)),
                                    initiallyExpanded: false,
                                    onExpansionChanged: (val) {
                                      setState(() {
                                        isOpen6 = !val;
                                      });
                                    },
                                    trailing: const Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.white,
                                    ),
                                    children: [
                                      TableDetteDD(detteController: detteController)
                                    ],
                                  ),
                                ),
                                Card(
                                  color: Colors.orange.shade700,
                                  child: ExpansionTile(
                                    leading: const Icon(Icons.folder,
                                        color: Colors.white),
                                    title: Text('Dossier Créances',
                                        style: (Responsive.isDesktop(context))
                                            ? headline6!
                                                .copyWith(color: Colors.white)
                                            : bodyLarge!
                                                .copyWith(color: Colors.white)),
                                    subtitle: Text(
                                        "Vous avez ${financeNotifyController.creanceCount} dossiers necessitent votre approbation",
                                        style: bodyMedium.copyWith(
                                            color: Colors.white70)),
                                    initiallyExpanded: false,
                                    onExpansionChanged: (val) {
                                      setState(() {
                                        isOpen7 = !val;
                                      });
                                    },
                                    trailing: const Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.white,
                                    ),
                                    children: [TableCreanceDD(creanceController: creanceController)],
                                  ),
                                ),
                              ]),
                        )),
                  ))
            ],
          )),
    );
  }
}