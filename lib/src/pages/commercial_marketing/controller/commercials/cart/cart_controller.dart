import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/comm_marketing/commerciale/cart_api.dart';
import 'package:wm_solution/src/helpers/pdf_api.dart';
import 'package:wm_solution/src/models/comm_maketing/cart_model.dart';
import 'package:wm_solution/src/models/comm_maketing/creance_cart_model.dart';
import 'package:wm_solution/src/models/comm_maketing/facture_cart_model.dart';
import 'package:wm_solution/src/models/comm_maketing/gain_model.dart';
import 'package:wm_solution/src/models/comm_maketing/number_facture.dart';
import 'package:wm_solution/src/models/comm_maketing/vente_cart_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/commercial_marketing/components/commercials/factures/pdf/creance_cart_pdf.dart';
import 'package:wm_solution/src/pages/commercial_marketing/components/commercials/factures/pdf/facture_cart_pdf.dart';
import 'package:wm_solution/src/pages/commercial_marketing/controller/commercials/factures/facture_controller.dart';
import 'package:wm_solution/src/pages/commercial_marketing/controller/commercials/factures/facture_creance_controller.dart';
import 'package:wm_solution/src/pages/commercial_marketing/controller/commercials/factures/numero_facture_controller.dart';
import 'package:wm_solution/src/pages/commercial_marketing/controller/commercials/gains/gain_controller.dart';
import 'package:wm_solution/src/pages/commercial_marketing/controller/commercials/history/history_vente_controller.dart';

class CartController extends GetxController with StateMixin<List<CartModel>> {
  final CartApi cartApi = CartApi();
  final FactureController factureController = Get.put(FactureController());
  final FactureCreanceController factureCreanceController =
      Get.put(FactureCreanceController());
  final NumeroFactureController numeroFactureController =
      Get.put(NumeroFactureController());
  final GainController gainController = Get.put(GainController());
  final VenteCartController venteCartController =
      Get.put(VenteCartController());
  final ProfilController profilController = Get.find();

  var cartList = <CartModel>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  String matricule = '';

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  @override
  void refresh() {
    getList();
    super.refresh();
  }

  void getList() async {
    await cartApi.getAllData(matricule).then((response) {
      cartList.assignAll(response);
      change(cartList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await cartApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await cartApi.deleteData(id).then((value) {
        cartList.clear();
        getList();
        // Get.back();
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

  Future<void> submitFacture() async {
    try {
      final jsonList = jsonEncode(cartList);
      final factureCartModel = FactureCartModel(
          cart: jsonList,
          client: '${numeroFactureController.numberFactureList.length + 1}',
          succursale: profilController.user.succursale,
          signature: profilController.user.matricule,
          created: DateTime.now());
      await factureController.factureApi
          .updateData(factureCartModel)
          .then((value) async {
        // Genere le numero de la facture
        numberFactureField(value.client, value.succursale, value.signature);
        // Ajout des items dans historique
        venteHisotory();
        // Add Gain par produit
        gainVentes();
        // Vide de la panier
        cleanCart().then((value) {
          cartList.clear();
          getList();
          Get.back();
          Get.snackbar("Succursale ajoutée avec succès!",
              "Le document a bien été soumis",
              backgroundColor: Colors.green,
              icon: const Icon(Icons.check),
              snackPosition: SnackPosition.TOP);
          _isLoading.value = false;
        });
      });
    } catch (e) {
      Get.snackbar("Erreur lors de la soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }  
  // PDF Generate Facture
  Future<void> createFacturePDF() async {
    try {
        final jsonList = jsonEncode(cartList);
      final factureCartModel = FactureCartModel(
        cart: jsonList,
        client: '${numeroFactureController.numberFactureList.length + 1}',
        succursale: profilController.user.succursale,
        signature: profilController.user.matricule,
        created: DateTime.now()
      ); 
      List<FactureCartModel> factureList = [];
      factureList.add(factureCartModel); 
      // ignore: unused_local_variable
      FactureCartModel? facture; 
      for (var item in factureList) {
        facture = item;
      }
      final pdfFile = await FactureCartPDF.generate(facture!, '\$');
      PdfApi.openFile(pdfFile);
    } catch (e) {
      Get.snackbar("Erreur lors de l'ouverture", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
    
  }



  Future<void> submitFactureCreance() async {
    try {
        final jsonList = jsonEncode(cartList);
      final creanceCartModel = CreanceCartModel(
          cart: jsonList,
          client: '${numeroFactureController.numberFactureList.length + 1}',
          succursale: profilController.user.succursale,
          signature: profilController.user.matricule,
          created: DateTime.now());
      await factureCreanceController.creanceFactureApi.insertData(creanceCartModel).then((value) {
          numberFactureField(value.client, value.succursale, value.signature);
        // Ajout des items dans historique
        venteHisotory();
        // Add Gain par produit
        gainVentes();
        // Vide de la panier
        cleanCart().then((value) {
          cartList.clear();
          getList();
          Get.back();
          Get.snackbar(
              "Succursale ajoutée avec succès!", "Le document a bien été soumis",
              backgroundColor: Colors.green,
              icon: const Icon(Icons.check),
              snackPosition: SnackPosition.TOP);
          _isLoading.value = false;
        });
      }); 
    } catch (e) {
      Get.snackbar("Erreur lors de la soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
    
  }

  // PDF Generate Creance
  Future<void> createPDFCreance() async {
    try {
        final jsonList = jsonEncode(cartList);
      final creanceCartModel = CreanceCartModel(
          cart: jsonList,
          client: '${numeroFactureController.numberFactureList.length + 1}',
          succursale: profilController.user.succursale,
          signature: profilController.user.matricule,
          created: DateTime.now());

      List<CreanceCartModel> creanceList = [];
      creanceList.add(creanceCartModel);

      // ignore: unused_local_variable
      CreanceCartModel? creance;

      for (var item in creanceList) {
        creance = item;
      } 
      final pdfFile = await CreanceCartPDF.generate(creance!, '\$');
      PdfApi.openFile(pdfFile);
    } catch (e) {
      Get.snackbar("Erreur lors de l'ouverture", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    } 
  }


  Future<void> cleanCart() async {
    await CartApi().deleteAllData(profilController.user.matricule);
  }

  Future<void> numberFactureField(
      String number, String succursale, String signature) async {
    final numberFactureModel = NumberFactureModel(
        number: number,
        succursale: succursale,
        signature: signature,
        created: DateTime.now());
    await numeroFactureController.numberFactureApi
        .insertData(numberFactureModel);
  }

  Future<void> venteHisotory() async {
    for (var item in cartList) {
      double priceTotal = 0;
      if (double.parse(item.quantityCart) >= double.parse(item.qtyRemise)) {
        priceTotal =
            double.parse(item.quantityCart) * double.parse(item.remise);
      } else {
        priceTotal =
            double.parse(item.quantityCart) * double.parse(item.priceCart);
      }
      final venteCartModel = VenteCartModel(
          idProductCart: item.idProductCart,
          quantityCart: item.quantityCart,
          priceTotalCart: priceTotal.toString(),
          unite: item.unite,
          tva: item.tva,
          remise: item.remise,
          qtyRemise: item.qtyRemise,
          succursale: item.succursale,
          signature: item.signature,
          created: item.created);
      await venteCartController.venteCartApi.insertData(venteCartModel);
    }
  }

  Future<void> gainVentes() async {
    for (var item in cartList) {
      double gainTotal = 0;
      if (double.parse(item.quantityCart) >= double.parse(item.qtyRemise)) {
        gainTotal =
            (double.parse(item.remise) - double.parse(item.priceAchatUnit)) *
                double.parse(item.quantityCart);
      } else {
        gainTotal =
            (double.parse(item.priceCart) - double.parse(item.priceAchatUnit)) *
                double.parse(item.quantityCart);
      }
      final gainModel = GainModel(
          sum: gainTotal,
          succursale: item.succursale,
          signature: item.signature,
          created: item.created);
      await gainController.gainApi.insertData(gainModel);
    }
  }
}