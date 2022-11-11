import 'package:get/get.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/stock_global/stock_global_controller.dart'; 

class StockGlobalBinding extends Bindings {
  @override
  void dependencies() {
       Get.lazyPut<StockGlobalController>(() => StockGlobalController());  
  }
  
}