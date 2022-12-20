
import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/controllers/departement_notify_controller.dart';
import 'package:wm_solution/src/models/users/user_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_widget.dart';  
import 'package:wm_solution/src/routes/routes.dart';

class LogistiqueNav extends StatefulWidget {
  const LogistiqueNav(
      {super.key, required this.currentRoute, required this.user, required this.departementList, required this.controller});
  final String currentRoute;
  final UserModel user;
  final List<dynamic> departementList;
  final DepartementNotifyCOntroller controller;

  @override
  State<LogistiqueNav> createState() => _LogistiqueNavState();
}

class _LogistiqueNavState extends State<LogistiqueNav> {
   
  bool isOpen = false;
  bool isOpen1 = false;
  bool isOpen2 = false;
  bool isOpen3 = false; 

  @override
  Widget build(BuildContext context) {
   final bodyMedium = Theme.of(context).textTheme.bodyLarge;
    final bodyText1 = Theme.of(context).textTheme.bodyMedium; 
    int userRole = int.parse(widget.user.role);
    
    return ExpansionTile(
      leading: const Icon(Icons.brightness_low, size: 30.0),
      title: AutoSizeText('Logistique', maxLines: 1, style: bodyMedium),
      initiallyExpanded:
        widget.departementList.contains('Logistique')
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
              badge: Obx(() => Badge(
                showBadge: (int.parse(widget.controller.itemLogCount) >= 1) ? true : false,
                badgeColor: Colors.teal,
                badgeContent: Obx(() => Text(widget.controller.itemLogCount,
                    style:
                        const TextStyle(fontSize: 10.0, color: Colors.white))),
                child: const Icon(Icons.notifications),
              )) ,
              onTap: () {
                Navigator.pushNamed(context, LogistiqueRoutes.logDD);
                // Navigator.of(context).pop();
              }),
        DrawerWidget(
            selected:
                widget.currentRoute == LogistiqueRoutes.logImmobilierMateriel,
            icon: Icons.store,
            sizeIcon: 20.0,
            title: 'Immobiliers',
            style: bodyText1!,
            onTap: () {
              Navigator.pushNamed(
                  context, LogistiqueRoutes.logImmobilierMateriel);
            }),
        DrawerWidget(
          selected:
              widget.currentRoute == LogistiqueRoutes.logMobilierMateriel,
          icon: Icons.chair_alt,
          sizeIcon: 20.0,
          title: 'Mobiliers',
          style: bodyText1,
          onTap: () {
            Navigator.pushNamed(
                context, LogistiqueRoutes.logMobilierMateriel);
          }),
        DrawerWidget(
            selected: widget.currentRoute == LogistiqueRoutes.logMateriel,
            icon: Icons.car_crash,
            sizeIcon: 20.0,
            title: 'Matieriels',
            style: bodyText1  ,
            onTap: () {
              Navigator.pushNamed(context, LogistiqueRoutes.logMateriel); 
            }),
        DrawerWidget(
            selected: widget.currentRoute == LogistiqueRoutes.logMaterielRoulant,
            icon: Icons.car_crash,
            sizeIcon: 20.0,
            title: 'Matieriels roulant',
            style: bodyText1,
            onTap: () {
              Navigator.pushNamed(context, LogistiqueRoutes.logMaterielRoulant); 
            }),
        DrawerWidget(
          selected: widget.currentRoute == LogistiqueRoutes.logTrajetAuto,
          icon: Icons.place,
          sizeIcon: 20.0,
          title: 'Trajets',
          style: bodyText1,
          onTap: () {
            Navigator.pushNamed(context, LogistiqueRoutes.logTrajetAuto); 
          }
        ), 
        DrawerWidget(
            selected:
                widget.currentRoute == LogistiqueRoutes.logEtatMateriel,
            icon: Icons.settings_suggest,
            sizeIcon: 20.0,
            title: 'Etat materiels',
            style: bodyText1,
            onTap: () {
              Navigator.pushNamed(
                  context, LogistiqueRoutes.logEtatMateriel);
            }),
        DrawerWidget(
          selected: widget.currentRoute == LogistiqueRoutes.logEntretien,
          icon: Icons.settings,
          sizeIcon: 20.0,
          title: 'Entretiens',
          style: bodyText1,
          onTap: () {
            Navigator.pushNamed(context, LogistiqueRoutes.logEntretien);
          }), 
        if (userRole <= 3)
        DrawerWidget(
            selected:
                widget.currentRoute == LogistiqueRoutes.logApprovisionnement,
            icon: Icons.production_quantity_limits,
            sizeIcon: 20.0,
            title: 'Matières & fournitures',
            style: bodyText1,
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
       
      ],
    );
  }
}
