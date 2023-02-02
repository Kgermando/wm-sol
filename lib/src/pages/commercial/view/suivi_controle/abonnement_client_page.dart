import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/commercial/components/suivi_controle/abonnement_client/table_abonnement_client.dart';
import 'package:wm_solution/src/pages/commercial/controller/suivi_controle/abonnement_client_controller.dart';  
import 'package:wm_solution/src/widgets/loading.dart';


class AbonnementClientPage extends StatefulWidget {
  const AbonnementClientPage({super.key});

  @override
  State<AbonnementClientPage> createState() => _AbonnementClientPageState();
}

class _AbonnementClientPageState extends State<AbonnementClientPage> {
  final AbonnementClientController controller =
      Get.put(AbonnementClientController());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Commercials";
  String subTitle = "Abonnement Clients";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      child: TableAbonnementClient(controller: controller, state: state!)
                          
                  ))),
          ],
        ));
  }
}
