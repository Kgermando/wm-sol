import 'package:get/get.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/performences/performence_note_controller.dart';

class PerformenceNoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PerformenceNoteController>(PerformenceNoteController());
  }
}
