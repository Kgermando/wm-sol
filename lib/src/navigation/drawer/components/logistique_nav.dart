import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_widget.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/notify/notify_log.dart';
import 'package:wm_solution/src/routes/routes.dart';

class LogistiqueNav extends StatefulWidget {
  const LogistiqueNav(
      {super.key, required this.currentRoute, required this.profilController});
  final String currentRoute;
  final ProfilController profilController;

  @override
  State<LogistiqueNav> createState() => _LogistiqueNavState();
}

class _LogistiqueNavState extends State<LogistiqueNav> {
  final NotifyLogController notifyLogController = Get.put(NotifyLogController());
  bool isOpen = false;
  bool isOpen1 = false;
  bool isOpen2 = false;
  bool isOpen3 = false;

  @override
  Widget build(BuildContext context) {
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    final bodyText1 = Theme.of(context).textTheme.bodyText1;
    final bodyText2 = Theme.of(context).textTheme.bodyText2;
    int userRole = int.parse(widget.profilController.user.role);
    return ExpansionTile(
      leading: const Icon(Icons.brightness_low, size: 30.0),
      title: AutoSizeText('Logistique', maxLines: 1, style: bodyLarge),
      initiallyExpanded:
          (widget.profilController.user.departement == 'Logistique')
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
              selected: widget.currentRoute == LogistiqueRoutes.logDashboard,
              icon: Icons.dashboard,
              sizeIcon: 20.0,
              title: 'Dashboard',
              style: bodyText1!,
              onTap: () {
                Navigator.pushNamed(context, LogistiqueRoutes.logDashboard);
                // Navigator.of(context).pop();
              }),
        if (userRole <= 2)
          DrawerWidget(
              selected: widget.currentRoute == LogistiqueRoutes.logDD,
              icon: Icons.manage_accounts,
              sizeIcon: 20.0,
              title: 'Directeur de departement',
              style: bodyText1!,
              badge: Badge(
                showBadge: (int.parse(notifyLogController.itemCount) >= 1) ? true : false,
                badgeColor: Colors.teal,
                badgeContent: Text(notifyLogController.itemCount,
                    style:
                        const TextStyle(fontSize: 10.0, color: Colors.white)),
                child: const Icon(Icons.notifications),
              ),
              onTap: () {
                Navigator.pushNamed(context, LogistiqueRoutes.logDD);
                // Navigator.of(context).pop();
              }),
        ExpansionTile(
          leading: const Icon(Icons.car_rental, size: 20.0),
          title: Text('Automobile', style: bodyText1),
          initiallyExpanded: false,
          onExpansionChanged: (val) {
            setState(() {
              isOpen1 = !val;
            });
          },
          children: [
            DrawerWidget(
                selected: widget.currentRoute == LogistiqueRoutes.logAnguinAuto,
                icon: Icons.arrow_right,
                sizeIcon: 15.0,
                title: 'Angins',
                style: bodyText2!,
                onTap: () {
                  Navigator.pushNamed(context, LogistiqueRoutes.logAnguinAuto);
                  // Navigator.of(context).pop();
                }),
            DrawerWidget(
                selected:
                    widget.currentRoute == LogistiqueRoutes.logCarburantAuto,
                icon: Icons.arrow_right,
                sizeIcon: 15.0,
                title: 'Carburant',
                style: bodyText2,
                onTap: () {
                  Navigator.pushNamed(
                      context, LogistiqueRoutes.logCarburantAuto);
                  // Navigator.of(context).pop();
                }),
            DrawerWidget(
                selected: widget.currentRoute == LogistiqueRoutes.logTrajetAuto,
                icon: Icons.arrow_right,
                sizeIcon: 15.0,
                title: 'Trajets',
                style: bodyText2,
                onTap: () {
                  Navigator.pushNamed(context, LogistiqueRoutes.logTrajetAuto);
                  // Navigator.of(context).pop();
                }),
          ],
        ),
        ExpansionTile(
          leading: const Icon(Icons.laptop_windows, size: 20.0),
          title: Text('Materiels', style: bodyText1),
          initiallyExpanded: false,
          onExpansionChanged: (val) {
            setState(() {
              isOpen2 = !val;
            });
          },
          children: [
            DrawerWidget(
                selected:
                    widget.currentRoute == LogistiqueRoutes.logMobilierMateriel,
                icon: Icons.arrow_right,
                sizeIcon: 15.0,
                title: 'Mobiliers',
                style: bodyText2,
                onTap: () {
                  Get.toNamed(LogistiqueRoutes.logMobilierMateriel);
                }),
            DrawerWidget(
                selected: widget.currentRoute ==
                    LogistiqueRoutes.logImmobilierMateriel,
                icon: Icons.arrow_right,
                sizeIcon: 15.0,
                title: 'Immobiliers',
                style: bodyText2,
                onTap: () {
                  Get.toNamed(LogistiqueRoutes.logImmobilierMateriel);
                }),
            DrawerWidget(
                selected:
                    widget.currentRoute == LogistiqueRoutes.logEtatMateriel,
                icon: Icons.arrow_right,
                sizeIcon: 15.0,
                title: 'Etat materiels',
                style: bodyText2,
                onTap: () {
                  Get.toNamed(LogistiqueRoutes.logEtatMateriel);
                }),
          ],
        ),
        ExpansionTile(
          leading: const Icon(Icons.settings, size: 20.0),
          title: Text('Entretiens & Maintenance', style: bodyText1),
          initiallyExpanded: false,
          onExpansionChanged: (val) {
            setState(() {
              isOpen3 = !val;
            });
          },
          children: [
            DrawerWidget(
                selected: widget.currentRoute == LogistiqueRoutes.logEntretien,
                icon: Icons.arrow_right,
                sizeIcon: 15.0,
                title: 'Entretiens',
                style: bodyText2,
                onTap: () {
                  Get.toNamed(LogistiqueRoutes.logEntretien);
                }),
          ],
        ),
        DrawerWidget(
            selected:
                widget.currentRoute == LogistiqueRoutes.logApprovisionnement,
            icon: Icons.production_quantity_limits,
            sizeIcon: 20.0,
            title: 'Matières & fournitures',
            style: bodyText1!,
            onTap: () {
              Get.toNamed(LogistiqueRoutes.logApprovisionnement);
            }),
        DrawerWidget(
            selected: widget.currentRoute == DevisRoutes.devis,
            icon: Icons.content_paste,
            sizeIcon: 20.0,
            title: 'Devis',
            style: bodyText1,
            onTap: () {
              Get.toNamed(DevisRoutes.devis);
            }),
        DrawerWidget(
            selected: widget.currentRoute == RhRoutes.rhPerformence,
            icon: Icons.multiline_chart_sharp,
            sizeIcon: 20.0,
            title: 'Performences',
            style: bodyText1,
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
