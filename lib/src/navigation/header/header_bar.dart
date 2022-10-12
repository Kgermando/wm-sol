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
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/utils/info_system.dart';
import 'package:wm_solution/src/widgets/bread_crumb_widget.dart';
import 'package:wm_solution/src/widgets/menu_items.dart';
import 'package:wm_solution/src/widgets/menu_options.dart'; 

AppBar headerBar(
    BuildContext context, GlobalKey<ScaffoldState> scaffoldKey, String title, String subTitle) {
  final ProfilController userController = Get.put(ProfilController()); 

  final bodyLarge = Theme.of(context).textTheme.bodyLarge;

  final String firstLettter = userController.user.prenom[0];
  final String firstLettter2 = userController.user.nom[0];
  return AppBar(
    leadingWidth: 100,
    leading: !ResponsiveWidget.isSmallScreen(context)
      ? Image.asset(InfoSystem().logoSansFond(), width: 20, height: 20,)
      : Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                scaffoldKey.currentState!.openDrawer();
              }),
          IconButton(onPressed: () {
                Get.back();
              }, icon: const Icon(Icons.arrow_back)
          )
        ],
      ), 
    title: Responsive.isMobile(context) ? Container() : InkWell(
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
            BreadCrumbItem(content: BreadCrumbWidget(title: subTitle)),
          ],
            divider: const Icon(Icons.chevron_right),
        ),
      ],
    ),
    ),
    actions: [
      IconButton(
          tooltip: 'Panier',
          onPressed: () {},
          icon: Badge(
            badgeContent:
                const Text('150', style: TextStyle(color: Colors.white)),
            child: const Icon(Icons.shopping_cart),
          )),
      IconButton(
          tooltip: 'Agenda',
          onPressed: () {},
          icon: Badge(
            showBadge: true,
            badgeContent:
                const Text('6', style: TextStyle(color: Colors.white)),
            child: Icon(Icons.note_alt_outlined,
                size: (Responsive.isDesktop(context) ? 25 : 20)),
          )),
      IconButton(
          tooltip: 'Mailling',
          onPressed: () {},
          icon: Badge(
            showBadge: true,
            badgeContent:
                const Text('22', style: TextStyle(color: Colors.white)),
            child: Icon(Icons.mail_outline_outlined,
                size: (Responsive.isDesktop(context) ? 25 : 20)),
          )),
      IconButton(
          tooltip: 'Notifications',
          onPressed: () {},
          icon: Badge(
            badgeContent:
                const Text('16', style: TextStyle(color: Colors.white)),
            child: const Icon(Icons.notifications),
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
              onTap: () {},
              child: AutoSizeText(
                "${userController.user.prenom} ${userController.user.nom}",
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
