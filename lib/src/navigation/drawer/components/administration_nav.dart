import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_widget.dart';
import 'package:wm_solution/src/pages/administration/controller/admin_notify_controller.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';

class AdministrationNav extends StatefulWidget {
  const AdministrationNav(
      {super.key, required this.currentRoute, required this.profilController});
  final String currentRoute;
  final ProfilController profilController;

  @override
  State<AdministrationNav> createState() => _AdministrationNavState();
}

class _AdministrationNavState extends State<AdministrationNav> {
  final AdminNotifyController controller = Get.put(AdminNotifyController()); 
  bool isOpen1 = false; 
  
  
  @override
  Widget build(BuildContext context) {
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    final bodyText1 = Theme.of(context).textTheme.bodyText1;

    return ExpansionTile(
      leading: const Icon(
        Icons.admin_panel_settings,
        size: 30.0,
      ),
      title: AutoSizeText('Administration', maxLines: 1, style: bodyLarge),
      initiallyExpanded:
          (widget.profilController.user.departement == 'Administration') ? true : false,
      onExpansionChanged: (val) {
        setState(() {
          isOpen1 = !val;
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
              Get.toNamed(AdminRoutes.adminDashboard);
            }),
        DrawerWidget(
            selected: widget.currentRoute == AdminRoutes.adminBudget,
            icon: Icons.fact_check,
            sizeIcon: 20.0,
            title: 'Budgets',
            style: bodyText1,
            badge: Badge(
              showBadge: (controller.budgetCount >= 1) ? true : false,
              badgeColor: Colors.teal,
              badgeContent: Text('${controller.budgetCount}',
                  style: const TextStyle(fontSize: 10.0, color: Colors.white)),
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
              showBadge: (controller.financeCount >= 1) ? true : false,
              badgeColor: Colors.teal,
              badgeContent: Text('${controller.financeCount}',
                  style: const TextStyle(fontSize: 10.0, color: Colors.white)),
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
              showBadge: (controller.rhCount >= 1) ? true : false,
              badgeColor: Colors.teal,
              badgeContent: Text('${controller.rhCount}',
                  style: const TextStyle(fontSize: 10.0, color: Colors.white)),
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
              showBadge: (controller.exploitationCount >= 1) ? true : false,
              badgeColor: Colors.teal,
              badgeContent: Text('${controller.exploitationCount}',
                  style: const TextStyle(fontSize: 10.0, color: Colors.white)),
              child: const Icon(Icons.notifications),
            ),
            onTap: () {
              Get.toNamed(AdminRoutes.adminExploitation);
            }),
        DrawerWidget(
            selected: widget.currentRoute == AdminRoutes.adminCommMarketing,
            icon: Icons.add_business,
            sizeIcon: 20.0,
            title: 'Comm. & Marketing',
            style: bodyText1,
            badge: Badge(
              showBadge: (controller.commMarketingCount >= 1) ? true : false,
              badgeColor: Colors.teal,
              badgeContent: Text('${controller.commMarketingCount}',
                  style: const TextStyle(fontSize: 10.0, color: Colors.white)),
              child: const Icon(Icons.notifications),
            ),
            onTap: () {
              Get.toNamed(AdminRoutes.adminCommMarketing);
            }),
        DrawerWidget(
            selected: widget.currentRoute == AdminRoutes.adminLogistique,
            icon: Icons.home_work,
            sizeIcon: 20.0,
            title: 'Logistiques',
            style: bodyText1,
            badge: Badge(
              showBadge: (controller.logistiqueCount >= 1) ? true : false,
              badgeColor: Colors.teal,
              badgeContent: Text('${controller.logistiqueCount}',
                  style: const TextStyle(fontSize: 10.0, color: Colors.white)),
              child: const Icon(Icons.notifications),
            ),
            onTap: () {
              Get.toNamed(AdminRoutes.adminLogistique);
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
