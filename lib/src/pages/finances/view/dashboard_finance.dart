import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/finances/components/dashboard/banque/chart_banque.dart';
import 'package:wm_solution/src/pages/finances/components/dashboard/caisse/chart_caisse.dart';
import 'package:wm_solution/src/pages/finances/components/dashboard/fin_exterieur/chart_fin_exterieur.dart';
import 'package:wm_solution/src/pages/finances/controller/charts/chart_banque_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/charts/chart_caisse_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/charts/chart_fin_exterieur_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/dahboard/dashboard_finance_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/dashboard_card_widget.dart';

class DashboadFinance extends StatefulWidget {
  const DashboadFinance({super.key});

  @override
  State<DashboadFinance> createState() => _DashboadFinanceState();
}

class _DashboadFinanceState extends State<DashboadFinance> {
  final DashboardFinanceController controller = Get.find();
  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());
  final ChartBanqueController chartBanqueController =
      Get.put(ChartBanqueController());
  final ChartCaisseController chartCaisseController =
      Get.put(ChartCaisseController());
  final ChartFinExterieurController chartFinExterieurController =
      Get.put(ChartFinExterieurController());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Finances";
  String subTitle = "Dashboard";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: scaffoldKey,
          appBar: headerBar(context, scaffoldKey, title, subTitle),
          drawer: const DrawerMenu(),
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: p20),
                          child: Obx(() => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Wrap(
                                      alignment: WrapAlignment.spaceEvenly,
                                      spacing: 12.0,
                                      runSpacing: 12.0,
                                      direction: Axis.horizontal,
                                      children: [
                                        DashboardCardWidget(
                                          gestureTapCallback: () {},
                                          title: 'TOTAL CAISSE',
                                          icon: Icons.view_stream_outlined,
                                          montant: '${controller.soldeCaisse}',
                                          color: Colors.yellow.shade700,
                                          colorText: Colors.black,
                                        ),
                                        DashboardCardWidget(
                                          gestureTapCallback: () {},
                                          title: 'TOTAL BANQUE',
                                          icon: Icons.business,
                                          montant: '${controller.soldeBanque}',
                                          color: Colors.green.shade700,
                                          colorText: Colors.white,
                                        ),
                                        DashboardCardWidget(
                                          gestureTapCallback: () {
                                            Get.toNamed(FinanceRoutes
                                                .transactionsDettes);
                                          },
                                          title: 'DETTES',
                                          icon: Icons.money_off,
                                          montant: '${controller.soldeDette}',
                                          color: Colors.red.shade700,
                                          colorText: Colors.white,
                                        ),
                                        DashboardCardWidget(
                                          gestureTapCallback: () {
                                            Get.toNamed(FinanceRoutes
                                                .transactionsCreances);
                                          },
                                          title: 'CREANCES',
                                          icon: Icons.money_off_csred,
                                          montant: '${controller.soldeCreance}',
                                          color: Colors.purple.shade700,
                                          colorText: Colors.white,
                                        ),
                                        // DashboardCardWidget(
                                        //   gestureTapCallback: () {
                                        //     Get.toNamed(
                                        //         FinanceRoutes.transactionsFinancementExterne);
                                        //   },
                                        //   title: 'ACTIONNAIRE',
                                        //   icon: Icons.money_outlined,
                                        //   montant: '$actionnaire',
                                        //   color: Colors.teal.shade700,
                                        //   colorText: Colors.white,
                                        // ),
                                        DashboardCardWidget(
                                          gestureTapCallback: () {},
                                          title: 'TOTAL FIN. EXTERNE',
                                          icon: Icons.money_outlined,
                                          montant:
                                              '${controller.cumulFinanceExterieur}',
                                          color: Colors.grey.shade700,
                                          colorText: Colors.white,
                                        ),
                                        DashboardCardWidget(
                                          gestureTapCallback: () {},
                                          title: 'TOTAL DEPENSES',
                                          icon: Icons.monetization_on,
                                          montant: '${controller.depenses}',
                                          color: Colors.orange.shade700,
                                          colorText: Colors.white,
                                        ),
                                        DashboardCardWidget(
                                          gestureTapCallback: () {},
                                          title: 'TOTAL DIPONIBLES',
                                          icon: Icons.attach_money,
                                          montant: '${controller.disponible}',
                                          color: Colors.blue.shade700,
                                          colorText: Colors.white,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    Card(
                                        child: ChartBanque(
                                      chartBanqueController:
                                          chartBanqueController,
                                      monnaieStorage: monnaieStorage,
                                    )),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    Card(
                                        child: ChartCaisse(
                                      chartCaisseController:
                                          chartCaisseController,
                                      monnaieStorage: monnaieStorage,
                                    )),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    Card(
                                        child: ChartFinExterieur(
                                      chartFinExterieurController:
                                          chartFinExterieurController,
                                      monnaieStorage: monnaieStorage,
                                    )),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                  ])),
                        )),
                  ))
            ],
          )),
    );
  }
}
