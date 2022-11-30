import 'package:flutter/material.dart'; 
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/comptabilites/components/balance/balance_pdf.dart';
import 'package:wm_solution/src/pages/comptabilites/components/balance/balance_xlsx.dart';
import 'package:wm_solution/src/pages/comptabilites/components/balance/list_balance.dart'; 
import 'package:wm_solution/src/pages/comptabilites/controller/balance/balance_sum_controller.dart';
import 'package:wm_solution/src/routes/routes.dart'; 
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/print_widget.dart'; 

class BalanceComptabilite extends StatefulWidget {
  const BalanceComptabilite({super.key});

  @override
  State<BalanceComptabilite> createState() => _BalanceComptabiliteState();
}

class _BalanceComptabiliteState extends State<BalanceComptabilite> {
  final BalanceSumController balanceSumController = Get.find();
  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());
 
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Comptabilités";
  String subTitle = "Balance";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
key: scaffoldKey,
appBar: headerBar(context, scaffoldKey, title, subTitle),
drawer: const DrawerMenu(),
body: balanceSumController.obx(
    onLoading: loadingPage(context),
    onEmpty: const Text('Aucune donnée'),
    onError: (error) => loadingError(context, error!),
    (state) => Row(
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
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context,
                                      ComptabiliteRoutes
                                          .comptabiliteBalance);
                                  balanceSumController.getList();
                                },
                                icon: const Icon(Icons.refresh,
                                    color: Colors.green)),
                            PrintWidget(
                                tooltip: 'Imprimer le document',
                                onPressed: () async {
                                  await BalancePdf.generate(state!, monnaieStorage);
                                }),
                            IconButton(
                                onPressed: () async {
                                  await BalanceXlsx()
                                      .exportToExcel(state!);
                                },
                                icon: const Icon(
                                  Icons.download,
                                  color: Colors.blue,
                                ))
                          ],
                        ),
                        const SizedBox(height: p20),
                        Expanded(
                            child: Card(
                              child: ListBalance(
                                  balanceList: state!,
                                  controller: balanceSumController),
                            )),
                      ],
                    ))),
          ],
        )));
  }


}
