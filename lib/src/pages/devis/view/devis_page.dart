import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/devis/components/table_devis.dart';
import 'package:wm_solution/src/pages/devis/controller/devis_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/loading.dart';

class DevisPage extends StatefulWidget {
  const DevisPage({super.key});

  @override
  State<DevisPage> createState() => _DevisPageState();
}

class _DevisPageState extends State<DevisPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Logistique";
  String subTitle = "état de besoin";

  @override
  Widget build(BuildContext context) {
    final DevisController controller = Get.put(DevisController());
    return SafeArea(
      child: controller.obx(
        onLoading: loading(),
        onEmpty: const Text('Aucune donnée'),
        onError: (error) => Text(
            "Une erreur s'est produite $error veiller actualiser votre logiciel. Merçi."),
        (data) => Scaffold(
            key: scaffoldKey,
            appBar: headerBar(context, scaffoldKey, title, subTitle),
            drawer: const DrawerMenu(),
            floatingActionButton: FloatingActionButton.extended(
              label: const Text("Nouveau devis"),
              tooltip: "Etat de besoin",
              icon: const Icon(Icons.add),
              onPressed: () {
                Get.toNamed(DevisRoutes.devisAdd);
              }),
            body: Row(
              children: [
                Visibility(
                    visible: !Responsive.isMobile(context),
                    child: const Expanded(flex: 1, child: DrawerMenu())),
                Expanded(
                    flex: 5,
                    child: Container(
                      margin: const EdgeInsets.only(
                          top: p20, right: p20, left: p20, bottom: p8),
                      decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20))),
                      child: TableDevis(devisList: controller.devisList, controller: controller))),
              ],
            ))),
    );
  }
}