import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/commercial_marketing/components/commercials/history_livraison/table_history_livraison.dart';
import 'package:wm_solution/src/pages/commercial_marketing/controller/commercials/history/history_livraison.dart';
import 'package:wm_solution/src/widgets/loading.dart';

class HistoryLivraisonPage extends StatefulWidget {
  const HistoryLivraisonPage({super.key});

  @override
  State<HistoryLivraisonPage> createState() => _HistoryLivraisonPageState();
}

class _HistoryLivraisonPageState extends State<HistoryLivraisonPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Commercial & Marketing";
  String subTitle = "Historique des Livraisons";

  @override
  Widget build(BuildContext context) {
    final HistoryLivraisonController controller =
        Get.put(HistoryLivraisonController());
    final ProfilController profilController = Get.put(ProfilController());
    return SafeArea(
      child: controller.obx(
          onLoading: loadingPage(context),
          onEmpty: const Text('Aucune donnée'),
          onError: (error) => loadingError(context, error!),
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
                          child: TableHistoryLivraison(
                              livraisonHistoryList:
                                  controller.livraisonHistoryList,
                              profilController: profilController))),
                ],
              ))),
    );
  }
}
