import 'package:get/get.dart';
import 'package:wm_solution/src/pages/archives/controller/archive_folder_controller.dart'; 

class ArchiveFolderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ArchiveFolderController>(() => ArchiveFolderController());
  }
  
}