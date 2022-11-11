import 'package:get/get.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/history/history_livraison.dart'; 

class HistoryLivraisonBinding extends Bindings {
  @override
  void dependencies() {
     Get.lazyPut<HistoryLivraisonController>(() => HistoryLivraisonController());
  }
  
}