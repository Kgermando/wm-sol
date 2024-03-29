import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/controllers/departement_notify_controller.dart';
import 'package:wm_solution/src/models/users/user_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_widget.dart';
import 'package:wm_solution/src/pages/finances/controller/banques/banque_name_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/caisses/caisse_name_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/dahboard/dashboard_finance_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/fin_exterieur/fin_exterieur_name_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';

class FinanceNav extends StatefulWidget {
  const FinanceNav(
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
  State<FinanceNav> createState() => _FinanceNavState();
}

class _FinanceNavState extends State<FinanceNav> {
  final DashboardFinanceController dashboardFinanceController = Get.find();
  final BanqueNameController banqueNameController =
      Get.put(BanqueNameController());
  final CaisseNameController caisseNameController =
      Get.put(CaisseNameController());
  final FinExterieurNameController finExterieurNameController =
      Get.put(FinExterieurNameController());
  bool isOpen = false;
  bool isOpenBanque = false;
  bool isOpenCaisse = false;
  bool isOpenFinExterieur = false;

  @override
  Widget build(BuildContext context) {
    final bodyMedium = Theme.of(context).textTheme.bodyLarge;
    final bodyText1 = Theme.of(context).textTheme.bodyMedium;
    int userRole = int.parse(widget.user.role);
    return ExpansionTile(
      leading: const Icon(Icons.account_balance, size: 30.0),
      title: AutoSizeText('Finances', maxLines: 1, style: bodyMedium),
      initiallyExpanded:
          widget.departementList.contains('Finances') ? true : false,
      onExpansionChanged: (val) {
        setState(() {
          isOpen = !val;
        });
      },
      trailing: const Icon(Icons.arrow_drop_down),
      children: [
        if (userRole <= 2)
          DrawerWidget(
              selected: widget.currentRoute == FinanceRoutes.financeDashboard,
              icon: Icons.dashboard,
              sizeIcon: 20.0,
              title: 'Dashboard',
              style: bodyText1!,
              onTap: () {
                dashboardFinanceController.getData();
                Get.toNamed(FinanceRoutes.financeDashboard);
              }),
        if (widget.departementList.contains('Finances') && userRole <= 2)
          DrawerWidget(
              selected: widget.currentRoute == FinanceRoutes.finDD,
              icon: Icons.manage_accounts,
              sizeIcon: 20.0,
              title: 'Directeur de departement',
              style: bodyText1!,
              badge: Badge(
                showBadge: (int.parse(widget.controller.itemFinanceCount) >= 1)
                    ? true
                    : false,
                badgeColor: Colors.teal,
                badgeContent: Obx(() => Text(widget.controller.itemFinanceCount,
                    style:
                        const TextStyle(fontSize: 10.0, color: Colors.white))),
                child: const Icon(Icons.notifications),
              ),
              onTap: () {
                Get.toNamed(FinanceRoutes.finDD);
                // Navigator.of(context).pop();
              }),
        DrawerWidget(
            selected: widget.currentRoute == FinanceRoutes.finObservation,
            icon: Icons.grid_view,
            sizeIcon: 20.0,
            title: 'Observations',
            style: bodyText1!,
            badge: Badge(
              showBadge: (int.parse(widget.controller.itemFinanceCountObs) >= 1)
                  ? true
                  : false,
              badgeColor: Colors.purple,
              badgeContent: Obx(() => Text(
                  widget.controller.itemFinanceCountObs,
                  style: const TextStyle(fontSize: 10.0, color: Colors.white))),
              child: const Icon(Icons.notifications),
            ),
            onTap: () {
              Get.toNamed(FinanceRoutes.finObservation);
              // Navigator.of(context).pop();
            }),
        DrawerWidget(
            selected: widget.currentRoute == FinanceRoutes.transactionsCreances,
            icon: Icons.grid_view,
            sizeIcon: 20.0,
            title: 'Créances',
            style: bodyText1,
            onTap: () {
              Get.toNamed(FinanceRoutes.transactionsCreances);
            }),
        DrawerWidget(
            selected: widget.currentRoute == FinanceRoutes.transactionsDettes,
            icon: Icons.grid_view,
            sizeIcon: 20.0,
            title: 'Dettes',
            style: bodyText1,
            onTap: () {
              Get.toNamed(FinanceRoutes.transactionsDettes);
            }),
        ExpansionTile(
          leading: const Icon(Icons.compare_arrows, size: 20.0),
          title: Text('Banques', style: bodyText1),
          initiallyExpanded: false,
          onExpansionChanged: (val) {
            setState(() {
              isOpenBanque = !val;
            });
          },
          children: banqueNameController.banqueNameList.map((element) {
            return DrawerWidget(
                selected:
                    widget.currentRoute == '/transactions-banque/${element.id}',
                icon: Icons.arrow_right,
                sizeIcon: 15.0,
                title: element.nomComplet.toUpperCase(),
                style: bodyText1,
                onTap: () {
                  Get.toNamed('/transactions-banque/${element.id}',
                      arguments: element);
                });
          }).toList(),
        ),
        ExpansionTile(
          leading: const Icon(Icons.compare_arrows, size: 20.0),
          title: Text('Caisses', style: bodyText1),
          initiallyExpanded: false,
          onExpansionChanged: (val) {
            setState(() {
              isOpenCaisse = !val;
            });
          },
          children: caisseNameController.caisseNameList.map((element) {
            return DrawerWidget(
                selected:
                    widget.currentRoute == '/transactions-caisse/${element.id}',
                icon: Icons.arrow_right,
                sizeIcon: 15.0,
                title: element.nomComplet.toUpperCase(),
                style: bodyText1,
                onTap: () {
                  Get.toNamed('/transactions-caisse/${element.id!}',
                      arguments: element);
                });
          }).toList(),
        ),
        ExpansionTile(
          leading: const Icon(Icons.compare_arrows, size: 20.0),
          title: Text('Fin. exterieur', style: bodyText1),
          initiallyExpanded: false,
          onExpansionChanged: (val) {
            setState(() {
              isOpenFinExterieur = !val;
            });
          },
          children:
              finExterieurNameController.finExterieurNameList.map((element) {
            return DrawerWidget(
                selected: widget.currentRoute ==
                    '/transactions-financement-externe/${element.id}',
                icon: Icons.arrow_right,
                sizeIcon: 15.0,
                title: element.nomComplet.toUpperCase(),
                style: bodyText1,
                onTap: () {
                  Get.toNamed('/transactions-financement-externe/${element.id}',
                      arguments: element);
                });
          }).toList(),
        ),
      ],
    );
  }
}
