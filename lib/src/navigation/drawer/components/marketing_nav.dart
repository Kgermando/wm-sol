
import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/controllers/departement_notify_controller.dart';
import 'package:wm_solution/src/models/users/user_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_widget.dart';  
import 'package:wm_solution/src/routes/routes.dart';

class MaketingNav extends StatefulWidget {
  const MaketingNav(
      {super.key,
      required this.currentRoute,
      required this.user,
      required this.departementList,
      required this.controller});
  final String currentRoute;
  final UserModel user;
  final List<dynamic> departementList;
  final DepartementNotifyCOntroller controller;

  @override
  State<MaketingNav> createState() => _MaketingNavState();
}

class _MaketingNavState extends State<MaketingNav> { 
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {  
    final bodyMedium = Theme.of(context).textTheme.bodyLarge;
    final bodyText1 = Theme.of(context).textTheme.bodyMedium; 
    int userRole = int.parse(widget.user.role);

    return ExpansionTile(
      leading: const Icon(Icons.campaign, size: 30.0),
      title:
          AutoSizeText('Marketing', maxLines: 1, style: bodyMedium),
      initiallyExpanded:
        widget.departementList.contains('Marketing')
              ? true
              : false,
      onExpansionChanged: (val) {
        setState(() {
          isOpen = !val;
        });
      },
      trailing: const Icon(Icons.arrow_drop_down),
      children: [
        if (userRole <= 2)
          DrawerWidget(
              selected: widget.currentRoute ==
                  MarketingRoutes.marketingDashboard,
              icon: Icons.dashboard,
              sizeIcon: 20.0,
              title: 'Dashboard',
              style: bodyText1!,
              onTap: () {
                Get.toNamed(MarketingRoutes.marketingDashboard);
              }),
        if (userRole <= 2)
          DrawerWidget(
              selected:
                  widget.currentRoute == MarketingRoutes.marketingDD,
              icon: Icons.manage_accounts,
              sizeIcon: 20.0,
              title: 'Directeur de departement',
              style: bodyText1!,
              badge: Badge(
                showBadge:
                    (int.parse(widget.controller.itemMarketingCount) >= 1) ? true : false,
                badgeColor: Colors.teal,
                badgeContent:Obx(() => Text(widget.controller.itemMarketingCount,
                    style:
                        const TextStyle(fontSize: 10.0, color: Colors.white))) ,
                child: const Icon(Icons.notifications),
              ),
              onTap: () {
                Get.toNamed(MarketingRoutes.marketingDD); 
              }),
        DrawerWidget(
            selected:
                widget.currentRoute == MarketingRoutes.marketingAnnuaire,
            icon: Icons.arrow_right,
            sizeIcon: 15.0,
            title: 'Annuaire',
            style: bodyText1!,
            onTap: () {
              Get.toNamed(MarketingRoutes.marketingAnnuaire);
            }),
        DrawerWidget(
            selected:
                widget.currentRoute == MarketingRoutes.marketingAgenda,
            icon: Icons.arrow_right,
            sizeIcon: 15.0,
            title: 'Agenda',
            style: bodyText1,
            onTap: () {
              Get.toNamed(MarketingRoutes.marketingAgenda);
            }),
        if (userRole <= 3)
          DrawerWidget(
              selected: widget.currentRoute ==
                  MarketingRoutes.marketingCampaign,
              icon: Icons.arrow_right,
              sizeIcon: 15.0,
              title: 'Campagnes',
              style: bodyText1,
              onTap: () {
                Get.toNamed(MarketingRoutes.marketingCampaign);
                // Navigator.of(context).pop();
              }),
        DrawerWidget(
            selected: widget.currentRoute == TacheRoutes.tachePage,
            icon: Icons.arrow_right,
            sizeIcon: 15.0,
            title: 'Tâches',
            style: bodyText1,
            onTap: () {
              Get.toNamed(TacheRoutes.tachePage);
            }),
         
      ],
    );
  }
}
