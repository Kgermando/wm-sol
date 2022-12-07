import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_widget.dart';
import 'package:wm_solution/src/routes/routes.dart';

class ActionnaireNav extends StatefulWidget {
  const ActionnaireNav(
      {super.key, required this.currentRoute, required this.departementList});
  final String currentRoute; 
  final List<dynamic> departementList;

  @override
  State<ActionnaireNav> createState() => _ActionnaireNavState();
}

class _ActionnaireNavState extends State<ActionnaireNav> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    final bodyMedium = Theme.of(context).textTheme.bodyLarge;
    final bodyText1 = Theme.of(context).textTheme.bodyMedium;
    return ExpansionTile(
      leading: const Icon(
        Icons.sensor_occupied_sharp,
        size: 30.0,
      ),
      title: AutoSizeText('Actionnaire', maxLines: 1, style: bodyMedium),
      initiallyExpanded:
          widget.departementList.contains('Actionnaire') ? true : false,
      onExpansionChanged: (val) {
        setState(() {
          isOpen = !val;
        });
      },
      trailing: const Icon(Icons.arrow_drop_down),
      children: [
        DrawerWidget(
          selected: widget.currentRoute == ActionnaireRoute.actionnaireDashboard,
          icon: Icons.dashboard,
          sizeIcon: 20.0,
          title: 'Dashboard',
          style: bodyText1!,
          onTap: () {
            Get.toNamed(ActionnaireRoute.actionnaireDashboard);
          }
        ),
        DrawerWidget(
          selected: widget.currentRoute == ActionnaireRoute.actionnairePage,
          icon: Icons.money_rounded,
          sizeIcon: 20.0,
          title: 'Actions',
          style: bodyText1, 
          onTap: () {
            Get.toNamed(ActionnaireRoute.actionnairePage);
          }),
        DrawerWidget(
            selected: widget.currentRoute == ActionnaireRoute.actionnaireCotisation,
            icon: Icons.money_rounded,
            sizeIcon: 20.0,
            title: 'Cotisations',
            style: bodyText1,
            onTap: () {
              Get.toNamed(ActionnaireRoute.actionnaireCotisation);
            }),
        DrawerWidget(
            selected:
                widget.currentRoute == ActionnaireRoute.actionnaireTransfert,
            icon: Icons.money_rounded,
            sizeIcon: 20.0,
            title: 'Transfer parts',
            style: bodyText1,
            onTap: () {
              Get.toNamed(ActionnaireRoute.actionnaireTransfert);
            }),
      ],
    );
  }
}