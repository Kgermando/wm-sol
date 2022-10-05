import 'package:get/get.dart';
import 'package:wm_solution/src/models/rh/agent_model.dart';
import 'package:wm_solution/src/models/rh/paiement_salaire_model.dart';
import 'package:wm_solution/src/models/rh/transport_restauration_model.dart';
import 'package:wm_solution/src/pages/auth/view/login_auth.dart';
import 'package:wm_solution/src/pages/auth/view/change_password_auth.dart';
import 'package:wm_solution/src/pages/auth/view/profil_auth.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/personnels/add_personnel.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/personnels/detail_personne.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/personnels/update_personnel.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/salaires/add_salaire.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/salaires/bulletin_salaire.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/transport_restauration/detail_transport_rest.dart'; 
import 'package:wm_solution/src/pages/ressource_humaines/view/dashboard_rh.dart';
import 'package:wm_solution/src/pages/ressource_humaines/view/personnels_rh.dart';
import 'package:wm_solution/src/pages/ressource_humaines/view/salaires_rh.dart';
import 'package:wm_solution/src/pages/ressource_humaines/view/transport_restauration_rh.dart';
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
  GetPage(
      name: RhRoutes.rhPaiement,
      page: () => const SalairesRH(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
    name: RhRoutes.rhPaiementBulletin,
    page: () {
      PaiementSalaireModel salaire = Get.arguments as PaiementSalaireModel;
      return BulletinSalaire(salaire: salaire);
    },
    transition: Transition.cupertino,
    transitionDuration: const Duration(seconds: 1)),
  GetPage(
    name: RhRoutes.rhPaiementAdd,
    page: () {
      AgentModel personne = Get.arguments as AgentModel;
      return AddSalaire(personne: personne);
    },
    transition: Transition.cupertino,
    transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: RhRoutes.rhTransportRest,
      page: () => const TransportRestaurationRH(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: RhRoutes.rhTransportRestDetail,
      page: () {
        TransportRestaurationModel transportRestaurationModel =
            Get.arguments as TransportRestaurationModel;
        return DetailTransportRest(
            transportRestaurationModel: transportRestaurationModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),


  // DevisRoutes
];
