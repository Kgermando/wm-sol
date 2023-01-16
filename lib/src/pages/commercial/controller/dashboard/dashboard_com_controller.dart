import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:wm_solution/src/api/commerciale/commercial/vente_gain_api.dart';
import 'package:wm_solution/src/models/commercial/cart_model.dart';
import 'package:wm_solution/src/models/commercial/courbe_vente_gain_model.dart';
import 'package:wm_solution/src/models/commercial/vente_chart_model.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/factures/facture_creance_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/gains/gain_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/history/history_vente_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/succursale/succursale_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/suivi_controle/entreprise_infos_controller.dart';

class DashboardComController extends GetxController {
  final VenteGainApi venteGainApi = VenteGainApi();
  final VenteCartController venteCartController =
      Get.put(VenteCartController());
  final GainCartController gainController = Get.put(GainCartController());
  final FactureCreanceController factureCreanceController =
      Get.put(FactureCreanceController());
  final SuccursaleController succursaleController =
      Get.put(SuccursaleController());
  final EntrepriseInfosController entrepriseInfosController =
      Get.put(EntrepriseInfosController());

  // 10 produits le plus vendu
  List<VenteChartModel> venteChartList = [];

  List<CourbeVenteModel> venteDayList = []; 
  List<CourbeGainModel> gainDayList = [];

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

  final _entrepriseInfosCount = 0.obs;
  int get entrepriseInfosCount => _entrepriseInfosCount.value;
  final _entrepriseInfosActiveCount = 0.obs;
  int get entrepriseInfosActiveCount => _entrepriseInfosActiveCount.value;
  final _entrepriseCount = 0.obs;
  int get entrepriseCount => _entrepriseCount.value;
  final _particulierCount = 0.obs;
  int get particulierCount => _particulierCount.value;
  final _ongAsblCount = 0.obs;
  int get ongAsblCount => _ongAsblCount.value;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> getData() async {
    var getVenteChart = await VenteGainApi().getVenteChart();

    var getAllDataVenteDay = await VenteGainApi().getAllDataVenteDay();
    var getAllDataGainDay = await VenteGainApi().getAllDataGainDay();
    
    var getAllDataVenteMouth = await VenteGainApi().getAllDataVenteMouth();
    var getAllDataGainMouth = await VenteGainApi().getAllDataGainMouth();
    
    var getAllDataVenteYear = await VenteGainApi().getAllDataVenteYear();
    var getAllDataGainYear = await VenteGainApi().getAllDataGainYear();
    
    var succursales = await succursaleController.succursaleApi.getAllData();
    var gains = await gainController.gainApi.getAllData();
    var ventes = await venteCartController.venteCartApi.getAllData();
    var factureCreance =
        await factureCreanceController.creanceFactureApi.getAllData();

    // Suivis & Controlle
    var entreprise =
        await entrepriseInfosController.entrepriseInfoApi.getAllData();

    _entrepriseInfosCount.value = entreprise.length;
    _entrepriseInfosActiveCount.value =
        entreprise.where((element) => DateTime.now().isBefore(element.dateFinContrat)).length;

    _entrepriseCount.value = entreprise
        .where((element) => element.typeEntreprise == 'Entreprise')
        .length;
    _particulierCount.value = entreprise
        .where((element) => element.typeEntreprise == 'Particulier')
        .length;
    _ongAsblCount.value = entreprise
        .where((element) => element.typeEntreprise == 'ONG & ASBL')
        .length;

    venteChartList.addAll(getVenteChart);
    venteDayList.addAll(getAllDataVenteDay);
    gainDayList.addAll(getAllDataGainDay);
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

    // Créances
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
