import 'package:get/get.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/journals/journal_livre_controller.dart'; 

class JournalLivreBinding extends Bindings {
  @override
  void dependencies() {
       Get.lazyPut<JournalLivreController>(() => JournalLivreController());

  }
  
}