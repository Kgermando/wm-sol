import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/controllers/departement_notify_controller.dart';
import 'package:wm_solution/src/models/users/user_model.dart';  
import 'package:wm_solution/src/navigation/drawer/drawer_widget.dart';
import 'package:wm_solution/src/routes/routes.dart';

class RhNav extends StatefulWidget {
  const RhNav(
      {super.key,
      required this.currentRoute,
      required this.user,
      required this.departementList, required this.controller});
  final String currentRoute;
  final UserModel user;
  final List<dynamic> departementList;
  final DepartementNotifyCOntroller controller;

  @override
  State<RhNav> createState() => _RhNavState();
}

class _RhNavState extends State<RhNav> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {  

   final bodyMedium = Theme.of(context).textTheme.bodyLarge;
    final bodyText1 = Theme.of(context).textTheme.bodyMedium; 
    
    int userRole = int.parse(widget.user.role);

    return ExpansionTile(
      leading: const Icon(Icons.group, size: 30.0),
      title: AutoSizeText('RH', maxLines: 1, style: bodyMedium),
      initiallyExpanded: 
        widget.departementList.contains('Ressources Humaines') 
          ? true : false,
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
              
            }),
          if (userRole <= 2)
        DrawerWidget(
            selected: widget.currentRoute == RhRoutes.rhDD,
            icon: Icons.manage_accounts,
            sizeIcon: 20.0,
            title: 'Directeur de département',
            style: bodyText1!,
            badge: Badge(
              showBadge: (int.parse(widget.controller.itemRHCount) >= 1) ? true : false,
              badgeColor: Colors.teal,
              badgeContent:Obx(() => Text(widget.controller.itemRHCount,
                  style: const TextStyle(fontSize: 10.0, color: Colors.white))) ,
              child: const Icon(Icons.notifications),
            ),
            onTap: () {
              Navigator.pushNamed(context, RhRoutes.rhDD);
              
            }),
        if (userRole <= 4)
        DrawerWidget(
            selected: widget.currentRoute == RhRoutes.rhPersonnelsPage,
            icon: Icons.group,
            sizeIcon: 20.0,
            title: 'Personnels',
            style: bodyText1!,
            onTap: () {
              Get.toNamed(RhRoutes.rhPersonnelsPage);
              
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
              
            }),
        if (userRole <= 5)
        DrawerWidget(
            selected: widget.currentRoute == RhRoutes.rhTransportRest,
            icon: Icons.restaurant,
            sizeIcon: 20.0,
            title: 'Transt. & Rest. | Autres frais',
            style: bodyText1!,
            onTap: () {
              Get.toNamed(RhRoutes.rhTransportRest);
              
            }),
        DrawerWidget(
          selected: widget.currentRoute == RhRoutes.rhPresence,
          icon: Icons.multiline_chart_sharp,
          sizeIcon: 20.0,
          title: 'Presences',
          style: bodyText1!,
          onTap: () {
            Get.toNamed(RhRoutes.rhPresence);
            
          }),  
      ],
    );
  }
}
