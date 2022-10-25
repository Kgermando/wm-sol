import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/administration/components/rh/table_transport_rest_dg.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/notify/rh_notify_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/transport_rest/transport_rest_controller.dart'; 

class AdminRH extends StatefulWidget {
  const AdminRH({super.key});

  @override
  State<AdminRH> createState() => _AdminRHState();
}

class _AdminRHState extends State<AdminRH> {
  final RHNotifyController controller =
      Get.put(RHNotifyController()); 
  final TransportRestController transportRestController =
      Get.put(TransportRestController()); 
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "RH";
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
                                    title: Text('Dossier Transports & Restaurations',
                                        style: (Responsive.isDesktop(context))
                                            ? headline6!
                                                .copyWith(color: Colors.white)
                                            : bodyLarge!.copyWith(
                                                color: Colors.white)),
                                    subtitle: Text(
                                        "Vous avez ${controller.itemCountTransRestDG} dossiers necessitent votre approbation",
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
                                        color: Colors.white),
                                    children: [
                                      TableTransportRestDG(transportRestController: transportRestController)
                                    ],
                                  )),
                            ])),
                  ))
            ],
          )),
    );
  }
}