import 'package:get/get.dart';
import 'package:wm_solution/src/pages/personnels_roles/controller/personnels_roles_controller.dart';

class PersonnelsRoleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonnelsRolesController>(() => PersonnelsRolesController());
  }
}
