 
import 'package:get/get.dart';
import 'package:wm_solution/src/api/notifications/departements/finance_departement.dart';
import 'package:wm_solution/src/api/notifications/finances/creance_notify_api.dart';
import 'package:wm_solution/src/api/notifications/finances/dette_notify_api.dart';
import 'package:wm_solution/src/models/notify/notify_model.dart';
import 'package:wm_solution/src/models/notify/notify_sum_model.dart';

class FinanceNotifyController extends GetxController {
  FinanceDepartementNotifyApi financeDepartementNotifyApi =
      FinanceDepartementNotifyApi();
  CreanceNotifyApi creanceNotifyApi = CreanceNotifyApi();
  DetteNotifyApi detteNotifyApi = DetteNotifyApi();

  final _itemCount = '0'.obs;
  String get itemCount => _itemCount.value;
  final _itemCountObs = '0'.obs;
  String get itemCountObs => _itemCountObs.value;

  final _creanceCountDD = 0.obs;
  int get creanceCountDD => _creanceCountDD.value;
   final _creanceCountDG = 0.obs;
  int get creanceCountDG => _creanceCountDG.value;

  final _detteCountDD = 0.obs;
  int get detteCountDD => _detteCountDD.value;
    final _detteCountDG = 0.obs;
  int get detteCountDG => _detteCountDG.value;


  @override
  void onInit() {
    super.onInit();
    getCountDD();
        getCountObs();
        getCountCreanceDD();
        getCountCreanceDG();
        getCountDetteDD();
        getCountDetteDG();
  }
 

  void getCountDD() async {
    NotifySumModel notifySum =
        await financeDepartementNotifyApi.getCountFinanceDD();
    _itemCount.value = notifySum.sum;
    update();
     
  }

  void getCountObs() async {
    NotifySumModel notifySum =
        await financeDepartementNotifyApi.getCountFinanceObs();
    _itemCountObs.value = notifySum.sum;
    update();
     
  }

  void getCountCreanceDD() async {
    NotifyModel notifySum =
        await creanceNotifyApi.getCountDD();
    _creanceCountDD.value = notifySum.count;
    update();
     
  }

  void getCountCreanceDG() async {
    NotifyModel notifySum = await creanceNotifyApi.getCountDG();
    _creanceCountDG.value = notifySum.count;
    update();
     
  }

  void getCountDetteDD() async {
    NotifyModel notifySum =
        await detteNotifyApi.getCountDD();
    _detteCountDD.value = notifySum.count;
    update();
     
  }

  void getCountDetteDG() async {
    NotifyModel notifySum = await detteNotifyApi.getCountDG();
    _detteCountDG.value = notifySum.count;
    update();
     
  }
}
