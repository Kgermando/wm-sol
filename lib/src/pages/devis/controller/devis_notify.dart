

import 'package:get/get.dart';
import 'package:wm_solution/src/api/notifications/devis/devis_notify_api.dart';
import 'package:wm_solution/src/models/notify/notify_model.dart';

class DevisNotifyController extends GetxController {
  final DevisNotifyApi devisNotifyApi = DevisNotifyApi();

  final _itemLogCountDevisDG = 0.obs;
  int get itemLogCountDevisDG => _itemLogCountDevisDG.value;
  final _itemLogCountDevisBudget = 0.obs;
  int get itemLogCountDevisBudget => _itemLogCountDevisBudget.value;
  final _itemLogCountDevisDD = 0.obs;
  int get itemLogCountDevisDD => _itemLogCountDevisDD.value;
  final _itemLogCountDevisFin = 0.obs;
  int get itemLogCountDevisFin => _itemLogCountDevisFin.value;
  final _itemLogCountDevisObs = 0.obs;
  int get itemLogCountDevisObs => _itemLogCountDevisObs.value;
 
  @override
  void onInit() {
    super.onInit(); 
    getLogCountDevisDG();
    getLogCountDevisBudget();
    getLogCountDevisSalaireDD();
    getLogCountDevisFin();
    getLogCountDeviseObs();
  }

  
  void getLogCountDevisDG() async {
    NotifyModel notifySum = await devisNotifyApi.getCountDG();
    _itemLogCountDevisDG.value = notifySum.count;
    update();
  }

  void getLogCountDevisBudget() async {
    NotifyModel notifySum = await devisNotifyApi.getCountBudget();
    _itemLogCountDevisBudget.value = notifySum.count;
    update();
  }

  void getLogCountDevisSalaireDD() async {
    NotifyModel notifySum = await devisNotifyApi.getCountDD();
    _itemLogCountDevisDD.value = notifySum.count;
    update();
  }

  void getLogCountDevisFin() async {
    NotifyModel notifySum = await devisNotifyApi.getCountFin();
    _itemLogCountDevisFin.value = notifySum.count;
    update();
  }

  void getLogCountDeviseObs() async {
    NotifyModel notifySum = await devisNotifyApi.getCountObs();
    _itemLogCountDevisObs.value = notifySum.count;
    update();
  }
}
