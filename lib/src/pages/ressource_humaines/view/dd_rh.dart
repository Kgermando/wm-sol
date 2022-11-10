import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/dd_rh/trans_rest/table_transport_rest_dd.dart'; 
import 'package:wm_solution/src/pages/ressource_humaines/components/dd_rh/users_actifs/table_users_actifs.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/notify/rh_notify_controller.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/dd_rh/salaires/table_salaire_dd.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/personnels/user_actif_controller.dart'; 
import 'package:wm_solution/src/pages/ressource_humaines/controller/salaires/salaire_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/transport_rest/transport_rest_controller.dart';

class DDRH extends StatefulWidget {
  const DDRH({super.key});

  @override
  State<DDRH> createState() => _DDRHState();
}

class _DDRHState extends State<DDRH> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Ressources Humaines";
  String subTitle = "Direteur de département";

  bool isOpen1 = false;
  bool isOpen2 = false;
  bool isOpen3 = false;

  @override
  Widget build(BuildContext context) {
    final RHNotifyController controller = Get.find();
    final SalaireController salaireController = Get.find();
    final TransportRestController transportRestController = Get.find();
    final UsersController usersController = Get.find();


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
                      color: Colors.red.shade700,
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
                          "Vous avez ${controller.itemCountSalaireDD} dossiers necessitant votre approbation",
                          style: bodyMedium!
                              .copyWith(color: Colors.white70)),
                      initiallyExpanded: false,
                      onExpansionChanged: (val) {
                        setState(() {
                          isOpen1 = !val;
                        });
                      },
                      trailing: const Icon(Icons.arrow_drop_down,
                          color: Colors.white),
                      children: [TableSalaireDD(salaireController: salaireController)],
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
                          "Vous avez ${controller.itemCountTransRestDD} dossiers necessitant votre approbation",
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
                        TableTransportRestDD(transportRestController: transportRestController)
                      ],
                    ),
                  ), 
                  Card(
                      color: Colors.green.shade700,
                        child: ExpansionTile(
                          leading: const Icon(Icons.folder,
                              color: Colors.white),
                          title: Text('Dossier utilisateurs actifs',
                              style: (Responsive.isDesktop(context))
                                  ? headline6!
                                      .copyWith(color: Colors.white)
                                  : bodyLarge!
                                      .copyWith(color: Colors.white)),
                          initiallyExpanded: false,
                          onExpansionChanged: (val) {
                            setState(() {
                              isOpen3 = !val;
                            });
                          },
                          trailing: const Icon(Icons.arrow_drop_down,
                              color: Colors.white),
                          children: [TableUsersActifs(usersController: usersController)],
                        ),
                    ),
                  ]
                )),
            ))
        ],
      )),
    );
  }
}
