import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/marketing/components/dashboard/dash_pie_wdget.dart';
import 'package:wm_solution/src/pages/marketing/controller/annuaire/annuaire_pie_controller.dart';
import 'package:wm_solution/src/pages/marketing/controller/dahboard/dashboard_marketing_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/dashboard/calendar_widget.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/dash_number_widget.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';

class DashboardMarketingPage extends StatefulWidget {
  const DashboardMarketingPage({super.key});

  @override
  State<DashboardMarketingPage> createState() => _DashboardMarketingPageState();
}

class _DashboardMarketingPageState extends State<DashboardMarketingPage> {
  final DashboardMarketingController controller =
      Get.put(DashboardMarketingController());
  final AnnuairePieController annuairePieController = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Marketing";
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
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: p20),
                        child: Obx(() => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    alignment: WrapAlignment.spaceEvenly,
                                    children: [
                                      DashNumberWidget(
                                          gestureTapCallback: () {
                                            Get.toNamed(MarketingRoutes
                                                .marketingCampaign);
                                          },
                                          number: '${controller.campaignCount}',
                                          title: 'Campagnes',
                                          icon: Icons.campaign,
                                          color: Colors.orange.shade700),
                                      DashNumberWidget(
                                          gestureTapCallback: () {
                                            Get.toNamed(MarketingRoutes
                                                .marketingAnnuaire);
                                          },
                                          number: '${controller.annuaireCount}',
                                          title: 'Annuaire',
                                          icon: Icons.group,
                                          color: Colors.yellow.shade700),
                                      DashNumberWidget(
                                          gestureTapCallback: () {
                                            Navigator.pushNamed(
                                                context,
                                                MarketingRoutes
                                                    .marketingAgenda);
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
                                      child1: DashMarketingPieWidget(
                                          controller: annuairePieController),
                                      child2: const CalendarWidget()),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                ])),
                      )),
                ))
          ],
        ));
  }
}
