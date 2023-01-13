import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/commercial/components/suivi_controle/entreprise_infos/table_entreprise_infos.dart';
import 'package:wm_solution/src/pages/commercial/controller/suivi_controle/entreprise_infos_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/loading.dart';

class EntrepriseInfoPage extends StatefulWidget {
  const EntrepriseInfoPage({super.key});

  @override
  State<EntrepriseInfoPage> createState() => _EntrepriseInfoPageState();
}

class _EntrepriseInfoPageState extends State<EntrepriseInfoPage> {
 final EntrepriseInfosController controller =
      Get.put(EntrepriseInfosController());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Commercials";
  String subTitle = "Entreprise infos";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: headerBar(context, scaffoldKey, title, subTitle),
        drawer: const DrawerMenu(),
        floatingActionButton: FloatingActionButton.extended(
          label: const Text("Nouvel entreprise"),
          tooltip: "Ajouter une entreprise",
          icon: const Icon(Icons.add),
          onPressed: () { 
             Get.toNamed(ComRoutes.comEntrepriseAdd);
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
                  (state) => Container(
                      margin: const EdgeInsets.only(
                          top: p20, right: p20, left: p20, bottom: p8),
                      decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20))),
                      child: TableEntrepriseInfos(controller: controller, state: state!)
                          
                  ))),
          ],
        ));
  }

}