import 'package:get/get.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/balance/balance_ref_controller.dart'; 

class BalanceRefBinding extends Bindings {
  @override
  void dependencies() {
     Get.lazyPut<BalanceRefController>(() => BalanceRefController());
  }
  
}