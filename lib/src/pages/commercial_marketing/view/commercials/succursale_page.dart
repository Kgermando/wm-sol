import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/commercial_marketing/components/commercials/succursale/table_succursale.dart';
import 'package:wm_solution/src/pages/commercial_marketing/controller/commercials/succursale/succursale_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/loading.dart';

class SuccursalePage extends StatefulWidget {
  const SuccursalePage({super.key});

  @override
  State<SuccursalePage> createState() => _SuccursalePageState();
}

class _SuccursalePageState extends State<SuccursalePage> {
  final SuccursaleController controller = Get.put(SuccursaleController());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Commercial & Marketing";
  String subTitle = "Succursales";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: controller.obx(
          onLoading: loadingPage(context),
          onEmpty: const Text('Aucune donnée'),
          onError: (error) => loadingError(context, error!),
          (data) => Scaffold(
              key: scaffoldKey,
              appBar: headerBar(context, scaffoldKey, title, subTitle),
              drawer: const DrawerMenu(),
              floatingActionButton: FloatingActionButton.extended(
                  label: const Text("Ajouter une succursale"),
                  tooltip: "Nouveau succursale",
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    Get.toNamed(ComRoutes.comSuccursaleAdd);
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
                          child: TableSuccursale(
                              succursaleList: controller.succursaleList,
                              controller: controller))),
                ],
              ))),
    );
  }
}
