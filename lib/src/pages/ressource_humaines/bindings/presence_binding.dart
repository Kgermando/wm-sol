import 'package:get/get.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/presences/presence_controller.dart';

class PresenceBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PresenceController>(PresenceController());
  }
}
