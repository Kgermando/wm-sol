import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/performences/table_performence.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/performences/performence_controller.dart';
import 'package:wm_solution/src/widgets/loading.dart';

class PerformenceRH extends StatefulWidget {
  const PerformenceRH({super.key});

  @override
  State<PerformenceRH> createState() => _PerformenceRHState();
}

class _PerformenceRHState extends State<PerformenceRH> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Ressources Humaines";
  String subTitle = "Performences";

  @override
  Widget build(BuildContext context) {
    final PerformenceController controller = Get.put(PerformenceController());
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
                          child: TablePerformence(
                              performenceList: controller.performenceList,
                              controller: controller))),
                ],
              ))),
    );
  }
}