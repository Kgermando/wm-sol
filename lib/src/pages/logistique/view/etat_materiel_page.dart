import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/logistique/components/etat_materiels/table_etat_materiel.dart';
import 'package:wm_solution/src/pages/logistique/controller/etat_materiel/etat_materiel_controller.dart'; 
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/loading.dart';

class EtatMaterielPage extends StatefulWidget {
  const EtatMaterielPage({super.key});

  @override
  State<EtatMaterielPage> createState() => _EtatMaterielPageState();
}

class _EtatMaterielPageState extends State<EtatMaterielPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Logistique";
  String subTitle = "Etats materiels";

  @override
  Widget build(BuildContext context) {
    final EtatMaterielController controller = Get.put(EtatMaterielController());
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
            label: const Text("Statut du materiel"),
            tooltip: "Ajouter le statut de materiel",
            icon: const Icon(Icons.add),
            onPressed: () {
              Get.toNamed(LogistiqueRoutes.logAddEtatMateriel);
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
                      child: TableEtatMateriel(etatMaterielList: controller.etatMaterielList, controller: controller))),
            ],
          ))),
    );
  }
}