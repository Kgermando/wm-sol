import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/commercial_marketing/components/commercials/history_ravitaillement/table_history_ravitaillement.dart';
import 'package:wm_solution/src/pages/commercial_marketing/controller/commercials/history/history_ravitaillement_controller.dart'; 
import 'package:wm_solution/src/widgets/loading.dart'; 

class HistoryRavitaillementPage extends StatefulWidget {
  const HistoryRavitaillementPage({super.key});

  @override
  State<HistoryRavitaillementPage> createState() => _HistoryRavitaillementPageState();
}

class _HistoryRavitaillementPageState extends State<HistoryRavitaillementPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Commercial & Marketing";
  String subTitle = "Historique des Ravitaillements";

  @override
  Widget build(BuildContext context) {
    final HistoryRavitaillementController controller = Get.put(HistoryRavitaillementController());
    final ProfilController profilController  =
        Get.put(ProfilController());
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
                          child: TableHistoryRavitaillement(historyRavitaillementList: controller.historyRavitaillementList, profilController: profilController))),
                ],
              ))),
    );
  }
}