import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/dd_rh/users_actifs/table_users_actifs.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/personnels/user_actif_controller.dart';  
import 'package:wm_solution/src/widgets/loading.dart';


class UsersActifPage extends StatefulWidget {
  const UsersActifPage({super.key});

  @override
  State<UsersActifPage> createState() => _UsersActifPageState();
}

class _UsersActifPageState extends State<UsersActifPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Ressources Humaines";
  String subTitle = "Utilisateurs actifs";

  @override
  Widget build(BuildContext context) {
    final UsersController controller = Get.find();

    return Scaffold(
        key: scaffoldKey,
        appBar: headerBar(context, scaffoldKey, title, subTitle),
        drawer: const DrawerMenu(), 
        body: Row(
            children: [
              Visibility(
                  visible: !Responsive.isMobile(context),
                  child: const Expanded(flex: 1, child: DrawerMenu())),
              Expanded(
                flex: 5,
                child:controller.obx(
          onLoading: loadingPage(context),
          onEmpty: const Text('Aucune donnée'),
          onError: (error) => loadingError(context, error!),
          (state) => Container(
                    margin: const EdgeInsets.only(
                        top: p20, right: p20, left: p20, bottom: p8),
                    decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(20))),
                    child: TableUsersActifs(usersController: controller)
                  )) 
                ),
            ],
          )
        
        );
  }
}