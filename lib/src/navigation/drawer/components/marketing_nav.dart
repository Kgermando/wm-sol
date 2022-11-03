
import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_widget.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/notify/notify_comptabilite.dart';
import 'package:wm_solution/src/routes/routes.dart';

class MaketingNav extends StatefulWidget {
  const MaketingNav({super.key, required this.currentRoute, required this.profilController, required this.departement});
  final String currentRoute;
  final ProfilController profilController;
  final List<dynamic> departement;

  @override
  State<MaketingNav> createState() => _MaketingNavState();
}

class _MaketingNavState extends State<MaketingNav> {
      final ComptabiliteNotifyController controller =
      Get.put(ComptabiliteNotifyController());
  bool isOpen = false; 

  @override
  Widget build(BuildContext context) {  
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    final bodyText1 = Theme.of(context).textTheme.bodyText1;
    final bodyText2 = Theme.of(context).textTheme.bodyText2; 
    int userRole = int.parse(widget.profilController.user.role);
    return ExpansionTile(
      leading: const Icon(Icons.campaign, size: 30.0),
      title:
          AutoSizeText('Marketing', maxLines: 2, style: bodyLarge),
      initiallyExpanded:
          (widget.departement.first == 'Marketing')
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
                    (int.parse(controller.itemCount) >= 1) ? true : false,
                badgeColor: Colors.teal,
                badgeContent: Text(controller.itemCount,
                    style:
                        const TextStyle(fontSize: 10.0, color: Colors.white)),
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
            style: bodyText2!,
            onTap: () {
              Get.toNamed(MarketingRoutes.marketingAnnuaire);
            }),
        DrawerWidget(
            selected:
                widget.currentRoute == MarketingRoutes.marketingAgenda,
            icon: Icons.arrow_right,
            sizeIcon: 15.0,
            title: 'Agenda',
            style: bodyText2,
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
              style: bodyText2,
              onTap: () {
                Get.toNamed(MarketingRoutes.marketingCampaign);
                // Navigator.of(context).pop();
              }),
        DrawerWidget(
            selected: widget.currentRoute == TacheRoutes.tachePage,
            icon: Icons.arrow_right,
            sizeIcon: 15.0,
            title: 'Tâches',
            style: bodyText2,
            onTap: () {
              Get.toNamed(TacheRoutes.tachePage);
            }),
        if (userRole <= 3)
          DrawerWidget(
              selected: widget.currentRoute == RhRoutes.rhPerformence,
              icon: Icons.multiline_chart_sharp,
              sizeIcon: 20.0,
              title: 'Performences',
              style: bodyText1!,
              onTap: () {
                Get.toNamed(RhRoutes.rhPerformence);  
              }),
        DrawerWidget(
            selected: widget.currentRoute == ArchiveRoutes.archives,
            icon: Icons.archive,
            sizeIcon: 20.0,
            title: 'Archives',
            style: bodyLarge!,
            onTap: () {
              Get.toNamed(ArchiveRoutes.archives);  
            }),
      ],
    );
  }
}
