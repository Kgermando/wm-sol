import 'package:get/get.dart';
import 'package:wm_solution/src/pages/auth/controller/forgot_controller.dart';
import 'package:wm_solution/src/pages/auth/controller/change_password_controller.dart';
import 'package:wm_solution/src/pages/auth/controller/login_controller.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/personnels_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/salaire_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/transport_rest_person_controller.dart'; 

class WMBindings extends Bindings {
  @override
  void dependencies() {

    // Authentification
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<ProfilController>(() => ProfilController());
    Get.lazyPut<ChangePasswordController>(() => ChangePasswordController());
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());


    // RH
    Get.lazyPut<PersonnelsController>(() => PersonnelsController());
    Get.lazyPut<SalaireController>(() => SalaireController());
    Get.lazyPut<TransportRestPersonnelsController>(() => TransportRestPersonnelsController());
    
  }
}
