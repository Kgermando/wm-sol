import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_widget.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/banques/banque_name_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/caisses/caisse_name_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/fin_exterieur/fin_exterieur_name_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/notify/finance_notify_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';

class FinanceNav extends StatefulWidget {
  const FinanceNav({super.key, required this.currentRoute, required this.profilController});
  final String currentRoute;
  final ProfilController profilController;

  @override
  State<FinanceNav> createState() => _FinanceNavState();
}

class _FinanceNavState extends State<FinanceNav> {
  bool isOpen = false;
  bool isOpenBanque = false;
  bool isOpenCaisse = false;
  bool isOpenFinExterieur = false;

  @override
  Widget build(BuildContext context) {
    final FinanceNotifyController financeNotifyController =
        Get.put(FinanceNotifyController());
    final BanqueNameController banqueNameController =
        Get.put(BanqueNameController());
    final CaisseNameController caisseNameController =
        Get.put(CaisseNameController());
    final FinExterieurNameController finExterieurNameController =
        Get.put(FinExterieurNameController());
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    final bodyText1 = Theme.of(context).textTheme.bodyText1;
    final bodyText2 = Theme.of(context).textTheme.bodyText2;
    int userRole = int.parse(widget.profilController.user.role);
    return ExpansionTile(
      leading: const Icon(Icons.account_balance, size: 30.0),
      title: AutoSizeText('Finances', maxLines: 1, style: bodyLarge),
      initiallyExpanded:
          (widget.profilController.user.departement == 'Finances') ? true : false,
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
                Get.toNamed(FinanceRoutes.financeDashboard);
                // Navigator.of(context).pop();
              }),
        if (userRole <= 2)
          DrawerWidget(
              selected: widget.currentRoute == FinanceRoutes.finDD,
              icon: Icons.manage_accounts,
              sizeIcon: 20.0,
              title: 'Directeur de departement',
              style: bodyText1!,
              badge: Badge(
                showBadge: (int.parse(financeNotifyController.itemCount) >= 1)
                    ? true
                    : false,
                badgeColor: Colors.teal,
                badgeContent: Text(financeNotifyController.itemCount,
                    style:
                        const TextStyle(fontSize: 10.0, color: Colors.white)),
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
              showBadge: (int.parse(financeNotifyController.itemCountObs) >= 1)
                  ? true
                  : false,
              badgeColor: Colors.purple,
              badgeContent: Text(financeNotifyController.itemCountObs,
                  style: const TextStyle(fontSize: 10.0, color: Colors.white)),
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
                    widget.currentRoute == FinanceRoutes.transactionsBanque,
                icon: Icons.arrow_right,
                sizeIcon: 15.0,
                title: element.nomComplet,
                style: bodyText2!,
                onTap: () { 
                  Get.toNamed(FinanceRoutes.transactionsBanque,
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
                    widget.currentRoute == FinanceRoutes.transactionsCaisse,
                icon: Icons.arrow_right,
                sizeIcon: 15.0,
                title: element.nomComplet,
                style: bodyText2!,
                onTap: () { 
                  Get.toNamed(FinanceRoutes.transactionsCaisse,
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
                    FinanceRoutes.transactionsFinancementExterne,
                icon: Icons.arrow_right,
                sizeIcon: 15.0,
                title: element.nomComplet,
                style: bodyText2!,
                onTap: () { 
                  Get.toNamed(FinanceRoutes.transactionsFinancementExterne,
                      arguments: element);
                });
          }).toList(),
        ),
        DrawerWidget(
            selected: widget.currentRoute == RhRoutes.rhPerformence,
            icon: Icons.multiline_chart_sharp,
            sizeIcon: 20.0,
            title: 'Performences',
            style: bodyText1,
            onTap: () {
              Navigator.pushNamed(context, RhRoutes.rhPerformence);
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
