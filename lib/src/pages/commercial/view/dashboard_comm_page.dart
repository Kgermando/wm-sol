import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/commercial/components/commercial/dashboard/arcticle_plus_vendus.dart';
import 'package:wm_solution/src/pages/commercial/components/commercial/dashboard/courbe_vente_gain_day.dart';
import 'package:wm_solution/src/pages/commercial/components/commercial/dashboard/courbe_vente_gain_mounth.dart';
import 'package:wm_solution/src/pages/commercial/components/commercial/dashboard/courbe_vente_gain_year.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/history/history_vente_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/dashboard/dashboard_com_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/dash_number_widget.dart'; 
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';

class DashboardCommPage extends StatefulWidget {
  const DashboardCommPage({super.key});

  @override
  State<DashboardCommPage> createState() => _DashboardCommPageState();
}

class _DashboardCommPageState extends State<DashboardCommPage> {
  final DashboardComController controller = Get.put(DashboardComController());
  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());
  final VenteCartController venteCartController = Get.put(VenteCartController());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Commercial";
  String subTitle = "Dashboard";

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: p20),
                            child: GetBuilder( 
                              builder: (DashboardComController controller) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    alignment: WrapAlignment.spaceEvenly,
                                    children: [
                                      DashNumberWidget(
                                          gestureTapCallback: () {
                                            Get.toNamed(ComRoutes.comVente);
                                          },
                                          number:
                                              '${NumberFormat.decimalPattern('fr').format(controller.sumVente)} ${monnaieStorage.monney}',
                                          title: 'Ventes',
                                          icon: Icons.shopping_cart,
                                          color: Colors.purple.shade700),
                                      DashNumberWidget(
                                          gestureTapCallback: () {
                                            Get.toNamed(ComRoutes.comVente);
                                          },
                                          number:
                                              '${NumberFormat.decimalPattern('fr').format(controller.sumGain)} ${monnaieStorage.monney}',
                                          title: 'Gains',
                                          icon: Icons.grain,
                                          color: Colors.green.shade700),
                                      DashNumberWidget(
                                          gestureTapCallback: () {
                                            Get.toNamed(ComRoutes.comCreance);
                                          },
                                          number:
                                              '${NumberFormat.decimalPattern('fr').format(controller.sumDCreance)} ${monnaieStorage.monney}',
                                          title: 'Créances',
                                          icon: Icons.money_off_outlined,
                                          color: Colors.pink.shade700),
                                      DashNumberWidget(
                                          gestureTapCallback: () {
                                            Get.toNamed(
                                                ComRoutes.comSuccursale);
                                          },
                                          number:
                                              '${controller.succursaleCount}',
                                          title: 'Succursale',
                                          icon: Icons.store,
                                          color: Colors.brown.shade700),
                                      DashNumberWidget(
                                          gestureTapCallback: () {
                                            Get.toNamed(
                                                ComRoutes.comEntreprise);
                                          },
                                          number:
                                              '${controller.entrepriseInfosCount}',
                                          title: 'Total Clients',
                                          icon: Icons.data_exploration,
                                          color: Colors.red.shade700),
                                      DashNumberWidget(
                                          gestureTapCallback: () {
                                            Get.toNamed(
                                                ComRoutes.comEntreprise);
                                          },
                                          number:
                                              '${controller.entrepriseInfosActiveCount}',
                                          title: 'Clients Actifs',
                                          icon: Icons.auto_graph,
                                          color: Colors.grey.shade700),
                                      DashNumberWidget(
                                          gestureTapCallback: () {
                                            Get.toNamed(
                                                ComRoutes.comEntreprise);
                                          },
                                          number:
                                              '${controller.entrepriseCount}',
                                          title: 'Entreprises',
                                          icon: Icons.business,
                                          color: Colors.teal.shade700),
                                      DashNumberWidget(
                                          gestureTapCallback: () {
                                            Get.toNamed(
                                                ComRoutes.comEntreprise);
                                          },
                                          number:
                                              '${controller.particulierCount}',
                                          title: 'Particuliers',
                                          icon: Icons.group,
                                          color: Colors.blue.shade700),
                                      DashNumberWidget(
                                          gestureTapCallback: () {
                                            Get.toNamed(
                                                ComRoutes.comEntreprise);
                                          },
                                          number:
                                              '${controller.ongAsblCount}',
                                          title: 'ONG & ASBL',
                                          icon: Icons.group,
                                          color: Colors.orange.shade700),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  ResponsiveChildWidget(
                                      child1: CourbeVenteGainDay(
                                          controller: controller,
                                        monnaieStorage: monnaieStorage,
                                      ),
                                      child2: CourbeVenteGainMounth(
                                          controller: controller,
                                        monnaieStorage: monnaieStorage,
                                      )),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  CourbeVenteGainYear(controller: controller,
                                    monnaieStorage: monnaieStorage,
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),

                                  ArticlePlusVendus(
                                    state: controller.venteChartList,
                                    monnaieStorage: monnaieStorage)
                                   
                                ])) ,
                          )),
                    ))
              ],
            ));
  }
}
