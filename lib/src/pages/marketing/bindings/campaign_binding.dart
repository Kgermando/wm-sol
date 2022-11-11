import 'package:get/get.dart';
import 'package:wm_solution/src/pages/marketing/controller/campaigns/compaign_controller.dart'; 

class CampaignBinding extends Bindings {
  @override
  void dependencies() {
  Get.lazyPut<CampaignController>(() => CampaignController());   
  }
  
}