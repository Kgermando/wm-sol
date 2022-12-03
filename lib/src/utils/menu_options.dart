import 'package:flutter/material.dart'; 
import 'package:get/get.dart';
import 'package:wm_solution/src/models/menu_item.dart';
import 'package:wm_solution/src/pages/auth/controller/login_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/utils/menu_items.dart';

class MenuOptions {
  PopupMenuItem<MenuItemModel> buildItem(MenuItemModel item) => PopupMenuItem(
      value: item,
      child: Row(
        children: [
          Icon(item.icon, size: 20),
          const SizedBox(width: 12),
          Text(item.text)
        ],
      ));

  void onSelected(BuildContext context, MenuItemModel item) async {
    final LoginController controller = Get.put(LoginController());

    switch (item) {
      case MenuItems.itemProfile:
        Get.toNamed(UserRoutes.profil); 
        break;

      case MenuItems.itemHelp:
        Get.toNamed(SettingsRoutes.helps);
        break;

      case MenuItems.itemSettings:
        Get.toNamed(SettingsRoutes.settings);
        break;

      case MenuItems.itemLogout:
        controller.logout();  
        // Phoenix.rebirth(context);
    }
  }
}
