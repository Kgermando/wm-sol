import 'package:get/get.dart'; 
import 'package:wm_solution/src/api/notifications/comptabilite/bilan_notify_api.dart';
import 'package:wm_solution/src/api/notifications/comptabilite/compte_resultat_notify_api.dart'; 
import 'package:wm_solution/src/api/notifications/departements/comptabilite_departement.dart';
import 'package:wm_solution/src/models/notify/notify_model.dart';
import 'package:wm_solution/src/models/notify/notify_sum_model.dart';

class ComptabiliteNotifyController extends GetxController {
  ComptabiliteDepartementNotifyApi comptabiliteDepartementNotifyApi =
      ComptabiliteDepartementNotifyApi();
  BilanNotifyApi bilanNotifyApi = BilanNotifyApi(); 
  CompteResultatNotifyApi compteResultatNotifyApi = CompteResultatNotifyApi(); 

  final _itemCount = '0'.obs;
  String get itemCount => _itemCount.value;

  final _bilanCount = 0.obs;
  int get bilanCount => _bilanCount.value;
  final _compteResultatCount = 0.obs;
  int get compteResultatCount => _compteResultatCount.value; 
 
 
  @override
  void onInit() {
    super.onInit();
    getCountComptabilite();
        getCountBilanDD();
        getCountCompteResultatDD(); 
  }

 
  
  void getCountComptabilite() async {
    NotifySumModel notifySum =
        await comptabiliteDepartementNotifyApi.getCountComptabilite();
    _itemCount.value = notifySum.sum;
    update(); 
  }

  void getCountBilanDD() async {
    NotifyModel notifySum = await bilanNotifyApi.getCountDD();
    _bilanCount.value = notifySum.count;
    update(); 
  }
 

  void getCountCompteResultatDD() async {
    NotifyModel notifySum = await compteResultatNotifyApi.getCountDD();
    _compteResultatCount.value = notifySum.count;
    update(); 
  }
 
}
