import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/models/menu_item.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/menu_items.dart';

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
    switch (item) {
      case MenuItems.itemProfile:
        Navigator.pushNamed(context, UserRoutes.profil);
        break;

      case MenuItems.itemHelp:
        Navigator.pushNamed(context, SettingsRoutes.helps);
        break;

      case MenuItems.itemSettings:
        Navigator.pushNamed(context, SettingsRoutes.settings);
        break;

      case MenuItems.itemLogout:
        Get.offAllNamed(UserRoutes.login);
      // Remove stockage jwt here.
      // await AuthApi().getUserId().then((user) async {
      //   final userModel = UserModel(
      //       id: user.id,
      //       nom: user.nom,
      //       prenom: user.prenom,
      //       email: user.email,
      //       telephone: user.telephone,
      //       matricule: user.matricule,
      //       departement: user.departement,
      //       servicesAffectation: user.servicesAffectation,
      //       fonctionOccupe: user.fonctionOccupe,
      //       role: user.role,
      //       isOnline: 'false',
      //       createdAt: user.createdAt,
      //       passwordHash: user.passwordHash,
      //       succursale: user.succursale);
      //   await UserApi().updateData(userModel);
      //   await AuthApi().logout().then((value) {
      //     UserSharedPref().removeIdToken();
      //     UserSharedPref().removeAccessToken();
      //     UserSharedPref().removeRefreshToken();
      //     // Phoenix.rebirth(context);Phoenix.rebirth(context); // Il genere un probleme de deconnection
      //     Navigator.pushNamed(context, UserRoutes.logout);
      //   });
      // });
    }
  }
}
