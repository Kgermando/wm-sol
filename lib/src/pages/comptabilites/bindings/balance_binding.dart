import 'package:get/get.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/balance/balance_chart_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/balance/balance_chart_pie_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/balance/balance_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/balance/balance_sum_controller.dart'; 

class BalanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BalanceController>(() => BalanceController());
    Get.lazyPut<BalanceSumController>(() => BalanceSumController());
    Get.lazyPut<BalanceChartController>(() => BalanceChartController());
    Get.lazyPut<BalanceChartPieController>(() => BalanceChartPieController());
  }
  
}