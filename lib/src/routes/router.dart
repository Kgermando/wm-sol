import 'package:get/get.dart';
import 'package:wm_solution/src/models/rh/agent_model.dart';
import 'package:wm_solution/src/pages/auth/view/login_auth.dart';
import 'package:wm_solution/src/pages/auth/view/change_password_auth.dart';
import 'package:wm_solution/src/pages/auth/view/profil_auth.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/personnels/add_personnel.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/personnels/detail_personne.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/personnels/update_personnel.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/personnels_controller.dart';
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
  GetPage(name: RhRoutes.rhDashboard, 
    page: () => const DashboardRH(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(seconds: 1)
  ),
  GetPage(
    name: RhRoutes.rhPersonnelsPage, 
    page: () => const PersonnelsPage(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(seconds: 1)
  ),
  GetPage(
      name: RhRoutes.rhPersonnelsAdd,
      page: () {
        List<AgentModel> personnelList = Get.arguments as List<AgentModel>;
        return AddPersonnel(personnelList: personnelList);
      }),
  GetPage(
    name: RhRoutes.rhPersonnelsDetail,
    page: () { 
      AgentModel personne = Get.arguments as AgentModel; 
      return DetailPersonne(personne: personne);
    },
    transition: Transition.cupertino,
    transitionDuration: const Duration(seconds: 1)
  ),
  GetPage(
    name: RhRoutes.rhPersonnelsUpdate,
    page: () {
      AgentModel personne = Get.arguments as AgentModel;
      return UpdatePersonnel(personne: personne);
    },
    transition: Transition.cupertino,
    transitionDuration: const Duration(seconds: 1)
  ),

  // DevisRoutes
];
