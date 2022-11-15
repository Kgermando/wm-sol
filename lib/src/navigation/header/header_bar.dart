import 'dart:convert';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/reponsiveness.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/constants/style.dart';
import 'package:wm_solution/src/models/menu_item.dart';
import 'package:wm_solution/src/navigation/header/controller/notify_header_controller.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/update/controller/update_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/utils/info_system.dart';
import 'package:wm_solution/src/utils/menu_items.dart';
import 'package:wm_solution/src/utils/menu_options.dart';
import 'package:wm_solution/src/widgets/bread_crumb_widget.dart';

AppBar headerBar(BuildContext context, GlobalKey<ScaffoldState> scaffoldKey,
    String title, String subTitle) {
  final ProfilController profilController = Get.find();
  final UpdateController updateController = Get.find();
  final NotifyHeaderController notifyHeaderController =
      Get.put(NotifyHeaderController());

  List<dynamic> departementList = (notifyHeaderController
              .profilController.user.departement ==
          '-')
      ? ["Support"]
      : jsonDecode(notifyHeaderController.profilController.user.departement);

  final bodyLarge = Theme.of(context).textTheme.bodyLarge;

  final String firstLettter = profilController.user.prenom[0];
  final String firstLettter2 = profilController.user.nom[0];
  return AppBar(
    leadingWidth: 100,
    leading: !ResponsiveWidget.isSmallScreen(context)
        ? Image.asset(
            InfoSystem().logoSansFond(),
            width: 20,
            height: 20,
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    scaffoldKey.currentState!.openDrawer();
                  }),
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back))
            ],
          ),
    title: Responsive.isMobile(context)
        ? Container()
        : InkWell(
            onTap: () {
              Get.back();
            },
            child: Row(
              children: [
                const Icon(Icons.arrow_back),
                BreadCrumb(
                  overflow: ScrollableOverflow(
                      keepLastDivider: false,
                      reverse: false,
                      direction: Axis.horizontal),
                  items: <BreadCrumbItem>[
                    BreadCrumbItem(content: BreadCrumbWidget(title: title)),
                    (Responsive.isMobile(context))
                        ? BreadCrumbItem(content: Container())
                        : BreadCrumbItem(
                            content: BreadCrumbWidget(title: subTitle)),
                  ],
                  divider: const Icon(Icons.chevron_right),
                ),
              ],
            ),
          ),
    actions: [
      if (Platform.isWindows &&
          updateController.updateList.isNotEmpty &&
          updateController.sumVersionCloud > updateController.sumLocalVersion)
        IconButton(
            iconSize: 40,
            tooltip: 'Téléchargement',
            onPressed: () {
              updateController.downloadNetworkSoftware(
                  url: updateController.updateList.last.urlUpdate);
            },
            icon: (updateController.downloading)
                ? (updateController.progressString == "100%")
                    ? const Icon(Icons.check)
                    : Obx(() => AutoSizeText(updateController.progressString,
                        maxLines: 1, style: const TextStyle(fontSize: 12.0)))
                : Icon(Icons.download, color: Colors.red.shade700)),
      if (departementList.contains('Exploitations'))
        IconButton(
            tooltip: 'Tâches',
            onPressed: () {
              Get.toNamed(TacheRoutes.tachePage);
            },
            icon: Badge(
              showBadge:
                  (notifyHeaderController.tacheItemCount >= 1) ? true : false,
              badgeContent: Text(
                  notifyHeaderController.tacheItemCount.toString(),
                  style: const TextStyle(color: Colors.white)),
              child: const Icon(Icons.work_outline),
            )),
      if (departementList.contains('Commercial'))
        IconButton(
            tooltip: 'Panier',
            onPressed: () {
              Get.toNamed(ComRoutes.comCart);
            },
            icon: Badge(
              showBadge:
                  (notifyHeaderController.cartItemCount >= 1) ? true : false,
              badgeContent: Text(
                  notifyHeaderController.cartItemCount.toString(),
                  style: const TextStyle(color: Colors.white)),
              child: const Icon(Icons.shopping_cart_outlined),
            )),
      IconButton(
          tooltip: 'Agenda',
          onPressed: () {
            Get.toNamed(MarketingRoutes.marketingAgenda);
          },
          icon: Badge(
            showBadge:
                (notifyHeaderController.agendaItemCount >= 1) ? true : false,
            badgeContent: Text(
                notifyHeaderController.agendaItemCount.toString(),
                style: const TextStyle(color: Colors.white)),
            child: Icon(Icons.note_alt_outlined,
                size: (Responsive.isDesktop(context) ? 25 : 20)),
          )),
      IconButton(
          tooltip: 'Mailling',
          onPressed: () {
            Get.toNamed(MailRoutes.mails);
          },
          icon: Badge(
            showBadge:
                (notifyHeaderController.mailsItemCount >= 1) ? true : false,
            badgeContent: Text(notifyHeaderController.mailsItemCount.toString(),
                style: const TextStyle(color: Colors.white)),
            child: Icon(Icons.mail_outline_outlined,
                size: (Responsive.isDesktop(context) ? 25 : 20)),
          )),
      if (!Responsive.isMobile(context))
        const SizedBox(
          width: p10,
        ),
      Container(
        width: 1,
        height: 22,
        color: lightGrey,
      ),
      if (!Responsive.isMobile(context))
        const SizedBox(
          width: p20,
        ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
        ),
        padding: const EdgeInsets.all(2),
        margin: const EdgeInsets.all(2),
        child: CircleAvatar(
          // backgroundColor: lightGrey,
          child: AutoSizeText(
            '$firstLettter$firstLettter2'.toUpperCase(),
            maxLines: 1,
          ),
        ),
      ),
      const SizedBox(width: p8),
      if (Responsive.isDesktop(context))
        Row(
          children: [
            InkWell(
              onTap: () {
                Get.toNamed(UserRoutes.profil);
              },
              child: AutoSizeText(
                "${profilController.user.prenom} ${profilController.user.nom}",
                maxLines: 1,
                style: bodyLarge,
              ),
            ),
          ],
        ),
      PopupMenuButton<MenuItemModel>(
        onSelected: (item) => MenuOptions().onSelected(context, item),
        itemBuilder: (context) => [
          ...MenuItems.itemsFirst.map(MenuOptions().buildItem).toList(),
          const PopupMenuDivider(),
          ...MenuItems.itemsSecond.map(MenuOptions().buildItem).toList(),
        ],
      )
    ],
    iconTheme: IconThemeData(color: dark),
    elevation: 0,
    backgroundColor: Colors.transparent,
  );
}
