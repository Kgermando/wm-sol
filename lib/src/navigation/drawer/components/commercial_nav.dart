
import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/models/users/user_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_widget.dart'; 
import 'package:wm_solution/src/pages/commercial/controller/notify/commercial_notify.dart';
import 'package:wm_solution/src/routes/routes.dart';

class CommercialNav extends StatefulWidget {
  const CommercialNav({super.key, required this.currentRoute, required this.user, required this.departementList});
  final String currentRoute;
  final UserModel user;
  final List<dynamic> departementList;

  @override
  State<CommercialNav> createState() => _CommercialNavState();
}

class _CommercialNavState extends State<CommercialNav> {
      final ComNotifyController controller = Get.put(ComNotifyController());
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {  
    final bodyMedium = Theme.of(context).textTheme.bodyLarge;
    final bodyText1 = Theme.of(context).textTheme.bodyMedium; 
    int userRole = int.parse(widget.user.role);
    return ExpansionTile(
      leading: const Icon(Icons.store, size: 30.0),
      title:
          AutoSizeText('Commercial', maxLines: 1, style: bodyMedium),
      initiallyExpanded:
          widget.departementList.contains('Commercial')
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
              selected: widget.currentRoute ==
                  ComRoutes.comDashboard,
              icon: Icons.dashboard,
              sizeIcon: 20.0,
              title: 'Dashboard',
              style: bodyText1!,
              onTap: () {
                Get.toNamed(ComRoutes.comDashboard);
              }),
        if (userRole <= 2)
          DrawerWidget(
              selected:
                  widget.currentRoute == ComRoutes.comDD,
              icon: Icons.manage_accounts,
              sizeIcon: 20.0,
              title: 'Directeur de departement',
              style: bodyText1!,
              badge: Badge(
                showBadge:
                    (int.parse(controller.itemCount) >= 1) ? true : false,
                badgeColor: Colors.teal,
                badgeContent: Obx(() => Text(controller.itemCount,
                    style:
                        const TextStyle(fontSize: 10.0, color: Colors.white))) ,
                child: const Icon(Icons.notifications),
              ),
              onTap: () {
                Get.toNamed(ComRoutes.comDD); 
              }), 
          DrawerWidget(
            selected: widget.currentRoute == ComRoutes.comVente,
            icon: Icons.arrow_right,
            sizeIcon: 15.0,
            title: 'Ventes',
            style: bodyText1!,
            onTap: () {
              Get.toNamed(ComRoutes.comVente);
            }),
        if (userRole <= 2)
          DrawerWidget(
              selected: widget.currentRoute ==
                  ComRoutes.comSuccursale,
              icon: Icons.arrow_right,
              sizeIcon: 15.0,
              title: 'Succursale',
              style: bodyText1,
              onTap: () {
                Get.toNamed(ComRoutes.comSuccursale);
              }),
        if (userRole <= 2)
          DrawerWidget(
              selected: widget.currentRoute ==
                  ComRoutes.comProduitModel,
              icon: Icons.arrow_right,
              sizeIcon: 15.0,
              title: 'Produit modèle',
              style: bodyText1,
              onTap: () {
                Get.toNamed(ComRoutes.comProduitModel);
              }),
        if (userRole <= 2)
          DrawerWidget(
              selected: widget.currentRoute ==
                  ComRoutes.comStockGlobal,
              icon: Icons.arrow_right,
              sizeIcon: 15.0,
              title: 'Stocks global',
              style: bodyText1,
              onTap: () {
                Get.toNamed(ComRoutes.comStockGlobal);
              }),
        DrawerWidget(
            selected:
                widget.currentRoute == ComRoutes.comAchat,
            icon: Icons.arrow_right,
            sizeIcon: 15.0,
            title: 'Stock',
            style: bodyText1,
            onTap: () {
              Get.toNamed(ComRoutes.comAchat);
            }),
        if (userRole <= 3)
          DrawerWidget(
              selected: widget.currentRoute ==
                  ComRoutes.comBonLivraison,
              icon: Icons.arrow_right,
              sizeIcon: 15.0,
              title: 'Bon de livraison',
              style: bodyText1,
              onTap: () {
                Get.toNamed(ComRoutes.comBonLivraison);
              }),
        if (userRole <= 2)
          DrawerWidget(
              selected: widget.currentRoute ==
                  ComRoutes.comRestitution,
              icon: Icons.arrow_right,
              sizeIcon: 15.0,
              title: 'Restitution du produit',
              style: bodyText1,
              onTap: () {
                Get.toNamed(ComRoutes.comRestitution);
              }),
        DrawerWidget(
            selected:
                widget.currentRoute == ComRoutes.comFacture,
            icon: Icons.arrow_right,
            sizeIcon: 15.0,
            title: 'Factures',
            style: bodyText1,
            onTap: () {
              Get.toNamed(ComRoutes.comFacture);
            }),
        DrawerWidget(
            selected:
                widget.currentRoute == ComRoutes.comCreance,
            icon: Icons.arrow_right,
            sizeIcon: 15.0,
            title: 'Factures créance',
            style: bodyText1,
            onTap: () {
              Get.toNamed(ComRoutes.comCreance);
            }), 
        DrawerWidget(
            selected:
                widget.currentRoute == ComRoutes.comCart,
            icon: Icons.arrow_right,
            sizeIcon: 15.0,
            title: 'Panier',
            style: bodyText1,
            onTap: () {
              Get.toNamed(ComRoutes.comCart);
            }),
        DrawerWidget(
            selected: widget.currentRoute == ComRoutes.comVenteEffectue,
            icon: Icons.arrow_right,
            sizeIcon: 15.0,
            title: 'Vos Ventes',
            style: bodyText1,
            onTap: () {
              Get.toNamed(ComRoutes.comVenteEffectue);
            }), 
        if (userRole <= 2)
          DrawerWidget(
              selected: widget.currentRoute ==
                  ComRoutes.comHistoryRavitaillement,
              icon: Icons.arrow_right,
              sizeIcon: 15.0,
              title: 'Historique de ravitaillement',
              style: bodyText1,
              onTap: () {
                Get.toNamed(
                    ComRoutes.comHistoryRavitaillement);
              }),
        if (userRole <= 3)
          DrawerWidget(
              selected: widget.currentRoute ==
                  ComRoutes.comHistoryLivraison,
              icon: Icons.arrow_right,
              sizeIcon: 15.0,
              title: 'Historique de livraison',
              style: bodyText1,
              onTap: () {
                Get.toNamed(ComRoutes.comHistoryLivraison);
              }),
       
      ],
    );
  }
}
