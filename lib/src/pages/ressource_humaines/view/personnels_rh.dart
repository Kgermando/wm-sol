import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/personnels/table_personnels.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/personnels/personnels_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/loading.dart';

class PersonnelsPage extends StatefulWidget {
  const PersonnelsPage({Key? key}) : super(key: key);

  @override
  State<PersonnelsPage> createState() => _PersonnelsPageState();
}

class _PersonnelsPageState extends State<PersonnelsPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Ressources Humaines";
  String subTitle = "Personnels";

  @override
  Widget build(BuildContext context) {
    final PersonnelsController controller = Get.find();

    return Scaffold(
    key: scaffoldKey,
    appBar: headerBar(context, scaffoldKey, title, subTitle),
    drawer: const DrawerMenu(),
    floatingActionButton: FloatingActionButton.extended(
      label: const Text("Nouveau profil"),
      tooltip: "Nouveau profil",
      icon: const Icon(Icons.person_add),
      onPressed: () {
        Get.toNamed(RhRoutes.rhPersonnelsAdd, arguments: controller.personnelsList);
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
                  child: TablePersonnels(
                      personnelList: state!, controller: controller))) ) 
        ],
      ));
     
  }
}
