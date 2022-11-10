
import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_widget.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/notify/commercial_notify.dart';
import 'package:wm_solution/src/routes/routes.dart';

class CommercialNav extends StatefulWidget {
  const CommercialNav({super.key, required this.currentRoute, required this.profilController, required this.departement});
  final String currentRoute;
  final ProfilController profilController;
  final List<dynamic> departement;

  @override
  State<CommercialNav> createState() => _CommercialNavState();
}

class _CommercialNavState extends State<CommercialNav> {
      final ComNotifyController controller =
      Get.put(ComNotifyController());
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {  
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final bodyText1 = Theme.of(context).textTheme.bodyText1;
    final bodyText2 = Theme.of(context).textTheme.bodyText2; 
    int userRole = int.parse(widget.profilController.user.role);
    return ExpansionTile(
      leading: const Icon(Icons.store, size: 30.0),
      title:
          AutoSizeText('Commercial', maxLines: 2, style: bodyMedium),
      initiallyExpanded:
          (widget.departement.first == 'Commercial')
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
                badgeContent: Text(controller.itemCount,
                    style:
                        const TextStyle(fontSize: 10.0, color: Colors.white)),
                child: const Icon(Icons.notifications),
              ),
              onTap: () {
                Get.toNamed(ComRoutes.comDD); 
              }), 
        if (userRole <= 3)
          DrawerWidget(
              selected: widget.currentRoute ==
                  ComRoutes.comSuccursale,
              icon: Icons.arrow_right,
              sizeIcon: 15.0,
              title: 'Succursale',
              style: bodyText2!,
              onTap: () {
                Get.toNamed(ComRoutes.comSuccursale);
              }),
        if (userRole <= 3)
          DrawerWidget(
              selected: widget.currentRoute ==
                  ComRoutes.comProduitModel,
              icon: Icons.arrow_right,
              sizeIcon: 15.0,
              title: 'Produit modèle',
              style: bodyText2!,
              onTap: () {
                Get.toNamed(ComRoutes.comProduitModel);
              }),
        if (userRole <= 3)
          DrawerWidget(
              selected: widget.currentRoute ==
                  ComRoutes.comStockGlobal,
              icon: Icons.arrow_right,
              sizeIcon: 15.0,
              title: 'Stocks global',
              style: bodyText2!,
              onTap: () {
                Get.toNamed(ComRoutes.comStockGlobal);
              }),
        DrawerWidget(
            selected:
                widget.currentRoute == ComRoutes.comAchat,
            icon: Icons.arrow_right,
            sizeIcon: 15.0,
            title: 'Stock',
            style: bodyText2!,
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
              style: bodyText2,
              onTap: () {
                Get.toNamed(ComRoutes.comBonLivraison);
              }),
        if (userRole <= 3)
          DrawerWidget(
              selected: widget.currentRoute ==
                  ComRoutes.comRestitution,
              icon: Icons.arrow_right,
              sizeIcon: 15.0,
              title: 'Restitution du produit',
              style: bodyText2,
              onTap: () {
                Get.toNamed(ComRoutes.comRestitution);
              }),
        DrawerWidget(
            selected:
                widget.currentRoute == ComRoutes.comFacture,
            icon: Icons.arrow_right,
            sizeIcon: 15.0,
            title: 'Factures',
            style: bodyText2,
            onTap: () {
              Get.toNamed(ComRoutes.comFacture);
            }),
        DrawerWidget(
            selected:
                widget.currentRoute == ComRoutes.comCreance,
            icon: Icons.arrow_right,
            sizeIcon: 15.0,
            title: 'Factures créance',
            style: bodyText2,
            onTap: () {
              Get.toNamed(ComRoutes.comCreance);
            }),
        DrawerWidget(
            selected:
                widget.currentRoute == ComRoutes.comVente,
            icon: Icons.arrow_right,
            sizeIcon: 15.0,
            title: 'Ventes',
            style: bodyText2,
            onTap: () {
              Get.toNamed(ComRoutes.comVente);
            }),
        DrawerWidget(
            selected:
                widget.currentRoute == ComRoutes.comCart,
            icon: Icons.arrow_right,
            sizeIcon: 15.0,
            title: 'Panier',
            style: bodyText2,
            onTap: () {
              Get.toNamed(ComRoutes.comCart);
            }),
        if (userRole <= 2)
          DrawerWidget(
              selected: widget.currentRoute ==
                  ComRoutes.comHistoryRavitaillement,
              icon: Icons.arrow_right,
              sizeIcon: 15.0,
              title: 'Historique de ravitaillement',
              style: bodyText2,
              onTap: () {
                Get.toNamed(
                    ComRoutes.comHistoryRavitaillement);
              }),
        if (userRole <= 2)
          DrawerWidget(
              selected: widget.currentRoute ==
                  ComRoutes.comHistoryLivraison,
              icon: Icons.arrow_right,
              sizeIcon: 15.0,
              title: 'Historique de livraison',
              style: bodyText2,
              onTap: () {
                Get.toNamed(ComRoutes.comHistoryLivraison);
              }),
        if (userRole <= 3)
          DrawerWidget(
              selected: widget.currentRoute == RhRoutes.rhPerformence,
              icon: Icons.multiline_chart_sharp,
              sizeIcon: 20.0,
              title: 'Performences',
              style: bodyText1!,
              onTap: () {
                Get.toNamed(RhRoutes.rhPerformence);  
              }),
        DrawerWidget(
            selected:
                widget.currentRoute == LogistiqueRoutes.logApprovisionReception,
            icon: Icons.handyman,
            sizeIcon: 20.0,
            title: 'Acc. Reception',
            style: bodyText1!,
            onTap: () {
              Get.toNamed(LogistiqueRoutes.logApprovisionReception);
              // Navigator.of(context).pop();
            }),
        DrawerWidget(
            selected: widget.currentRoute == ArchiveRoutes.archives,
            icon: Icons.archive,
            sizeIcon: 20.0,
            title: 'Archives',
            style: bodyMedium!,
            onTap: () {
              Get.toNamed(ArchiveRoutes.archives);  
            }),
      ],
    );
  }
}
