

import 'package:get/get.dart';
import 'package:wm_solution/src/api/notifications/devis/devis_notify_api.dart';
import 'package:wm_solution/src/models/notify/notify_model.dart';

class DevisNotifyController extends GetxController {
  final DevisNotifyApi devisNotifyApi = DevisNotifyApi();

  final _itemCountDevisDG = 0.obs;
  int get itemCountDevisDG => _itemCountDevisDG.value;
  final _itemCountDevisBudget = 0.obs;
  int get itemCountDevisBudget => _itemCountDevisBudget.value;
  final _itemCountDevisDD = 0.obs;
  int get itemCountDevisDD => _itemCountDevisDD.value;
  final _itemCountDevisFin = 0.obs;
  int get itemCountDevisFin => _itemCountDevisFin.value;
  final _itemCountDevisObs = 0.obs;
  int get itemCountDevisObs => _itemCountDevisObs.value;
 
  @override
  void onInit() {
    super.onInit(); 
    getCountDevisDG();
        getCountDevisBudget();
        getCountDevisSalaireDD();
        getCountDevisFin();
        getCountDeviseObs();
  }

  
  void getCountDevisDG() async {
    NotifyModel notifySum = await devisNotifyApi.getCountDG();
    _itemCountDevisDG.value = notifySum.count;
    update();
  }

  void getCountDevisBudget() async {
    NotifyModel notifySum = await devisNotifyApi.getCountBudget();
    _itemCountDevisBudget.value = notifySum.count;
    update();
  }

  void getCountDevisSalaireDD() async {
    NotifyModel notifySum = await devisNotifyApi.getCountDD();
    _itemCountDevisDD.value = notifySum.count;
    update();
  }

  void getCountDevisFin() async {
    NotifyModel notifySum = await devisNotifyApi.getCountFin();
    _itemCountDevisFin.value = notifySum.count;
    update();
  }

  void getCountDeviseObs() async {
    NotifyModel notifySum = await devisNotifyApi.getCountObs();
    _itemCountDevisObs.value = notifySum.count;
    update();
  }
}
