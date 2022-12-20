// import 'package:get/get.dart'; 
// import 'package:wm_solution/src/api/notifications/commercial/prod_model_notify_api.dart';
// import 'package:wm_solution/src/api/notifications/commercial/succursale_notify_api.dart';
// import 'package:wm_solution/src/api/notifications/departements/comm_marketing_departement.dart';
// import 'package:wm_solution/src/models/notify/notify_model.dart';
// import 'package:wm_solution/src/models/notify/notify_sum_model.dart';

// class ComNotifyController extends GetxController {
//   ComDepartementNotifyApi comDepartementNotifyApi =
//       ComDepartementNotifyApi(); 
//   SuccursaleNotifyApi succursaleNotifyApi = SuccursaleNotifyApi();
//   ProdModelNotifyApi prodModelNotifyApi = ProdModelNotifyApi();


//   final _itemCommercialCount = '0'.obs;
//   String get itemCommercialCount => _itemCommercialCount.value;
  
//   final _succursaleCountDG = 0.obs;
//   int get succursaleCountDG => _succursaleCountDG.value;
//   final _succursaleCountDD = 0.obs;
//   int get succursaleCountDD => _succursaleCountDD.value;

//   final _prodModelCount = 0.obs;
//   int get prodModelCount => _prodModelCount.value;
 

//   @override
//   void onInit() {
//     super.onInit();
//     getCommercialCount();
//     getCommercialCountSuccursalesDG();
//     getCommercialCountSuccursalesDD();
//     getCommercialCountProdModelDD();
//   }


//   void getCommercialCount() async {
//     NotifySumModel notifySum =
//         await comDepartementNotifyApi.getCountCom();
//     _itemCommercialCount.value = notifySum.sum;
//     update(); 
//   } 

//   void getCommercialCountSuccursalesDG() async {
//     NotifyModel notifyModel = await succursaleNotifyApi.getCountDG(); 
//     _succursaleCountDG.value = notifyModel.count;
//     update();
     
//   }

//   void getCommercialCountSuccursalesDD() async {
//     NotifyModel notifyModel = await succursaleNotifyApi.getCountDD();
//     _succursaleCountDD.value = notifyModel.count;
//     update();
     
//   } 

//    void getCommercialCountProdModelDD() async { 
//     NotifyModel notifyModel = await prodModelNotifyApi.getCountDD();
//     _prodModelCount.value = notifyModel.count;
//     update();
     
//   } 

// }
