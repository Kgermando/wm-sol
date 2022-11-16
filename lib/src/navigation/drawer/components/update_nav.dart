import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/models/users/user_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_widget.dart'; 
import 'package:wm_solution/src/routes/routes.dart';

class UpdateNav extends StatelessWidget {
  const UpdateNav(
      {super.key, required this.currentRoute, required this.user});
  final String currentRoute;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return DrawerWidget(
      selected: currentRoute == UpdateRoutes.updatePage,
      icon: Icons.update,
      sizeIcon: 20.0,
      title: 'Update',
      style: bodyMedium!,
      onTap: () {
        Get.toNamed(UpdateRoutes.updatePage);
      });
  }
}
