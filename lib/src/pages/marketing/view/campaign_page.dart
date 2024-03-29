import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/marketing/components/campaigns/table_campaigns.dart';
import 'package:wm_solution/src/pages/marketing/controller/campaigns/compaign_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/loading.dart';

class CampaignPage extends StatefulWidget {
  const CampaignPage({super.key});

  @override
  State<CampaignPage> createState() => _CampaignPageState();
}

class _CampaignPageState extends State<CampaignPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Marketing";
  String subTitle = "Campagnes";

  @override
  Widget build(BuildContext context) {
    final CampaignController controller = Get.find();
    return Scaffold(
    key: scaffoldKey,
    appBar: headerBar(context, scaffoldKey, title, subTitle),
    drawer: const DrawerMenu(),
    floatingActionButton: Responsive.isMobile(context) ? FloatingActionButton( 
        tooltip: "Créer une campagne",
        child: const Icon(Icons.add),
        onPressed: () {
          Get.toNamed(MarketingRoutes.marketingCampaignAdd);
        }) : FloatingActionButton.extended(
        label: const Text("Créer une campagne"),
        tooltip: "Créer une campagne",
        icon: const Icon(Icons.add),
        onPressed: () {
          Get.toNamed(MarketingRoutes.marketingCampaignAdd);
        }),
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
        (data) => Container(
              margin: const EdgeInsets.only(
                  top: p20, right: p20, left: p20, bottom: p8),
              decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(20))),
              child: GetBuilder(builder: (CampaignController controller) => TableCampaign(
                  campaignList: controller.campaignList,
                  controller: controller)) )) ),
              ],
            )
            
            )
    
    
    ;
  }
}
