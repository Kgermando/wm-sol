import 'package:get/get.dart';
import 'package:wm_solution/src/models/rh/agent_model.dart';
import 'package:wm_solution/src/pages/auth/view/login_auth.dart';
import 'package:wm_solution/src/pages/auth/view/change_password_auth.dart';
import 'package:wm_solution/src/pages/auth/view/profil_auth.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/personnels/add_personnel.dart';
import 'package:wm_solution/src/pages/ressource_humaines/view/dashboard_rh.dart';
import 'package:wm_solution/src/pages/ressource_humaines/view/personnels_rh.dart';
import 'package:wm_solution/src/routes/routes.dart';

List<GetPage<dynamic>>? getPages = [
  // Settings
  // GetPage(name: SettingsRoutes.helps, page: page),
  // GetPage(name: SettingsRoutes.settings, page: page),
  // GetPage(name: SettingsRoutes.pageVerrouillage, page: page),
  // GetPage(name: SettingsRoutes.splash, page: page),

  // UserRoutes
  GetPage(name: UserRoutes.login, page: () => const LoginAuth()),
  GetPage(name: UserRoutes.logout, page: () => const LoginAuth()),
  GetPage(name: UserRoutes.profil, page: () => const ProfileAuth()),
  GetPage(name: UserRoutes.forgotPassword, page: () => const ProfileAuth()),
  GetPage(
      name: UserRoutes.changePassword, page: () => const ChangePasswordAuth()),

  // RH
  GetPage(name: RhRoutes.rhDashboard, page: () => const DashboardRH()),
  GetPage(name: RhRoutes.rhPersonnelsPage, page: () => const PersonnelsPage()),
  GetPage(
    name: RhRoutes.rhPersonnelsAdd,
    page: () {
      List<AgentModel> personnelList = Get.arguments;
      return AddPersonnel(personnelList: personnelList);
    }),
  GetPage(
    name: RhRoutes.rhPersonnelsUpdate,
    page: () {
      List<AgentModel> personnelList = Get.arguments;
      return AddPersonnel(personnelList: personnelList);
    }),

  // DevisRoutes
];
