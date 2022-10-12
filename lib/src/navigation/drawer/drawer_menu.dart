import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/navigation/drawer/components/budget_nav.dart';
import 'package:wm_solution/src/navigation/drawer/components/comptabilite_nav.dart'; 
import 'package:wm_solution/src/navigation/drawer/components/rh_nav.dart';
import 'package:wm_solution/src/utils/info_system.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentRoute = Get.currentRoute;
    return Drawer(
      child: ListView(
        shrinkWrap: true,
        children: [
          DrawerHeader(
              child: Image.asset(
            InfoSystem().logo(),
            width: 100,
            height: 100,
          )),
          RhNav(currentRoute: currentRoute),
          BudgetNav(currentRoute: currentRoute),
          ComptabiliteNav(currentRoute: currentRoute),
        ],
      ),
    );
  }
}


// class DrawerMenu extends StatefulWidget {
//   const DrawerMenu({Key? key, this.controller}) : super(key: key);
//   final PageController? controller;

//   @override
//   State<DrawerMenu> createState() => _DrawerMenuState();
// }

// class _DrawerMenuState extends State<DrawerMenu> {
//   final ScrollController controller = ScrollController();
//   late Future<UserModel> dataFuture;
//   @override
//   void initState() {
//     dataFuture = getData();
//     super.initState();
//   }

//   Future<UserModel> getData() async {
//     UserModel userModel = await AuthApi().getUserId();
//     return userModel;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     String? pageCurrente = ModalRoute.of(context)!.settings.name;
//     if (kDebugMode) {
//       print('pageCurrente $pageCurrente');
//     }
//     return Drawer(
//       backgroundColor:
//           themeProvider.isLightMode ? Colors.amber[100] : Colors.black26,
//       elevation: 10.0,
//       child: FutureBuilder<UserModel>(
//           future: dataFuture,
//           builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
//             if (snapshot.hasData) {
//               UserModel? user = snapshot.data;
//               int userRole = int.parse(user!.role);
//               return Scrollbar(
//                 controller: controller,
//                 child: ListView(
//                   controller: controller,
//                   children: [
//                     DrawerHeader(
//                       child: Image.asset(
//                       InfoSystem().logo(),
//                       width: 100,
//                       height: 100,
//                     )),
//                     if (user.departement == 'Administration' ||
//                         user.departement == 'Support')
//                       if (pageCurrente != null)
//                         AdministrationNav(
//                             pageCurrente: pageCurrente, user: user),
//                     if (user.departement == 'Ressources Humaines' ||
//                         user.departement == 'Administration' ||
//                         user.departement == 'Support')
//                       if (pageCurrente != null)
//                         RhNav(pageCurrente: pageCurrente, user: user),
//                     if (user.departement == 'Budgets' ||
//                         user.departement == 'Administration' ||
//                         user.departement == 'Support')
//                       if (pageCurrente != null)
//                         BudgetNav(pageCurrente: pageCurrente, user: user),
//                     if (user.departement == 'Finances' ||
//                         user.departement == 'Administration' ||
//                         user.departement == 'Support')
//                       if (pageCurrente != null)
//                         FinancesNav(pageCurrente: pageCurrente, user: user),
//                     if (user.departement == 'Comptabilites' ||
//                         user.departement == 'Administration' ||
//                         user.departement == 'Support')
//                       if (pageCurrente != null)
//                         ComptabiliteNav(pageCurrente: pageCurrente, user: user),
//                     if (user.departement == 'Exploitations' ||
//                         user.departement == 'Administration' ||
//                         user.departement == 'Support')
//                       if (pageCurrente != null)
//                         ExploitationNav(pageCurrente: pageCurrente, user: user),
//                     if (user.departement == 'Commercial et Marketing' ||
//                         user.departement == 'Administration' ||
//                         user.departement == 'Support')
//                       if (pageCurrente != null)
//                         ComMarketing(pageCurrente: pageCurrente, user: user),
//                     if (user.departement == 'Logistique' ||
//                         user.departement == 'Administration' ||
//                         user.departement == 'Support')
//                       if (pageCurrente != null)
//                         LogistiqueNav(pageCurrente: pageCurrente, user: user),
//                     if (user.departement == 'Actionnaire' ||
//                         user.departement == 'Administration' ||
//                         user.departement == 'Support')
//                       if (pageCurrente != null)
//                         ActionnaireNav(pageCurrente: pageCurrente, user: user),
//                     if (userRole <= 1)
//                       UpdateNav(pageCurrente: pageCurrente!, user: user)
//                   ],
//                 ),
//               );
//             } else {
//               return Column(
//                 children: [
//                   const SizedBox(height: p20),
//                   loading(),
//                   const SizedBox(height: p20)
//                 ],
//               );
//             }
//           }),
//     );
//   }
// }
