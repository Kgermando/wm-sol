import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/logistique/components/materiels/table_materiel.dart';
import 'package:wm_solution/src/pages/logistique/controller/materiels/materiel_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/loading.dart';

class MaterielPage extends StatefulWidget {
  const MaterielPage({super.key});

  @override
  State<MaterielPage> createState() => _MaterielPageState();
}

class _MaterielPageState extends State<MaterielPage> {
  final MaterielController controller = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Logistique";
  String subTitle = "Materiels";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: headerBar(context, scaffoldKey, title, subTitle),
        drawer: const DrawerMenu(),
        floatingActionButton: FloatingActionButton.extended(
          label: const Text("Nouveau materiel"),
          tooltip: "Ajouter un nouveau materiel",
          icon: const Icon(Icons.add),
          onPressed: () {
            Get.toNamed(LogistiqueRoutes.logMaterielAdd);
          },
        ),
        body: Row(
          children: [
            Visibility(
                visible: !Responsive.isMobile(context),
                child: const Expanded(flex: 1, child: DrawerMenu())),
            Expanded(
                flex: 5,
                child: controller.obx(
                    onLoading: loadingPage(context),
                    onEmpty: const Text('Aucune donnée'),
                    onError: (error) => loadingError(context, error!),
                    (data) => Container(
                        margin: const EdgeInsets.only(
                            top: p20, right: p20, left: p20, bottom: p8),
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: TableMateriel(
                            materielList: controller.materielList
                                .where((p0) => p0.typeMateriel == 'Materiel')
                                .toList(),
                            controller: controller)))),
          ],
        ));
  }
}
