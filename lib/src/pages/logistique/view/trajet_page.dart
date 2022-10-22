import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/logistique/components/automobiles/trajets/table_trajet.dart';
import 'package:wm_solution/src/pages/logistique/controller/automobiles/trajet_controller.dart';  
import 'package:wm_solution/src/widgets/loading.dart';

class TrajetPage extends StatefulWidget {
  const TrajetPage({super.key});

  @override
  State<TrajetPage> createState() => _TrajetPageState();
}

class _TrajetPageState extends State<TrajetPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Logistique";
  String subTitle = "Trajets";

  @override
  Widget build(BuildContext context) {
    final TrajetController controller = Get.put(TrajetController());
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
                child: TableTrajet(trajetList: controller.trajetList, controller: controller))),
          ],
      ))),
    );
  }
}
