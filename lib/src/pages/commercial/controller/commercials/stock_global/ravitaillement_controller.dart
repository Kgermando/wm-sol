import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/models/comm_maketing/history_ravitaillement_model.dart';
import 'package:wm_solution/src/models/comm_maketing/prod_model.dart';
import 'package:wm_solution/src/models/comm_maketing/stocks_global_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/history/history_ravitaillement_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/stock_global/stock_global_controller.dart';

class RavitaillementController extends GetxController {
  final StockGlobalController stockGlobalController = Get.find();
  final HistoryRavitaillementController historyRavitaillementController =
      Get.find();
  final ProfilController profilController = Get.find();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  List<ProductModel> idProductDropdown = [];

  int? id;
  String? quantity;
  String? priceAchatUnit;
  double prixVenteUnit = 0.0;
  double tva = 0.0;
  bool modeAchat = true;
  String modeAchatBool = "False";
  DateTime? date;
  String? telephone;
  String? succursale;
  String? nameBusiness;

  TextEditingController controlleridProduct = TextEditingController();
  TextEditingController controllerquantity = TextEditingController();
  TextEditingController controllerpriceAchatUnit = TextEditingController();
  TextEditingController controllerPrixVenteUnit = TextEditingController();
  TextEditingController controllerUnite = TextEditingController();

  double pavTVA = 0.0;

  @override
  void dispose() {
    controlleridProduct.dispose();
    controllerquantity.dispose();
    controllerpriceAchatUnit.dispose();
    controllerPrixVenteUnit.dispose();
    controllerUnite.dispose();
    super.dispose();
  }

  // Historique de ravitaillement
  void submit(StocksGlobalMOdel stock) async {
    try {
      var qtyDisponible =
          double.parse(controllerquantity.text) + double.parse(stock.quantity);

      // Add Achat history pour voir les entrés et sorties de chaque produit
      var qtyDifference =
          double.parse(stock.quantityAchat) - double.parse(stock.quantity);
      var priceDifference = pavTVA - double.parse(stock.priceAchatUnit);
      var margeBenMap = qtyDifference * priceDifference;

      final historyRavitaillementModel = HistoryRavitaillementModel(
          idProduct: stock.idProduct,
          quantity: stock.quantity,
          quantityAchat: stock.quantityAchat,
          priceAchatUnit: stock.priceAchatUnit,
          prixVenteUnit: stock.prixVenteUnit,
          unite: stock.unite,
          margeBen: margeBenMap.toString(),
          tva: stock.tva,
          qtyRavitailler: stock.qtyRavitailler,
          succursale: profilController.user.succursale,
          signature: profilController.user.matricule,
          created: stock.created);
      await historyRavitaillementController.historyRavitaillementApi
          .insertData(historyRavitaillementModel)
          .then((value) {
        // Update stock global
        final stocksGlobalMOdel = StocksGlobalMOdel(
            id: stock.id!,
            idProduct: stock.idProduct,
            quantity: qtyDisponible.toString(),
            quantityAchat: qtyDisponible.toString(),
            priceAchatUnit: controllerpriceAchatUnit.text,
            prixVenteUnit: pavTVA.toString(),
            unite: stock.unite,
            modeAchat: modeAchat.toString(),
            tva: tva.toString(),
            qtyRavitailler: stock.qtyRavitailler,
            signature: profilController.user.matricule,
            created: DateTime.now());
        stockGlobalController.stockGlobalApi
            .updateData(stocksGlobalMOdel)
            .then((value) {
          stockGlobalController.stockGlobalList;
          Get.back();
          Get.snackbar("Livraison effectuée avec succès!",
              "La Livraison a bien été envoyée",
              backgroundColor: Colors.green,
              icon: const Icon(Icons.check),
              snackPosition: SnackPosition.TOP);
          _isLoading.value = false;
        });
      });
    } catch (e) {
      Get.snackbar("Erreur de soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }
}
