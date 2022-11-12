import 'package:get/get.dart';
import 'package:wm_solution/src/api/notifications/departements/rh_departement.dart';
import 'package:wm_solution/src/api/notifications/rh/salaires_notify_api.dart';
import 'package:wm_solution/src/api/notifications/rh/trans_rest_notify_api.dart';
import 'package:wm_solution/src/models/notify/notify_model.dart';
import 'package:wm_solution/src/models/notify/notify_sum_model.dart';

class RHNotifyController extends GetxController {
  RhDepartementNotifyApi rhDepartementNotifyApi = RhDepartementNotifyApi();

  SalaireNotifyApi salaireNotifyApi = SalaireNotifyApi();
  TransRestNotifyApi transRestNotifyApi = TransRestNotifyApi();

  final _itemCount = '0'.obs;
  String get itemCount => _itemCount.value;
 
  // Salaire
  final _itemCountSalaireBudget = 0.obs;
  int get itemCountSalaireBudget => _itemCountSalaireBudget.value;
  final _itemCountSalaireDD = 0.obs;
  int get itemCountSalaireDD => _itemCountSalaireDD.value;
  final _itemCountSalaireFin = 0.obs;
  int get itemCountSalaireFin => _itemCountSalaireFin.value;

  // Observation
  final _itemCountSalaireObs = 0.obs;
  int get itemCountSalaireObs => _itemCountSalaireObs.value;
  final _itemCountTransRestObs = 0.obs;
  int get itemCountTransRestObs => _itemCountTransRestObs.value;

  // TransRest
  final _itemCountTransRestDG = 0.obs;
  int get itemCountTransRestDG => _itemCountTransRestDG.value;
  final _itemCountTransRestBudget = 0.obs;
  int get itemCountTransRestBudget => _itemCountTransRestBudget.value;
  final _itemCountTransRestDD = 0.obs;
  int get itemCountTransRestDD => _itemCountTransRestDD.value;
  final _itemCountTransRestFin = 0.obs;
  int get itemCountTransRestFin => _itemCountTransRestFin.value;




  @override
  void onInit() {
    super.onInit();
    getCountRh();
    getCountSalaireBudget();
    getCountSalaireDD();
    getCountSalaireFin();
    getCountSalaireObs();
    getCountTransRestDG();
    getCountTransRestBudget();
    getCountTransRestSalaireDD();
    getCountTransRestFin();
    getCountTransResteObs();
  }
 
  void getCountRh() async {
    NotifySumModel notifySum = await rhDepartementNotifyApi.getCountRh();
    _itemCount.value = notifySum.sum;
    update();
  }

  // salaire
  void getCountSalaireBudget() async {
    NotifyModel notifySum = await salaireNotifyApi.getCountBudget();
    _itemCountSalaireBudget.value = notifySum.count;
    update();
  }

  void getCountSalaireDD() async {
    NotifyModel notifySum = await salaireNotifyApi.getCountDD();
    _itemCountSalaireDD.value = notifySum.count;
    update();
  }

  void getCountSalaireFin() async {
    NotifyModel notifySum = await salaireNotifyApi.getCountFin();
    _itemCountSalaireFin.value = notifySum.count;
    update();
  }

  void getCountSalaireObs() async {
    NotifyModel notifySum = await salaireNotifyApi.getCountObs();
    _itemCountSalaireObs.value = notifySum.count;
    update();
  }

  // transRest
  void getCountTransRestDG() async {
    NotifyModel notifySum = await transRestNotifyApi.getCountDG();
    _itemCountTransRestDG.value = notifySum.count;
    update();
  }

  void getCountTransRestBudget() async {
    NotifyModel notifySum = await transRestNotifyApi.getCountBudget();
    _itemCountTransRestBudget.value = notifySum.count;
  }

  void getCountTransRestSalaireDD() async {
    NotifyModel notifySum = await transRestNotifyApi.getCountDD();
    _itemCountTransRestDD.value = notifySum.count;
    update();
  }

  void getCountTransRestFin() async {
    NotifyModel notifySum = await transRestNotifyApi.getCountFin();
    _itemCountTransRestFin.value = notifySum.count;
    update();
  }

  void getCountTransResteObs() async {
    NotifyModel notifySum = await transRestNotifyApi.getCountObs();
    _itemCountTransRestObs.value = notifySum.count;
    update();
  }
}
