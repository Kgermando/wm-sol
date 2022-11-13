
import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_widget.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/notify/notify_comptabilite.dart';
import 'package:wm_solution/src/routes/routes.dart';

class ComptabiliteNav extends StatefulWidget {
  const ComptabiliteNav({super.key, required this.currentRoute, required this.profilController, required this.departement});
  final String currentRoute;
  final ProfilController profilController;
  final List<dynamic> departement;

  @override
  State<ComptabiliteNav> createState() => _ComptabiliteNavState();
}

class _ComptabiliteNavState extends State<ComptabiliteNav> {
   final ComptabiliteNotifyController comptabiliteNotifyController = Get.find();
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {  
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final bodyText1 = Theme.of(context).textTheme.bodyText1;
    final bodyText2 = Theme.of(context).textTheme.bodyText2; 
    int userRole = int.parse(widget.profilController.user.role);
    return ExpansionTile(
      leading: const Icon(Icons.table_view, size: 30.0),
      title: AutoSizeText('Comptabilités', maxLines: 1, style: bodyMedium),
      initiallyExpanded:
          (widget.departement.first == 'Comptabilites') ? true : false,
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
                  ComptabiliteRoutes.comptabiliteDashboard,
              icon: Icons.dashboard,
              sizeIcon: 20.0,
              title: 'Dashboard',
              style: bodyText1!,
              onTap: () {
                Get.toNamed(ComptabiliteRoutes.comptabiliteDashboard);  
                // Navigator.of(context).pop();
              }),
        if (userRole <= 2)
          DrawerWidget(
              selected:
                  widget.currentRoute == ComptabiliteRoutes.comptabiliteDD,
              icon: Icons.manage_accounts,
              sizeIcon: 15.0,
              title: 'Directeur departement',
              style: bodyText2!,
              badge: Badge(
                showBadge: (int.parse(comptabiliteNotifyController.itemCount) >= 1) ? true : false,
                badgeColor: Colors.teal,
                badgeContent: Obx(() => Text(comptabiliteNotifyController.itemCount,
                    style:
                        const TextStyle(fontSize: 10.0, color: Colors.white))) ,
                child: const Icon(Icons.notifications),
              ),
              onTap: () {
                Get.toNamed(ComptabiliteRoutes.comptabiliteDD); 
                // Navigator.of(context).pop();
              }),
        DrawerWidget(
            selected:
                widget.currentRoute == ComptabiliteRoutes.comptabiliteBalance,
            icon: Icons.arrow_right,
            sizeIcon: 15.0,
            title: 'Balance',
            style: bodyText2!,
            onTap: () {
              Get.toNamed(ComptabiliteRoutes.comptabiliteBalance); 
              // Navigator.of(context).pop();
            }),
        DrawerWidget(
            selected:
                widget.currentRoute == ComptabiliteRoutes.comptabiliteBilan,
            icon: Icons.arrow_right,
            sizeIcon: 15.0,
            title: 'Bilan',
            style: bodyText2,
            onTap: () {
              Get.toNamed(ComptabiliteRoutes.comptabiliteBilan); 
              // Navigator.of(context).pop();
            }),
        DrawerWidget(
            selected: widget.currentRoute ==
                ComptabiliteRoutes.comptabiliteCompteResultat,
            icon: Icons.arrow_right,
            sizeIcon: 15.0,
            title: 'Compte resultats',
            style: bodyText2,
            onTap: () {
              Get.toNamed(ComptabiliteRoutes.comptabiliteCompteResultat); 
              // Navigator.of(context).pop();
            }),
        DrawerWidget(
            selected: widget.currentRoute ==
                ComptabiliteRoutes.comptabiliteGrandLivre,
            icon: Icons.arrow_right,
            sizeIcon: 15.0,
            title: 'Grand livre',
            style: bodyText2,
            onTap: () {
              Get.toNamed(ComptabiliteRoutes.comptabiliteGrandLivre); 
              // Navigator.of(context).pop();
            }),
        DrawerWidget(
            selected: widget.currentRoute ==
                ComptabiliteRoutes.comptabiliteJournalLivre,
            icon: Icons.arrow_right,
            sizeIcon: 15.0,
            title: 'Journal',
            style: bodyText2,
            onTap: () {
              Get.toNamed(ComptabiliteRoutes.comptabiliteJournalLivre);   
              // Navigator.of(context).pop();
            }), 
        DrawerWidget(
            selected: widget.currentRoute == RhRoutes.rhPerformence,
            icon: Icons.multiline_chart_sharp,
            sizeIcon: 20.0,
            title: 'Performences',
            style: bodyText1!,
            onTap: () {
              Get.toNamed(RhRoutes.rhPerformence);  
              // Navigator.of(context).pop();
            }),
        DrawerWidget(
            selected:
                widget.currentRoute == LogistiqueRoutes.logApprovisionReception,
            icon: Icons.handyman,
            sizeIcon: 20.0,
            title: 'Acc. Reception',
            style: bodyText1,
            onTap: () {
              Get.toNamed(LogistiqueRoutes.logApprovisionReception);
              // Navigator.of(context).pop();
            }),
        DrawerWidget(
            selected: widget.currentRoute == ArchiveRoutes.archives,
            icon: Icons.archive,
            sizeIcon: 20.0,
            title: 'Archives',
            style: bodyMedium!,
            onTap: () {
              Get.toNamed(ArchiveRoutes.archives); 
              // Navigator.of(context).pop();
            }),
      ],
    );
  }
}
