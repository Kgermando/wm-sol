import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/actionnaire/components/table_cotisation.dart';
import 'package:wm_solution/src/pages/actionnaire/controller/actionnaire_cotisation_controller.dart';
import 'package:wm_solution/src/widgets/loading.dart';

class ActionnaireCotisationPage extends StatefulWidget {
  const ActionnaireCotisationPage({super.key});

  @override
  State<ActionnaireCotisationPage> createState() =>
      _ActionnaireCotisationPageState();
}

class _ActionnaireCotisationPageState extends State<ActionnaireCotisationPage> {
  final ActionnaireCotisationController controller = Get.put(ActionnaireCotisationController());
  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Actionnaire";
  String subTitle = "Cotisations";

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
                        child: TableCotisation(
                            state: state!, monnaie: monnaieStorage.monney)))),
          ],
        ));
  }
}
