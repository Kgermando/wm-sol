import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/commercial/components/commercial/achats/list_stock.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/achats/achat_controller.dart';
import 'package:wm_solution/src/widgets/loading.dart';

class AchatPage extends StatefulWidget {
  const AchatPage({super.key});

  @override
  State<AchatPage> createState() => _AchatPageState();
}

class _AchatPageState extends State<AchatPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Commercial";
  String subTitle = "Stocks succursale";

  @override
  Widget build(BuildContext context) {
    final AchatController controller = Get.find();
    final ProfilController profilController = Get.find();

    return Scaffold(
      key: scaffoldKey,
      appBar: headerBar(context, scaffoldKey, title, subTitle),
      drawer: const DrawerMenu(),
      body:  Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
        (state) => SingleChildScrollView(
                  controller: ScrollController(),
                  physics: const ScrollPhysics(),
                  child: Container(
                      margin: const EdgeInsets.only(
                          top: p20, bottom: p8, right: p20, left: p20),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    controller.getList();
                                  },
                                  icon: const Icon(Icons.refresh,
                                      color: Colors.green))
                            ],
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: state!.length,
                            itemBuilder: (context, index) {
                              final data = state[index];
                              return ListStock(
                                  achat: data, role: profilController.user.role);
                            }),
                        ],
                      )))))
        ],
      )
      
      
      ,
    );
  }
}
