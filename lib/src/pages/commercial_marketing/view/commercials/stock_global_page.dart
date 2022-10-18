import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/commercial_marketing/components/commercials/stock_global/list_stock_global.dart';
import 'package:wm_solution/src/pages/commercial_marketing/controller/commercials/stock_global/stock_global_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/loading.dart';

class StockGlobalPage extends StatefulWidget {
  const StockGlobalPage({super.key});

  @override
  State<StockGlobalPage> createState() => _StockGlobalPageState();
}

class _StockGlobalPageState extends State<StockGlobalPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Commercial & Marketing";
  String subTitle = "Stocks global";

  @override
  Widget build(BuildContext context) {
    final StockGlobalController controller = Get.put(StockGlobalController());
    final ProfilController profilController = Get.put(ProfilController());

    return controller.obx(
      onLoading: loading(),
      onEmpty: const Text('Aucune donnée'),
      onError: (error) => Text(
          "Une erreur s'est produite $error veiller actualiser votre logiciel. Merçi."),
      (state) => Scaffold(
          key: scaffoldKey,
          appBar: headerBar(
              context, scaffoldKey, title, subTitle),
          drawer: const DrawerMenu(),
          floatingActionButton: FloatingActionButton.extended(
            label: const Text("Ajouter stock"),
            tooltip: "Ajout le stock global",
            icon: const Icon(Icons.person_add),
            onPressed: () {
              Get.toNamed(
                ComMarketingRoutes.comMarketingStockGlobalAdd
              );
            },
          ),
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                  visible: !Responsive.isMobile(context),
                  child: const Expanded(flex: 1, child: DrawerMenu())),
              Expanded(
                flex: 5,
                child: SingleChildScrollView(
                    controller: ScrollController(),
                    physics: const ScrollPhysics(),
                    child: Container(
                      margin: const EdgeInsets.only(
                          top: p20, bottom: p8, right: p20, left: p20),
                      decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20))),
                      child: ListView.builder( 
                          itemCount: controller.stockGlobalList.length,
                          itemBuilder: (context, index) {
                            final data = controller.stockGlobalList[index];
                            return ListStockGlobal(
                              stocksGlobalMOdel: data,
                              role: profilController.user.role);
                          }),
                    )))
            ],
          ),
        ));
  }
}