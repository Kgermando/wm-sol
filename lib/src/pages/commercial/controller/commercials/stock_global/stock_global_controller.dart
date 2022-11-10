import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/commerciale/stock_global_api.dart';
import 'package:wm_solution/src/models/comm_maketing/prod_model.dart';
import 'package:wm_solution/src/models/comm_maketing/stocks_global_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/produit_model/produit_model_controller.dart';
import 'package:wm_solution/src/utils/dropdown.dart';

class StockGlobalController extends GetxController
    with StateMixin<List<StocksGlobalMOdel>> {
  final StockGlobalApi stockGlobalApi = StockGlobalApi();
  final ProfilController profilController = Get.find();
  final ProduitModelController produitModelController = Get.find();

  var stockGlobalList = <StocksGlobalMOdel>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  List<ProductModel> idProductDropdown = [];

  final List<String> unites = Dropdown().unites;

  String? idProduct;
  String quantityAchat = '0.0';
  String priceAchatUnit = '0.0';
  double prixVenteUnit = 0.0;
  // String? unite;
  bool modeAchat = true;
  String modeAchatBool = "False";
  DateTime? date;
  String? telephone;
  String? succursale;
  String? nameBusiness;
  double tva = 0.0;

  @override
  void onInit() {
    super.onInit();
    getList();
    getData();
  }

  Future<void> getData() async {
    var produitModel =
        await produitModelController.produitModelApi.getAllData();
    idProductDropdown = produitModel
        .where((element) => element.approbationDD == "Approved")
        .toList();
  }

  void getList() async {
    await stockGlobalApi.getAllData().then((response) {
      stockGlobalList.assignAll(response);
      change(stockGlobalList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await stockGlobalApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await stockGlobalApi.deleteData(id).then((value) {
        stockGlobalList.clear();
        getList();
        Get.back();
        Get.snackbar("Supprimé avec succès!", "Cet élément a bien été supprimé",
            backgroundColor: Colors.green,
            icon: const Icon(Icons.check),
            snackPosition: SnackPosition.TOP);
        _isLoading.value = false;
      });
    } catch (e) {
      Get.snackbar("Erreur de soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }

  void submit() async {
    try {
      _isLoading.value = true;
      var uniteProd = idProduct!.split('-');
      var unite = uniteProd.elementAt(4);
      final dataItem = StocksGlobalMOdel(
          idProduct: idProduct.toString(),
          quantity: quantityAchat.toString(),
          quantityAchat: quantityAchat.toString(),
          priceAchatUnit: priceAchatUnit.toString(),
          prixVenteUnit: prixVenteUnit.toString(),
          unite: unite.toString(),
          modeAchat: modeAchatBool,
          tva: tva.toString(),
          qtyRavitailler: quantityAchat.toString(),
          signature: profilController.user.matricule,
          created: DateTime.now());
      await stockGlobalApi.insertData(dataItem).then((value) {
        stockGlobalList.clear();
        getList();
        Get.back();
        Get.snackbar("Soumission effectuée avec succès!",
            "Le document a bien été sauvegader",
            backgroundColor: Colors.green,
            icon: const Icon(Icons.check),
            snackPosition: SnackPosition.TOP);
        _isLoading.value = false;
      });
    } catch (e) {
      Get.snackbar("Erreur de soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }

  // void submitUpdate(StocksGlobalMOdel data) async {
  //   try {
  //     _isLoading.value = true;

  //     await stockGlobalApi.updateData(dataItem).then((value) {
  //       stockGlobalList.clear();
  //       getList();
  //       Get.back();
  //       Get.snackbar("Soumission effectuée avec succès!",
  //           "Le document a bien été sauvegader",
  //           backgroundColor: Colors.green,
  //           icon: const Icon(Icons.check),
  //           snackPosition: SnackPosition.TOP);
  //       _isLoading.value = false;
  //     });
  //   } catch (e) {
  //     Get.snackbar("Erreur de soumission", "$e",
  //         backgroundColor: Colors.red,
  //         icon: const Icon(Icons.check),
  //         snackPosition: SnackPosition.TOP);
  //   }
  // }
}
