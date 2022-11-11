import 'package:get/get.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/presences/presence_personne_controller.dart';

class PrersencePersonneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PresencePersonneController>(() => PresencePersonneController());
  }
  
}