import 'package:get/get.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/journals/journal_controller.dart'; 

class JournalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JournalController>(() => JournalController());     
  }
  
}