import 'package:get/get.dart'; 
import 'package:wm_solution/src/api/notifications/comm_marketing/prod_model_notify_api.dart';
import 'package:wm_solution/src/api/notifications/comm_marketing/succursale_notify_api.dart';
import 'package:wm_solution/src/api/notifications/departements/comm_marketing_departement.dart';
import 'package:wm_solution/src/models/notify/notify_model.dart';
import 'package:wm_solution/src/models/notify/notify_sum_model.dart';

class ComNotifyController extends GetxController {
  ComDepartementNotifyApi comDepartementNotifyApi =
      ComDepartementNotifyApi(); 
  SuccursaleNotifyApi succursaleNotifyApi = SuccursaleNotifyApi();
  ProdModelNotifyApi prodModelNotifyApi = ProdModelNotifyApi();


  final _itemCount = '0'.obs;
  String get itemCount => _itemCount.value;
  
  final _succursaleCountDG = 0.obs;
  int get succursaleCountDG => _succursaleCountDG.value;
  final _succursaleCountDD = 0.obs;
  int get succursaleCountDD => _succursaleCountDD.value;

  final _prodModelCount = 0.obs;
  int get prodModelCount => _prodModelCount.value;
 
    @override
  void onInit() {
    super.onInit();
    getCountCom();  
    getCountSuccursalesDG();
    getCountSuccursalesDD();
    getCountProdModelDD();
  }
 
  void getCountCom() async {
    NotifySumModel notifySum =
        await comDepartementNotifyApi.getCountCom();
    _itemCount.value = notifySum.sum;
    update();
     
  } 

  void getCountSuccursalesDG() async {
    NotifyModel notifyModel = await succursaleNotifyApi.getCountDG(); 
    _succursaleCountDG.value = notifyModel.count;
    update();
     
  }

  void getCountSuccursalesDD() async {
    NotifyModel notifyModel = await succursaleNotifyApi.getCountDD();
    _succursaleCountDD.value = notifyModel.count;
    update();
     
  } 

   void getCountProdModelDD() async { 
    NotifyModel notifyModel = await prodModelNotifyApi.getCountDD();
    _prodModelCount.value = notifyModel.count;
    update();
     
  } 

}
