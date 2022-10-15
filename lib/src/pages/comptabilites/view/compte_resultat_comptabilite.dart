import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/comptabilites/components/compte_resultat/table_compte_resultat.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/compte_resultat/compte_resultat_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/loading.dart';

class CompteResultatComptabilite extends StatefulWidget {
  const CompteResultatComptabilite({super.key});

  @override
  State<CompteResultatComptabilite> createState() =>
      _CompteResultatComptabiliteState();
}

class _CompteResultatComptabiliteState
    extends State<CompteResultatComptabilite> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Comptabilités";
  String subTitle = "bilan";

  @override
  Widget build(BuildContext context) {
    final CompteResultatController controller = Get.put(CompteResultatController());
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
                  label: const Text("Feuille compte resultat"),
                  tooltip: "Ajouter compte resultat",
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    Get.toNamed(
                        ComptabiliteRoutes.comptabiliteCompteResultatAdd);
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
                          child: TableCompteResultat(
                              compteResultatList: controller.compteResultatList,
                              controller: controller))),
                ],
              ))),
    );
  }
}