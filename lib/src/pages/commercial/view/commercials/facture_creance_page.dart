import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/commercial/components/factures/table_facture_creance.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/factures/facture_creance_controller.dart';
import 'package:wm_solution/src/widgets/loading.dart';

class FactureCreancePage extends StatefulWidget {
  const FactureCreancePage({super.key});

  @override
  State<FactureCreancePage> createState() => _FactureCreancePageState();
}

class _FactureCreancePageState extends State<FactureCreancePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Commercial";
  String subTitle = "Factures par créances";

  @override
  Widget build(BuildContext context) {
    final FactureCreanceController controller = Get.find();
    final ProfilController profilController = Get.find();
    return Scaffold(
      key: scaffoldKey,
      appBar: headerBar(context, scaffoldKey, title, subTitle),
      drawer: const DrawerMenu(),
      body: controller.obx(
          onLoading: loadingPage(context),
          onEmpty: const Text('Aucune donnée'),
          onError: (error) => loadingError(context, error!),
          (data) => Row(
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
                  child: TableFactureCreance(
                      creanceFactureList: controller.creanceFactureList,
                      controller: controller,
                      profilController: profilController))),
        ],
      )) ); 
  }
}
