import 'package:flutter/material.dart'; 
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/personnels_controller.dart';

class DashboardRH extends StatefulWidget {
  const DashboardRH({Key? key}) : super(key: key);

  @override
  State<DashboardRH> createState() => _DashboardRHState();
}

class _DashboardRHState extends State<DashboardRH> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Ressources Humaines";
  String subTitle = "Dashboard";

  @override
  Widget build(BuildContext context) {
    final PersonnelsController controller = Get.put(PersonnelsController()); 

    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: headerBar(context, scaffoldKey, title, subTitle),
        drawer: const DrawerMenu(),
        body: controller.obx((data) => Row(
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Dashboard",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge)
                      ]
                    ),
                    )
                ),
            ))
          ],
        )),
      ),
    );
  }
}