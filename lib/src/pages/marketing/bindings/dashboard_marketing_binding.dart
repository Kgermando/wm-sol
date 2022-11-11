import 'package:get/get.dart'; 
import 'package:wm_solution/src/pages/marketing/controller/dahboard/dashboard_marketing_controller.dart'; 

class DashboardMarketingBinding extends Bindings {
  @override
  void dependencies() {
   Get.lazyPut<DashboardMarketingController>(
        () => DashboardMarketingController());
  }
  
}