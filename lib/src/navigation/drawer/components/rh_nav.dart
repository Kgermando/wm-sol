import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/notify/rh_notify_controller.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_widget.dart';
import 'package:wm_solution/src/routes/routes.dart';

class RhNav extends StatefulWidget {
  const RhNav({super.key, required this.currentRoute});
  final String currentRoute;

  @override
  State<RhNav> createState() => _RhNavState();
}

class _RhNavState extends State<RhNav> {
  bool isOpen1 = false;

  @override
  Widget build(BuildContext context) {
    final RHNotifyController controller = Get.put(RHNotifyController());

    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    final bodyText1 = Theme.of(context).textTheme.bodyText1;

    print("itemCount: ${int.parse(controller.itemCount)}");

    return ExpansionTile(
      leading: const Icon(Icons.group, size: 30.0),
      title: AutoSizeText('RH', maxLines: 1, style: bodyLarge),
      initiallyExpanded: true,
      onExpansionChanged: (val) {
        setState(() {
          isOpen1 = !val;
        });
      },
      trailing: const Icon(Icons.arrow_drop_down),
      children: [
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
        DrawerWidget(
            selected: widget.currentRoute == RhRoutes.rhDD,
            icon: Icons.manage_accounts,
            sizeIcon: 20.0,
            title: 'Directeur de département',
            style: bodyText1,
            badge: Badge(
              showBadge: (int.parse(controller.itemCount) >= 1) ? true : false,
              badgeColor: Colors.teal,
              badgeContent: Text(controller.itemCount,
                  style: const TextStyle(fontSize: 10.0, color: Colors.white)),
              child: const Icon(Icons.notifications),
            ),
            onTap: () {
              Navigator.pushNamed(context, RhRoutes.rhDD);
              // Navigator.of(context).pop();
            }),
        DrawerWidget(
            selected: widget.currentRoute == RhRoutes.rhPersonnelsPage,
            icon: Icons.group,
            sizeIcon: 20.0,
            title: 'Personnels',
            style: bodyText1,
            onTap: () {
              Get.toNamed(RhRoutes.rhPersonnelsPage);
              // Navigator.of(context).pop();
            }),
        DrawerWidget(
            selected: widget.currentRoute == RhRoutes.rhPaiement,
            icon: Icons.real_estate_agent_sharp,
            sizeIcon: 20.0,
            title: 'Salaires',
            style: bodyText1,
            onTap: () {
              Get.toNamed(RhRoutes.rhPaiement);
              // Navigator.of(context).pop();
            }),
        DrawerWidget(
            selected: widget.currentRoute == RhRoutes.rhTransportRest,
            icon: Icons.restaurant,
            sizeIcon: 20.0,
            title: 'Transport & restauration | Autres frais',
            style: bodyText1,
            onTap: () {
              Get.toNamed(RhRoutes.rhTransportRest);
              // Navigator.of(context).pop();
            }),
        DrawerWidget(
            selected: widget.currentRoute == RhRoutes.rhPresence,
            icon: Icons.multiline_chart_sharp,
            sizeIcon: 20.0,
            title: 'Presences',
            style: bodyText1,
            onTap: () {
              Get.toNamed(RhRoutes.rhPresence);
              // Navigator.of(context).pop();
            }),
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
        DrawerWidget(
            selected: widget.currentRoute == ArchiveRoutes.archives,
            icon: Icons.archive,
            sizeIcon: 20.0,
            title: 'Archives',
            style: bodyLarge!,
            onTap: () {
              Navigator.pushNamed(context, ArchiveRoutes.archives);
              // Navigator.of(context).pop();
            }),
      ],
    );
  }
}

// class RhNav extends StatefulWidget {
//   const RhNav({Key? key, required this.pageCurrente, required this.user})
//       : super(key: key);
//   final String pageCurrente;
//   final UserModel user;

//   @override
//   State<RhNav> createState() => _RhNavState();
// }

// class _RhNavState extends State<RhNav> {
//   bool isOpenRh = false;
//   int itemCount = 0;

//   int salairesCount = 0;
//   int transRestCount = 0;

//   @override
//   void initState() {
//     getData();
//     super.initState();
//   }

//   @override
//   dispose() {
//     super.dispose();
//   }

//   Future<void> getData() async {
//     var notify = await RhDepartementNotifyApi().getCountRh();

//     if (mounted) {
//       setState(() {
//         itemCount = int.parse(notify.sum);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bodyLarge = Theme.of(context).textTheme.bodyLarge;
//     final bodyText1 = Theme.of(context).textTheme.bodyText1;
//     int userRole = int.parse(widget.user.role);
//     return ExpansionTile(
//       leading: const Icon(Icons.group, size: 30.0),
//       title: AutoSizeText('RH', maxLines: 1, style: bodyLarge),
//       initiallyExpanded:
//           (widget.user.departement == 'Ressources Humaines') ? true : false,
//       onExpansionChanged: (val) {
//         setState(() {
//           isOpenRh = !val;
//         });
//       },
//       trailing: const Icon(Icons.arrow_drop_down),
//       children: [
//         if (userRole <= 2)
//           DrawerWidget(
//               selected: widget.pageCurrente == RhRoutes.rhDashboard,
//               icon: Icons.dashboard,
//               sizeIcon: 20.0,
//               title: 'Dashboard',
//               style: bodyText1!,
//               onTap: () {
//                 Navigator.pushNamed(context, RhRoutes.rhDashboard);
//                 // Navigator.of(context).pop();
//               }),
//         if (userRole <= 2)
//           DrawerWidget(
//               selected: widget.pageCurrente == RhRoutes.rhDD,
//               icon: Icons.manage_accounts,
//               sizeIcon: 20.0,
//               title: 'Directeur de département',
//               style: bodyText1!,
//               badge: Badge(
//                 showBadge: (itemCount >= 1) ? true : false,
//                 badgeColor: Colors.teal,
//                 badgeContent: Text('$itemCount',
//                     style:
//                         const TextStyle(fontSize: 10.0, color: Colors.white)),
//                 child: const Icon(Icons.notifications),
//               ),
//               onTap: () {
//                 Navigator.pushNamed(context, RhRoutes.rhDD);
//                 // Navigator.of(context).pop();
//               }),
//         if (userRole <= 3)
//           DrawerWidget(
//               selected: widget.pageCurrente == RhRoutes.rhAgent,
//               icon: Icons.group,
//               sizeIcon: 20.0,
//               title: 'Personnels',
//               style: bodyText1!,
//               onTap: () {
//                 Navigator.pushNamed(context, RhRoutes.rhAgent);
//                 // Navigator.of(context).pop();
//               }),
//         if (userRole <= 3)
//           DrawerWidget(
//               selected: widget.pageCurrente == RhRoutes.rhPaiement,
//               icon: Icons.real_estate_agent_sharp,
//               sizeIcon: 20.0,
//               title: 'Paiements',
//               style: bodyText1!,
//               onTap: () {
//                 Navigator.pushNamed(context, RhRoutes.rhPaiement);
//                 // Navigator.of(context).pop();
//               }),
//         if (userRole <= 3)
//           DrawerWidget(
//               selected: widget.pageCurrente == RhRoutes.rhTransportRest,
//               icon: Icons.restaurant,
//               sizeIcon: 20.0,
//               title: 'Transport & restauration | Autres frais',
//               style: bodyText1!,
//               onTap: () {
//                 Navigator.pushNamed(context, RhRoutes.rhTransportRest);
//                 // Navigator.of(context).pop();
//               }),
//         DrawerWidget(
//             selected: widget.pageCurrente == RhRoutes.rhPresence,
//             icon: Icons.checklist_outlined,
//             sizeIcon: 20.0,
//             title: 'Présences',
//             style: bodyText1!,
//             onTap: () {
//               Navigator.pushNamed(context, RhRoutes.rhPresence);
//               // Navigator.of(context).pop();
//             }),
//         if (userRole <= 3)
//           DrawerWidget(
//               selected: widget.pageCurrente == RhRoutes.rhPerformence,
//               icon: Icons.multiline_chart_sharp,
//               sizeIcon: 20.0,
//               title: 'Performences',
//               style: bodyText1,
//               onTap: () {
//                 Navigator.pushNamed(context, RhRoutes.rhPerformence);
//                 // Navigator.of(context).pop();
//               }),
//         DrawerWidget(
//             selected: widget.pageCurrente == ArchiveRoutes.archives,
//             icon: Icons.archive,
//             sizeIcon: 20.0,
//             title: 'Archives',
//             style: bodyLarge!,
//             onTap: () {
//               Navigator.pushNamed(context, ArchiveRoutes.archives);
//               // Navigator.of(context).pop();
//             }),
//       ],
//     );
//   }
// }
