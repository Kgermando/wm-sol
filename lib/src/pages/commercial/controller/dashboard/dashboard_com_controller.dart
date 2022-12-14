import 'dart:convert';

import 'package:get/get.dart';
import 'package:wm_solution/src/api/commerciale/vente_gain_api.dart';
import 'package:wm_solution/src/models/commercial/cart_model.dart';
import 'package:wm_solution/src/models/commercial/courbe_vente_gain_model.dart';
import 'package:wm_solution/src/models/commercial/vente_chart_model.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/factures/facture_creance_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/gains/gain_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/history/history_vente_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/succursale/succursale_controller.dart';

class DashboardComController extends GetxController {
  final VenteGainApi venteGainApi = VenteGainApi();
  final VenteCartController venteCartController =
      Get.put(VenteCartController());
  final GainCartController gainController = Get.put(GainCartController());
  final FactureCreanceController factureCreanceController =
      Get.put(FactureCreanceController());
  final SuccursaleController succursaleController =
      Get.put(SuccursaleController());

  List<VenteChartModel> venteChartModel = [];
  List<CourbeVenteModel> venteMouthList = [];
  List<CourbeGainModel> gainMouthList = [];
  List<CourbeVenteModel> venteYearList = [];
  List<CourbeGainModel> gainYearList = [];

  final _annuaireCount = 0.obs;
  int get annuaireCount => _annuaireCount.value;
  final _agendaCount = 0.obs;
  int get agendaCount => _agendaCount.value;
  final _succursaleCount = 0.obs;
  int get succursaleCount => _succursaleCount.value;

  final _sumGain = 0.0.obs;
  double get sumGain => _sumGain.value;
  final _sumVente = 0.0.obs;
  double get sumVente => _sumVente.value;
  final _sumDCreance = 0.0.obs;
  double get sumDCreance => _sumDCreance.value;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> getData() async {
    var getVenteChart = await VenteGainApi().getVenteChart();
    var getAllDataGainMouth = await VenteGainApi().getAllDataGainMouth();
    var getAllDataVenteMouth = await VenteGainApi().getAllDataVenteMouth();
    var getAllDataGainYear = await VenteGainApi().getAllDataGainYear();
    var getAllDataVenteYear = await VenteGainApi().getAllDataVenteYear();
    var succursales = await succursaleController.succursaleApi.getAllData();
    var gains = await gainController.gainApi.getAllData();
    var ventes = await venteCartController.venteCartApi.getAllData();
    var factureCreance =
        await factureCreanceController.creanceFactureApi.getAllData();

    venteChartModel.addAll(getVenteChart);
    venteMouthList.addAll(getAllDataVenteMouth);
    gainMouthList.addAll(getAllDataGainMouth);
    venteYearList.addAll(getAllDataVenteYear);
    gainYearList.addAll(getAllDataGainYear);

    _succursaleCount.value = succursales
        .where((element) => element.approbationDD == "Approved")
        .length;

    // Gain
    var dataGain = gains.map((e) => e.sum).toList();
    for (var data in dataGain) {
      _sumGain.value += data;
    }

    // Ventes
    var dataPriceVente =
        ventes.map((e) => double.parse(e.priceTotalCart)).toList();
    for (var data in dataPriceVente) {
      _sumVente.value += data;
    }

    // Cr??ances
    for (var item in factureCreance) {
      final cartItem = jsonDecode(item.cart) as List;
      List<CartModel> cartItemList = [];

      for (var element in cartItem) {
        cartItemList.add(CartModel.fromJson(element));
      }

      for (var data in cartItemList) {
        if (double.parse(data.quantityCart) >= double.parse(data.qtyRemise)) {
          double total =
              double.parse(data.remise) * double.parse(data.quantityCart);
          _sumDCreance.value += total;
        } else {
          double total =
              double.parse(data.priceCart) * double.parse(data.quantityCart);
          _sumDCreance.value += total;
        }
      }
    }

    update();
  }
}
