import 'package:get/get.dart'; 
import 'package:wm_solution/src/pages/finances/controller/notify/observation_notify_controller.dart';

class ObservationNotifyBinding extends Bindings {
  @override
  void dependencies() {
        Get.lazyPut<ObservationNotifyController>(
        () => ObservationNotifyController());
  }
}
