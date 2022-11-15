import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/notify/rh_notify_controller.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_widget.dart';
import 'package:wm_solution/src/routes/routes.dart';

class RhNav extends StatefulWidget {
  const RhNav({super.key, required this.currentRoute, required this.profilController, required this.departement});
  final String currentRoute;
  final ProfilController profilController;
  final String departement;

  @override
  State<RhNav> createState() => _RhNavState();
}

class _RhNavState extends State<RhNav> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) { 
    final RHNotifyController controller = Get.find();

    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final bodyText1 = Theme.of(context).textTheme.bodyText1;  
    int userRole = int.parse(widget.profilController.user.role);

    return ExpansionTile(
      leading: const Icon(Icons.group, size: 30.0),
      title: AutoSizeText('RH', maxLines: 1, style: bodyMedium),
      initiallyExpanded: (widget.departement == 'Ressources Humaines') ? true : false,
      onExpansionChanged: (val) {
        setState(() {
          isOpen = !val;
        });
      },
      trailing: const Icon(Icons.arrow_drop_down),
      children: [
        if (userRole <= 2)
        DrawerWidget(
            selected: widget.currentRoute == RhRoutes.rhDashboard,
            icon: Icons.dashboard,
            sizeIcon: 20.0,
            title: 'Dashboard',
            style: bodyText1!,
            onTap: () {
              Get.toNamed(RhRoutes.rhDashboard);
              // Navigator.of(context).pop();
            }),
          if (userRole <= 2)
        DrawerWidget(
            selected: widget.currentRoute == RhRoutes.rhDD,
            icon: Icons.manage_accounts,
            sizeIcon: 20.0,
            title: 'Directeur de département',
            style: bodyText1!,
            badge: Badge(
              showBadge: (int.parse(controller.itemCount) >= 1) ? true : false,
              badgeColor: Colors.teal,
              badgeContent:Obx(() => Text(controller.itemCount,
                  style: const TextStyle(fontSize: 10.0, color: Colors.white))) ,
              child: const Icon(Icons.notifications),
            ),
            onTap: () {
              Navigator.pushNamed(context, RhRoutes.rhDD);
              // Navigator.of(context).pop();
            }),
        if (userRole <= 3)
        DrawerWidget(
            selected: widget.currentRoute == RhRoutes.rhPersonnelsPage,
            icon: Icons.group,
            sizeIcon: 20.0,
            title: 'Personnels',
            style: bodyText1!,
            onTap: () {
              Get.toNamed(RhRoutes.rhPersonnelsPage);
              // Navigator.of(context).pop();
            }),
        if (userRole <= 3)
        DrawerWidget(
            selected: widget.currentRoute == RhRoutes.rhPaiement,
            icon: Icons.real_estate_agent_sharp,
            sizeIcon: 20.0,
            title: 'Salaires',
            style: bodyText1!,
            onTap: () {
              Get.toNamed(RhRoutes.rhPaiement);
              // Navigator.of(context).pop();
            }),
        if (userRole <= 3)
        DrawerWidget(
            selected: widget.currentRoute == RhRoutes.rhTransportRest,
            icon: Icons.restaurant,
            sizeIcon: 20.0,
            title: 'Transt. & Rest. | Autres frais',
            style: bodyText1!,
            onTap: () {
              Get.toNamed(RhRoutes.rhTransportRest);
              // Navigator.of(context).pop();
            }),
        DrawerWidget(
            selected: widget.currentRoute == RhRoutes.rhPresence,
            icon: Icons.multiline_chart_sharp,
            sizeIcon: 20.0,
            title: 'Presences',
            style: bodyText1!,
            onTap: () {
              Get.toNamed(RhRoutes.rhPresence);
              // Navigator.of(context).pop();
            }),
        if (userRole <= 3)
        DrawerWidget(
            selected: widget.currentRoute == RhRoutes.rhPerformence,
            icon: Icons.checklist_outlined,
            sizeIcon: 20.0,
            title: 'Performences',
            style: bodyText1,
            onTap: () {
              Get.toNamed(RhRoutes.rhPerformence);
              // Navigator.of(context).pop();
            }),
        if (userRole <= 3)
        DrawerWidget(
            selected:
                widget.currentRoute == LogistiqueRoutes.logApprovisionReception,
            icon: Icons.multiline_chart_sharp,
            sizeIcon: 20.0,
            title: 'Acc. Reception',
            style: bodyText1,
            onTap: () {
              Get.toNamed(LogistiqueRoutes.logApprovisionReception);
            }),
        DrawerWidget(
            selected: widget.currentRoute == ArchiveRoutes.archives,
            icon: Icons.archive,
            sizeIcon: 20.0,
            title: 'Archives',
            style: bodyMedium!,
            onTap: () {
              Navigator.pushNamed(context, ArchiveRoutes.archives);
              // Navigator.of(context).pop();
            }),
      ],
    );
  }
}
