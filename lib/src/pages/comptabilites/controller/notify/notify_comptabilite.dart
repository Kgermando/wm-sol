import 'package:get/get.dart';
import 'package:wm_solution/src/api/notifications/departements/comptabilite_departement.dart';
import 'package:wm_solution/src/models/notify/notify_sum_model.dart';

class ComptabiliteNotifyController extends GetxController {
  ComptabiliteDepartementNotifyApi comptabiliteDepartementNotifyApi =
      ComptabiliteDepartementNotifyApi();

  final _itemCount = '0'.obs;
  String get itemCount => _itemCount.value;

  @override
  void onInit() {
    super.onInit();
    getCountComptabilite(); 
  }

  void getCountComptabilite() async {
    NotifySumModel notifySum = await comptabiliteDepartementNotifyApi.getCountComptabilite();
    _itemCount.value = notifySum.sum;
  }

}
