import 'dart:convert';

import 'package:get/get.dart';
import 'package:wm_solution/src/api/comm_marketing/commerciale/vente_gain_api.dart';
import 'package:wm_solution/src/models/comm_maketing/cart_model.dart';
import 'package:wm_solution/src/models/comm_maketing/courbe_vente_gain_model.dart';
import 'package:wm_solution/src/models/comm_maketing/vente_chart_model.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/factures/facture_creance_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/gains/gain_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/history/history_vente_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/succursale/succursale_controller.dart';
import 'package:wm_solution/src/pages/marketing/controller/agenda/agenda_controller.dart';
import 'package:wm_solution/src/pages/marketing/controller/annuaire/annuaire_controller.dart'; 

class DashboardComController extends GetxController {
  final VenteGainApi venteGainApi = VenteGainApi();
  final VenteCartController venteCartController =
      Get.put(VenteCartController());
  final GainController gainController = Get.put(GainController());
  final FactureCreanceController factureCreanceController =
      Get.put(FactureCreanceController()); 
  final AnnuaireController annuaireController = Get.put(AnnuaireController());
  final AgendaController agendaController = Get.put(AgendaController());
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
   
    _succursaleCount.value = succursaleController.succursaleList
        .where((element) => element.approbationDD == "Approved")
        .length;

    _annuaireCount.value = annuaireController.annuaireList.length;
    _agendaCount.value = agendaController.agendaList.length;

    // Gain

    var dataGain = gainController.gainList.map((e) => e.sum).toList();
    for (var data in dataGain) {
      _sumGain.value += data;
    }

    // Ventes

    var dataPriceVente = venteCartController.livraisonHistoryVenteCartList
        .map((e) => double.parse(e.priceTotalCart))
        .toList();
    for (var data in dataPriceVente) {
      _sumVente.value += data;
    }

    // Créances

    for (var item in factureCreanceController.creanceFactureList) {
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
  }

  Future<void> getData() async {
    var getVenteChart = await VenteGainApi().getVenteChart();
    var getAllDataGainMouth = await VenteGainApi().getAllDataGainMouth();
    var getAllDataVenteMouth = await VenteGainApi().getAllDataVenteMouth();
    var getAllDataGainYear = await VenteGainApi().getAllDataGainYear();
    var getAllDataVenteYear = await VenteGainApi().getAllDataVenteYear();

    venteChartModel.assignAll(getVenteChart);
    venteMouthList.assignAll(getAllDataVenteMouth);
    gainMouthList.assignAll(getAllDataGainMouth);
    venteYearList.assignAll(getAllDataVenteYear);
    gainYearList.assignAll(getAllDataGainYear);
  }
}
