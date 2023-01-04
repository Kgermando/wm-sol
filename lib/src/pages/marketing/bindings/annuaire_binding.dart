import 'package:get/get.dart';
import 'package:wm_solution/src/pages/marketing/controller/annuaire/annuaire_controller.dart';
import 'package:wm_solution/src/pages/marketing/controller/annuaire/annuaire_pie_controller.dart';

class AnnuaireBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AnnuaireController>(AnnuaireController());
    Get.put<AnnuairePieController>(AnnuairePieController());
  }
}
