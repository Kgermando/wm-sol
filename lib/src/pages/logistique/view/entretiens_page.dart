import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/logistique/components/entretiens/table_entretien.dart'; 
import 'package:wm_solution/src/pages/logistique/controller/entretiens/entretiens_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/loading.dart';

class EntretiensPage extends StatefulWidget {
  const EntretiensPage({super.key});

  @override
  State<EntretiensPage> createState() => _EntretiensPageState();
}

class _EntretiensPageState extends State<EntretiensPage> {
   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Logistique";
  String subTitle = "Entretiens";

  @override
  Widget build(BuildContext context) {
    final EntretienController controller = Get.put(EntretienController());
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
            label: const Text("Nouvel entretien"),
            tooltip: "Ajouter un nouveau entretien",
            icon: const Icon(Icons.add),
            onPressed: () {
              Get.toNamed(LogistiqueRoutes.logAddEntretien);
            },
          ),
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
                      child: TableEntretien(entretienList: controller.entretienList, controller: controller))),
            ],
          ))),
    );
  }
}