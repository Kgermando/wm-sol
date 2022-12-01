import 'package:get/get.dart';
import 'package:wm_solution/src/pages/marketing/controller/agenda/agenda_controller.dart';

class AgendaBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AgendaController>(AgendaController());
  }
}
