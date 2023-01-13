import 'package:get/get.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/cart/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CartController>(CartController());
  }
}
