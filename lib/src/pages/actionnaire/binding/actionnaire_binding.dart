import 'package:get/get.dart';
import 'package:wm_solution/src/pages/actionnaire/controller/actionnaire_controller.dart';
import 'package:wm_solution/src/pages/actionnaire/controller/actionnaire_cotisation_controller.dart';
import 'package:wm_solution/src/pages/actionnaire/controller/actionnaire_transfert_controller.dart';

class ActionnaireBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ActionnaireController>(ActionnaireController());
    Get.put<ActionnaireCotisationController>(ActionnaireCotisationController());
    Get.put<ActionnaireTransfertController>(ActionnaireTransfertController());
  }
}
