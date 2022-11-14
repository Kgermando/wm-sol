 
import 'package:flutter/material.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';


final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();


Widget noNetworkWidget(BuildContext context) => Scaffold(
    key: scaffoldKey,
    appBar: headerBar(context, scaffoldKey, '', ''),
    drawer: const DrawerMenu(),
    body: Row(
      children: [
        Visibility(
            visible: !Responsive.isMobile(context),
            child: const Expanded(flex: 1, child: DrawerMenu())),
        Expanded(
            flex: 5,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Pas de connexion internet.", style: Theme.of(context).textTheme.headline6),
                  const SizedBox(
                    height: p20,
                  ),
                  TextButton(onPressed: () {}, child: const Text("Reessayer"))
                ],
              ),
            )),
      ],
    ));
