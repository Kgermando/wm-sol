
import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/controllers/departement_notify_controller.dart';
import 'package:wm_solution/src/models/users/user_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_widget.dart';  
import 'package:wm_solution/src/routes/routes.dart';

class BudgetNav extends StatefulWidget {
  const BudgetNav(
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
  State<BudgetNav> createState() => _BudgetNavState();
}

class _BudgetNavState extends State<BudgetNav> { 
  bool isOpen = false;

  @override
  Widget build(BuildContext context) { 
   final bodyMedium = Theme.of(context).textTheme.bodyLarge;
    final bodyText1 = Theme.of(context).textTheme.bodyMedium; 
    int userRole = int.parse(widget.user.role);
    return ExpansionTile(
      leading: const Icon(Icons.fact_check, size: 30.0),
      title: AutoSizeText('Budgets', maxLines: 1, style: bodyMedium),
      initiallyExpanded: widget.departementList.contains('Budgets') ? true : false,
      onExpansionChanged: (val) {
        setState(() {
          isOpen = !val;
        });
      },
      trailing: const Icon(Icons.arrow_drop_down),
      children: [
        if (userRole <= 2)
          DrawerWidget(
              selected: widget.currentRoute == BudgetRoutes.budgetDashboard,
              icon: Icons.dashboard,
              sizeIcon: 20.0,
              title: 'Dashboard',
              style: bodyText1!,
              onTap: () {
                Get.toNamed(BudgetRoutes.budgetDashboard); 
                // Navigator.of(context).pop();
              }),
        if (widget.departementList.contains('Budgets') && userRole <= 2)
          DrawerWidget(
              selected: widget.currentRoute == BudgetRoutes.budgetDD,
              icon: Icons.manage_accounts,
              sizeIcon: 20.0,
              title: 'Directeur de departement',
              style: bodyText1!,
              badge: Badge(
                showBadge: (int.parse(widget.controller.itemBudgetCount) >= 1) ? true : false,
                badgeColor: Colors.teal,
                badgeContent:Obx(() => Text(widget.controller.itemBudgetCount,
                    style:
                        const TextStyle(fontSize: 10.0, color: Colors.white))) ,
                child: const Icon(Icons.notifications),
              ),
              onTap: () {
                Get.toNamed(BudgetRoutes.budgetDD);  
                // Navigator.of(context).pop();
              }),
        DrawerWidget(
            selected:
                widget.currentRoute == BudgetRoutes.budgetBudgetPrevisionel,
            icon: Icons.wallet_giftcard,
            sizeIcon: 20.0,
            title: 'Budgets previsonels',
            style: bodyText1!,
            onTap: () {
              Get.toNamed(BudgetRoutes.budgetBudgetPrevisionel);   
              // Navigator.of(context).pop();
            }),
        DrawerWidget(
            selected: widget.currentRoute ==
                BudgetRoutes.historiqueBudgetPrevisionel,
            icon: Icons.history_sharp,
            sizeIcon: 20.0,
            title: 'Historique Budgetaires',
            style: bodyText1,
            onTap: () {
              Get.toNamed(BudgetRoutes.historiqueBudgetPrevisionel);  
              Navigator.pushNamed(
                  context, BudgetRoutes.historiqueBudgetPrevisionel);
              // Navigator.of(context).pop();
            }),
        
      ],
    );
  }
}
