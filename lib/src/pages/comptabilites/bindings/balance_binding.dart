import 'package:get/get.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/balance/balance_controller.dart'; 

class BalanceBinding extends Bindings {
  @override
  void dependencies() {
     Get.lazyPut<BalanceController>(() => BalanceController());
  }
  
}