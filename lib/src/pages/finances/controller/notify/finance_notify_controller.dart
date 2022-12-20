 
// import 'package:get/get.dart';
// import 'package:wm_solution/src/api/notifications/departements/finance_departement.dart';
// import 'package:wm_solution/src/api/notifications/finances/creance_notify_api.dart';
// import 'package:wm_solution/src/api/notifications/finances/dette_notify_api.dart';
// import 'package:wm_solution/src/models/notify/notify_model.dart';
// import 'package:wm_solution/src/models/notify/notify_sum_model.dart';

// class FinanceNotifyController extends GetxController {
//   FinanceDepartementNotifyApi financeDepartementNotifyApi =
//       FinanceDepartementNotifyApi();
//   CreanceNotifyApi creanceNotifyApi = CreanceNotifyApi();
//   DetteNotifyApi detteNotifyApi = DetteNotifyApi();

//   final _itemFinanceCount = '0'.obs;
//   String get itemFinanceCount => _itemFinanceCount.value;
//   final _itemFinanceCountObs = '0'.obs;
//   String get itemFinanceCountObs => _itemFinanceCountObs.value;

//   final _creanceCountDD = 0.obs;
//   int get creanceCountDD => _creanceCountDD.value;
//    final _creanceCountDG = 0.obs;
//   int get creanceCountDG => _creanceCountDG.value;

//   final _detteCountDD = 0.obs;
//   int get detteCountDD => _detteCountDD.value;
//     final _detteCountDG = 0.obs;
//   int get detteCountDG => _detteCountDG.value;


//   @override
//   void onInit() {
//     super.onInit();
    // getFinanceCountDD();
    // getFinanceCountObs();
    // getFinanceCountCreanceDD();
    // getFinanceCountCreanceDG();
    // getFinanceCountDetteDD();
    // getFinanceCountDetteDG();
//   }
 

//   void getFinanceCountDD() async {
//     NotifySumModel notifySum =
//         await financeDepartementNotifyApi.getCountFinanceDD();
//     _itemFinanceCount.value = notifySum.sum;
//     update();
     
//   }

//   void getFinanceCountObs() async {
//     NotifySumModel notifySum =
//         await financeDepartementNotifyApi.getCountFinanceObs();
//     _itemFinanceCountObs.value = notifySum.sum;
//     update();
     
//   }

//   void getFinanceCountCreanceDD() async {
//     NotifyModel notifySum =
//         await creanceNotifyApi.getCountDD();
//     _creanceCountDD.value = notifySum.count;
//     update();
     
//   }

//   void getFinanceCountCreanceDG() async {
//     NotifyModel notifySum = await creanceNotifyApi.getCountDG();
//     _creanceCountDG.value = notifySum.count;
//     update();
     
//   }

//   void getFinanceCountDetteDD() async {
//     NotifyModel notifySum =
//         await detteNotifyApi.getCountDD();
//     _detteCountDD.value = notifySum.count;
//     update();
     
//   }

//   void getFinanceCountDetteDG() async {
//     NotifyModel notifySum = await detteNotifyApi.getCountDG();
//     _detteCountDG.value = notifySum.count;
//     update();
     
//   }
// }
