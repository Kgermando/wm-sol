import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/controllers/departement_notify_controller.dart';
import 'package:wm_solution/src/models/users/user_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_widget.dart';
import 'package:wm_solution/src/pages/administration/controller/admin_dashboard_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';

class AdministrationNav extends StatefulWidget {
  const AdministrationNav(
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
  State<AdministrationNav> createState() => _AdministrationNavState();
}

class _AdministrationNavState extends State<AdministrationNav> {
  final AdminDashboardController adminDashboardController = Get.find();
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    final bodyMedium = Theme.of(context).textTheme.bodyLarge;
    final bodyText1 = Theme.of(context).textTheme.bodyMedium;
    return ExpansionTile(
      leading: const Icon(
        Icons.admin_panel_settings,
        size: 30.0,
      ),
      title: AutoSizeText('Administration', maxLines: 1, style: bodyMedium),
      initiallyExpanded:
          widget.departementList.contains('Administration') ? true : false,
      onExpansionChanged: (val) {
        setState(() {
          isOpen = !val;
        });
      },
      trailing: const Icon(Icons.arrow_drop_down),
      children: [
        DrawerWidget(
            selected: widget.currentRoute == AdminRoutes.adminDashboard,
            icon: Icons.dashboard,
            sizeIcon: 20.0,
            title: 'Dashboard',
            style: bodyText1!,
            onTap: () {
              adminDashboardController.getData();
              Get.toNamed(AdminRoutes.adminDashboard);
            }),
        DrawerWidget(
            selected: widget.currentRoute == AdminRoutes.adminBudget,
            icon: Icons.fact_check,
            sizeIcon: 20.0,
            title: 'Budgets',
            style: bodyText1,
            badge: Badge(
              showBadge: (widget.controller.budgetCount >= 1) ? true : false,
              badgeColor: Colors.teal,
              badgeContent: Obx(() => Text('${widget.controller.budgetCount}',
                  style: const TextStyle(fontSize: 10.0, color: Colors.white))),
              child: const Icon(Icons.notifications),
            ),
            onTap: () {
              Get.toNamed(AdminRoutes.adminBudget);
            }),
        DrawerWidget(
            selected: widget.currentRoute == AdminRoutes.adminFinance,
            icon: Icons.account_balance,
            sizeIcon: 20.0,
            title: 'Finances',
            style: bodyText1,
            badge: Badge(
              showBadge: (widget.controller.financeCount >= 1) ? true : false,
              badgeColor: Colors.teal,
              badgeContent: Obx(() => Text('${widget.controller.financeCount}',
                  style: const TextStyle(fontSize: 10.0, color: Colors.white))),
              child: const Icon(Icons.notifications),
            ),
            onTap: () {
              Get.toNamed(AdminRoutes.adminFinance);
            }),
        DrawerWidget(
            selected: widget.currentRoute == AdminRoutes.adminRH,
            icon: Icons.group,
            sizeIcon: 20.0,
            title: 'RH',
            style: bodyText1,
            badge: Badge(
              showBadge: (widget.controller.rhCount >= 1) ? true : false,
              badgeColor: Colors.teal,
              badgeContent: Obx(() => Text('${widget.controller.rhCount}',
                  style: const TextStyle(fontSize: 10.0, color: Colors.white))),
              child: const Icon(Icons.notifications),
            ),
            onTap: () {
              Get.toNamed(AdminRoutes.adminRH);
            }),
        DrawerWidget(
            selected: widget.currentRoute == AdminRoutes.adminExploitation,
            icon: Icons.work,
            sizeIcon: 20.0,
            title: 'Exploitations',
            style: bodyText1,
            badge: Badge(
              showBadge:
                  (widget.controller.exploitationCount >= 1) ? true : false,
              badgeColor: Colors.teal,
              badgeContent: Obx(() => Text(
                  '${widget.controller.exploitationCount}',
                  style: const TextStyle(fontSize: 10.0, color: Colors.white))),
              child: const Icon(Icons.notifications),
            ),
            onTap: () {
              Get.toNamed(AdminRoutes.adminExploitation);
            }),
        DrawerWidget(
            selected: widget.currentRoute == AdminRoutes.adminMarketing,
            icon: Icons.add_business,
            sizeIcon: 20.0,
            title: 'Marketing',
            style: bodyText1,
            badge: Badge(
              showBadge: (widget.controller.marketingCount >= 1) ? true : false,
              badgeColor: Colors.teal,
              badgeContent: Obx(() => Text(
                  '${widget.controller.marketingCount}',
                  style: const TextStyle(fontSize: 10.0, color: Colors.white))),
              child: const Icon(Icons.notifications),
            ),
            onTap: () {
              Get.toNamed(AdminRoutes.adminMarketing);
            }),
        DrawerWidget(
            selected: widget.currentRoute == AdminRoutes.adminComm,
            icon: Icons.add_business,
            sizeIcon: 20.0,
            title: 'Commercial',
            style: bodyText1,
            badge: Badge(
              showBadge: (widget.controller.commCount >= 1) ? true : false,
              badgeColor: Colors.teal,
              badgeContent: Obx(() => Text('${widget.controller.commCount}',
                  style: const TextStyle(fontSize: 10.0, color: Colors.white))),
              child: const Icon(Icons.notifications),
            ),
            onTap: () {
              Get.toNamed(AdminRoutes.adminComm);
            }),
        DrawerWidget(
            selected: widget.currentRoute == AdminRoutes.adminLogistique,
            icon: Icons.home_work,
            sizeIcon: 20.0,
            title: 'Logistiques',
            style: bodyText1,
            badge: Badge(
              showBadge:
                  (widget.controller.logistiqueCount >= 1) ? true : false,
              badgeColor: Colors.teal,
              badgeContent: Obx(() => Text(
                  '${widget.controller.logistiqueCount}',
                  style: const TextStyle(fontSize: 10.0, color: Colors.white))),
              child: const Icon(Icons.notifications),
            ),
            onTap: () {
              Get.toNamed(AdminRoutes.adminLogistique);
            }),
      ],
    );
  }
}
