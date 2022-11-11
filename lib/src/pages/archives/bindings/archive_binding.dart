import 'package:get/get.dart';
import 'package:wm_solution/src/pages/archives/controller/archive_controller.dart'; 

class ArchiveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ArchiveController>(() => ArchiveController());
  }
  
}