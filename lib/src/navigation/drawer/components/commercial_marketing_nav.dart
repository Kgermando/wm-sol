
import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_widget.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/notify/notify_comptabilite.dart';
import 'package:wm_solution/src/routes/routes.dart';

class CommercialMaketingNav extends StatefulWidget {
  const CommercialMaketingNav({super.key, required this.currentRoute, required this.profilController, required this.departement});
  final String currentRoute;
  final ProfilController profilController;
  final List<dynamic> departement;

  @override
  State<CommercialMaketingNav> createState() => _CommercialMaketingNavState();
}

class _CommercialMaketingNavState extends State<CommercialMaketingNav> {
      final ComptabiliteNotifyController controller =
      Get.put(ComptabiliteNotifyController());
  bool isOpenComMarketing1 = false;
  bool isOpenComMarketing2 = false;

  @override
  Widget build(BuildContext context) {  
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    final bodyText1 = Theme.of(context).textTheme.bodyText1;
    final bodyText2 = Theme.of(context).textTheme.bodyText2; 
    int userRole = int.parse(widget.profilController.user.role);
    return ExpansionTile(
      leading: const Icon(Icons.store, size: 30.0),
      title:
          AutoSizeText('Commercial & Marketing', maxLines: 2, style: bodyLarge),
      initiallyExpanded:
          (widget.departement.first == 'Commercial et Marketing')
              ? true
              : false,
      onExpansionChanged: (val) {
        setState(() {
          isOpenComMarketing1 = !val;
        });
      },
      trailing: const Icon(Icons.arrow_drop_down),
      children: [
        if (userRole <= 2)
          DrawerWidget(
              selected: widget.currentRoute ==
                  ComMarketingRoutes.comMarketingDashboard,
              icon: Icons.dashboard,
              sizeIcon: 20.0,
              title: 'Dashboard',
              style: bodyText1!,
              onTap: () {
                Get.toNamed(ComMarketingRoutes.comMarketingDashboard);
              }),
        if (userRole <= 2)
          DrawerWidget(
              selected:
                  widget.currentRoute == ComMarketingRoutes.comMarketingDD,
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
                Get.toNamed(ComMarketingRoutes.comMarketingDD); 
              }),
        ExpansionTile(
          leading: const Icon(Icons.visibility, size: 20.0),
          title: Text('Marketing', style: bodyText1),
          initiallyExpanded: false,
          onExpansionChanged: (val) {
            setState(() {
              isOpenComMarketing2 = !val;
            });
          },
          children: [
            DrawerWidget(
                selected: widget.currentRoute ==
                    ComMarketingRoutes.comMarketingAnnuaire,
                icon: Icons.arrow_right,
                sizeIcon: 15.0,
                title: 'Annuaire',
                style: bodyText2!,
                onTap: () {
                  Get.toNamed(ComMarketingRoutes.comMarketingAnnuaire);  
                }),
            DrawerWidget(
                selected: widget.currentRoute ==
                    ComMarketingRoutes.comMarketingAgenda,
                icon: Icons.arrow_right,
                sizeIcon: 15.0,
                title: 'Agenda',
                style: bodyText2,
                onTap: () {
                  Get.toNamed(ComMarketingRoutes.comMarketingAgenda);  
                }),
            if (userRole <= 3)
              DrawerWidget(
                  selected: widget.currentRoute ==
                      ComMarketingRoutes.comMarketingCampaign,
                  icon: Icons.arrow_right,
                  sizeIcon: 15.0,
                  title: 'Campagnes',
                  style: bodyText2,
                  onTap: () {
                    Get.toNamed(ComMarketingRoutes.comMarketingCampaign);  
                    // Navigator.of(context).pop();
                  }),
            DrawerWidget(
                selected: widget.currentRoute ==
                    TacheRoutes.tachePage,
                icon: Icons.arrow_right,
                sizeIcon: 15.0,
                title: 'Vos tâches',
                style: bodyText2,
                onTap: () {
                  Get.toNamed(TacheRoutes.tachePage);
                }),
          ],
        ),
        ExpansionTile(
          leading: const Icon(Icons.store, size: 20.0),
          title: Text('Commercial', style: bodyText1),
          initiallyExpanded: false,
          onExpansionChanged: (val) {
            setState(() {
              isOpenComMarketing2 = !val;
            });
          },
          children: [
            if (userRole <= 3)
              DrawerWidget(
                  selected: widget.currentRoute ==
                      ComMarketingRoutes.comMarketingSuccursale,
                  icon: Icons.arrow_right,
                  sizeIcon: 15.0,
                  title: 'Succursale',
                  style: bodyText2,
                  onTap: () {
                    Get.toNamed(ComMarketingRoutes.comMarketingSuccursale);   
                  }),
            if (userRole <= 3)
              DrawerWidget(
                  selected: widget.currentRoute ==
                      ComMarketingRoutes.comMarketingProduitModel,
                  icon: Icons.arrow_right,
                  sizeIcon: 15.0,
                  title: 'Produit modèle',
                  style: bodyText2,
                  onTap: () {
                    Get.toNamed(ComMarketingRoutes.comMarketingProduitModel);    
                  }),
            if (userRole <= 3)
              DrawerWidget(
                  selected: widget.currentRoute ==
                      ComMarketingRoutes.comMarketingStockGlobal,
                  icon: Icons.arrow_right,
                  sizeIcon: 15.0,
                  title: 'Stocks global',
                  style: bodyText2,
                  onTap: () {
                    Get.toNamed(ComMarketingRoutes.comMarketingStockGlobal);  
                  }),
            DrawerWidget(
                selected:
                    widget.currentRoute == ComMarketingRoutes.comMarketingAchat,
                icon: Icons.arrow_right,
                sizeIcon: 15.0,
                title: 'Achats',
                style: bodyText2,
                onTap: () {
                  Get.toNamed(ComMarketingRoutes.comMarketingAchat);    
                }),
            if (userRole <= 3)
              DrawerWidget(
                  selected: widget.currentRoute ==
                      ComMarketingRoutes.comMarketingBonLivraison,
                  icon: Icons.arrow_right,
                  sizeIcon: 15.0,
                  title: 'Bon de livraison',
                  style: bodyText2,
                  onTap: () {
                    Get.toNamed(ComMarketingRoutes.comMarketingBonLivraison);   
                  }),
            if (userRole <= 3)
              DrawerWidget(
                  selected: widget.currentRoute ==
                      ComMarketingRoutes.comMarketingRestitution,
                  icon: Icons.arrow_right,
                  sizeIcon: 15.0,
                  title: 'Restitution du produit',
                  style: bodyText2,
                  onTap: () {
                    Get.toNamed(ComMarketingRoutes.comMarketingRestitution);   
                  }),
            DrawerWidget(
                selected: widget.currentRoute ==
                    ComMarketingRoutes.comMarketingFacture,
                icon: Icons.arrow_right,
                sizeIcon: 15.0,
                title: 'Factures',
                style: bodyText2,
                onTap: () {
                  Get.toNamed(ComMarketingRoutes.comMarketingFacture);   
                }),
            DrawerWidget(
                selected: widget.currentRoute ==
                    ComMarketingRoutes.comMarketingCreance,
                icon: Icons.arrow_right,
                sizeIcon: 15.0,
                title: 'Factures créance',
                style: bodyText2,
                onTap: () {
                  Get.toNamed(ComMarketingRoutes.comMarketingCreance); 
                }),
            DrawerWidget(
                selected:
                    widget.currentRoute == ComMarketingRoutes.comMarketingVente,
                icon: Icons.arrow_right,
                sizeIcon: 15.0,
                title: 'Ventes',
                style: bodyText2,
                onTap: () {
                  Get.toNamed(ComMarketingRoutes.comMarketingVente);  
                }),
            DrawerWidget(
                selected:
                    widget.currentRoute == ComMarketingRoutes.comMarketingcart,
                icon: Icons.arrow_right,
                sizeIcon: 15.0,
                title: 'Panier',
                style: bodyText2,
                onTap: () {
                  Get.toNamed(ComMarketingRoutes.comMarketingcart); 
                }),
            if (userRole <= 2)
              DrawerWidget(
                  selected: widget.currentRoute ==
                      ComMarketingRoutes.comMarketingHistoryRavitaillement,
                  icon: Icons.arrow_right,
                  sizeIcon: 15.0,
                  title: 'Historique de ravitaillement',
                  style: bodyText2,
                  onTap: () {
                    Get.toNamed(ComMarketingRoutes.comMarketingHistoryRavitaillement); 
                  }),
            if (userRole <= 2)
              DrawerWidget(
                  selected: widget.currentRoute ==
                      ComMarketingRoutes.comMarketingHistoryLivraison,
                  icon: Icons.arrow_right,
                  sizeIcon: 15.0,
                  title: 'Historique de livraison',
                  style: bodyText2,
                  onTap: () {
                    Get.toNamed(
                        ComMarketingRoutes.comMarketingHistoryLivraison);  
                  }),
          ],
        ),
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
