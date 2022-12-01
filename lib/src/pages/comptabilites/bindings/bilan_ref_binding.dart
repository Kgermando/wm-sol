import 'package:get/get.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/bilans/compte_bilan_ref_controller.dart';

class BilanRefBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CompteBilanRefController>(CompteBilanRefController());
  }
}
