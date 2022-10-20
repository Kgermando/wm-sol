import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/commercial_marketing/components/dashboard/arcticle_plus_vendus.dart';
import 'package:wm_solution/src/pages/commercial_marketing/components/dashboard/courbe_vente_gain_mounth.dart';
import 'package:wm_solution/src/pages/commercial_marketing/components/dashboard/courbe_vente_gain_year.dart';
import 'package:wm_solution/src/pages/commercial_marketing/controller/dashboard/dashboard_com_marketing_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/dash_number_widget.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';

class DashboardCommMarketingPage extends StatefulWidget {
  const DashboardCommMarketingPage({super.key});

  @override
  State<DashboardCommMarketingPage> createState() =>
      _DashboardCommMarketingPageState();
}

class _DashboardCommMarketingPageState
    extends State<DashboardCommMarketingPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Commercial & Marketing";
  String subTitle = "Dashboard";

  @override
  Widget build(BuildContext context) {
    final DashboardComMarketingController controller =
        Get.put(DashboardComMarketingController());

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
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  alignment: WrapAlignment.spaceEvenly,
                                  children: [
                                    DashNumberWidget(
                                        gestureTapCallback: () {
                                          Get.toNamed(ComMarketingRoutes
                                              .comMarketingVente); 
                                        },
                                        number:
                                            '${NumberFormat.decimalPattern('fr').format(controller.sumVente)} \$',
                                        title: 'Ventes',
                                        icon: Icons.shopping_cart,
                                        color: Colors.purple.shade700),
                                    DashNumberWidget(
                                        gestureTapCallback: () {
                                          Get.toNamed(ComMarketingRoutes
                                              .comMarketingVente);    
                                        },
                                        number:
                                            '${NumberFormat.decimalPattern('fr').format(controller.sumGain)} \$',
                                        title: 'Gains',
                                        icon: Icons.grain,
                                        color: Colors.green.shade700),
                                    DashNumberWidget(
                                        gestureTapCallback: () {
                                          Get.toNamed(ComMarketingRoutes
                                              .comMarketingCreance);   
                                        },
                                        number:
                                            '${NumberFormat.decimalPattern('fr').format(controller.sumDCreance)} \$',
                                        title: 'Créances',
                                        icon: Icons.money_off_outlined,
                                        color: Colors.pink.shade700),
                                    DashNumberWidget(
                                        gestureTapCallback: () {
                                          Get.toNamed(ComMarketingRoutes
                                              .comMarketingSuccursale);  
                                        },
                                        number: '${controller.succursaleCount}',
                                        title: 'Succursale',
                                        icon: Icons.house,
                                        color: Colors.brown.shade700),
                                    DashNumberWidget(
                                        gestureTapCallback: () {
                                          Get.toNamed(ComMarketingRoutes
                                              .comMarketingCampaign); 
                                        },
                                        number: '${controller.campaignCount}',
                                        title: 'Campagnes',
                                        icon: Icons.campaign,
                                        color: Colors.orange.shade700),
                                    DashNumberWidget(
                                        gestureTapCallback: () {
                                          Get.toNamed(ComMarketingRoutes
                                              .comMarketingAnnuaire);
                                        },
                                        number: '${controller.annuaireCount}',
                                        title: 'Annuaire',
                                        icon: Icons.group,
                                        color: Colors.yellow.shade700),
                                    DashNumberWidget(
                                        gestureTapCallback: () {
                                          Navigator.pushNamed(
                                              context,
                                              ComMarketingRoutes
                                                  .comMarketingAgenda);
                                        },
                                        number: '${controller.agendaCount}',
                                        title: 'Agenda',
                                        icon: Icons.checklist_rtl,
                                        color: Colors.teal.shade700),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                ResponsiveChildWidget(
                                    child1: CourbeVenteGainMounth(
                                        controller: controller),
                                    child2: CourbeVenteGainYear(
                                        controller: controller)),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Wrap(
                                  children: [
                                    ArticlePlusVendus(controller: controller),
                                  ],
                                )
                              ]),
                        )),
                  ))
            ],
          )),
    );
  }
}
