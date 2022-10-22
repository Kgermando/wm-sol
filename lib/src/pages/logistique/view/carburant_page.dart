import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/logistique/components/automobiles/carburants/table_carburant.dart';
import 'package:wm_solution/src/pages/logistique/controller/automobiles/carburant_controller.dart'; 
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/loading.dart';

class CarburantPage extends StatefulWidget {
  const CarburantPage({super.key});

  @override
  State<CarburantPage> createState() => _CarburantPageState();
}

class _CarburantPageState extends State<CarburantPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Logistique";
  String subTitle = "carburants";

  @override
  Widget build(BuildContext context) {
    final CarburantController controller = Get.put(CarburantController());
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
          label: const Text("Nouvel carburant"),
          tooltip: "Ajouter une nouvelle quantité carburant",
          icon: const Icon(Icons.add),
          onPressed: () {
            Get.toNamed(LogistiqueRoutes.logAddCarburantAuto);
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
                    child: TableCarburant(carburantList: controller.carburantList, controller: controller))),
          ],
        ))),
    );
  }
}