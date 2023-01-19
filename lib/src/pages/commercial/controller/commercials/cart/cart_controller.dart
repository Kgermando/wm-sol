// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wm_solution/src/api/commerciale/commercial/cart_api.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/helpers/pdf_api.dart';
import 'package:wm_solution/src/helpers/secure_storage.dart';
import 'package:wm_solution/src/models/commercial/achat_model.dart';
import 'package:wm_solution/src/models/commercial/cart_model.dart';
import 'package:wm_solution/src/models/commercial/creance_cart_model.dart';
import 'package:wm_solution/src/models/commercial/facture_cart_model.dart';
import 'package:wm_solution/src/models/commercial/gain_model.dart';
import 'package:wm_solution/src/models/commercial/number_facture.dart';
import 'package:wm_solution/src/models/commercial/vente_cart_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/commercial/components/commercial/factures/pdf/creance_cart_pdf.dart';
import 'package:wm_solution/src/pages/commercial/components/commercial/factures/pdf/facture_cart_pdf.dart';
import 'package:wm_solution/src/pages/commercial/components/commercial/factures/pdf_a6/creance_cart_a6_pdf.dart';
import 'package:wm_solution/src/pages/commercial/components/commercial/factures/pdf_a6/facture_cart_a6_pdf.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/achats/achat_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/factures/facture_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/factures/facture_creance_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/factures/numero_facture_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/gains/gain_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/history/history_vente_controller.dart';

class CartController extends GetxController with StateMixin<List<CartModel>> {
  final CartApi cartApi = CartApi();
  final FactureController factureController = Get.put(FactureController());
  final FactureCreanceController factureCreanceController =
      Get.put(FactureCreanceController());
  final NumeroFactureController numeroFactureController =
      Get.put(NumeroFactureController());
  final GainCartController gainController = Get.put(GainCartController());
  final VenteCartController venteCartController =
      Get.put(VenteCartController());
  final AchatController achatController = Get.put(AchatController());
  final ProfilController profilController = Get.put(ProfilController());
  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());

  List<CartModel> cartList = [];

  // final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final _isLoadingCancel = false.obs;
  bool get isLoadingCancel => _isLoadingCancel.value;

  // TextEditingController controllerQuantityCart = TextEditingController();
  String? controllerQuantityCart;

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  // @override
  // void dispose() {
  //   controllerQuantityCart.dispose();
  //   super.dispose();
  // }

  void clear() {
    // controllerQuantityCart.clear();
    controllerQuantityCart = null;
  }

  void getList() async {
    await cartApi.getAllData(profilController.user.matricule).then((response) {
      cartList.clear();
      cartList.addAll(response);
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
        Get.back();
        Get.snackbar("Supprimé avec succès!", "Cet élément a bien été supprimé",
            backgroundColor: Colors.green,
            icon: const Icon(Icons.check),
            snackPosition: SnackPosition.TOP);
        _isLoading.value = false;
      });
    } catch (e) {
      _isLoading.value = false;
      Get.snackbar("Erreur de soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }

  void addCart(AchatModel achat) async {
    try {
      _isLoading.value = true;
      final cartModel = CartModel(
          idProductCart: achat.idProduct,
          quantityCart: controllerQuantityCart.toString(),
          priceCart: achat.prixVenteUnit,
          priceAchatUnit: achat.priceAchatUnit,
          unite: achat.unite,
          tva: achat.tva,
          remise: achat.remise,
          qtyRemise: achat.qtyRemise,
          succursale: profilController.user.succursale,
          signature: profilController.user.matricule,
          created: DateTime.now(),
          createdAt: achat.created);
      await cartApi.insertData(cartModel).then((value) async {
        var qty =
            double.parse(achat.quantity) - double.parse(value.quantityCart);
        final achatModel = AchatModel(
            id: achat.id!,
            idProduct: achat.idProduct,
            quantity: qty.toString(),
            quantityAchat: achat.quantityAchat,
            priceAchatUnit: achat.priceAchatUnit,
            prixVenteUnit: achat.prixVenteUnit,
            unite: achat.unite,
            tva: achat.tva,
            remise: achat.remise,
            qtyRemise: achat.qtyRemise,
            qtyLivre: achat.qtyLivre,
            succursale: achat.succursale,
            signature: achat.signature,
            created: achat.created);
        await achatController.achatApi.updateData(achatModel).then((value) {
          clear();
          cartList.clear();
          getList();
          // Get.back();
          Get.snackbar("${value.idProduct} ajouté!",
              "${value.idProduct} au panier avec succès.",
              backgroundColor: Colors.green,
              icon: const Icon(Icons.check),
              snackPosition: SnackPosition.TOP);
          _isLoading.value = false;
        });
      });
    } catch (e) {
      _isLoading.value = false;
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
          .insertData(factureCartModel)
          .then((value) async {
        // Genere le numero de la facture
        numberFactureField(value.client, value.succursale, value.signature);

        // Ajout des items dans historique
        venteHisotory(cartList);
        // Add Gain par produit
        gainVentes(cartList);
        // Vide de la panier
        cleanCart().then((value) {
          cartList.clear();
          getList();
          Get.back();
          // Get.snackbar("Ajoutée avec succès!",
          //     "Le document a bien été soumis",
          //     backgroundColor: Colors.green,
          //     icon: const Icon(Icons.check),
          //     snackPosition: SnackPosition.TOP);
          _isLoading.value = false;
        });
      });
    } catch (e) {
      _isLoading.value = false;
      _isLoading.value = false;
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
          created: DateTime.now());
      List<FactureCartModel> factureList = [];
      factureList.add(factureCartModel);
      // ignore: unused_local_variable
      FactureCartModel? facture;
      for (var item in factureList) {
        facture = item;
      }

      String? printer = await SecureStorage().getData();
      if (printer == 'A4') { 
        await FactureCartPDF.generate(facture!, monnaieStorage.monney); 
      }
      if (printer == 'A6') { 
        await FactureCartPDFA6.generate(facture!, monnaieStorage); 
      }
    } catch (e) {
      _isLoading.value = false;
      _isLoading.value = false;
      Get.snackbar("Erreur lors de la soumission", "$e",
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
      await factureCreanceController.creanceFactureApi
          .insertData(creanceCartModel)
          .then((value) {
        numberFactureField(value.client, value.succursale, value.signature);
        // Ajout des items dans historique
        venteHisotory(cartList);
        // Add Gain par produit
        gainVentes(cartList);
        // Vide de la panier
        cleanCart().then((value) {
          cartList.clear();
          getList();
          Get.back();
          // Get.snackbar("Ajoutée avec succès!",
          //     "Le document a bien été soumis",
          //     backgroundColor: Colors.green,
          //     icon: const Icon(Icons.check),
          //     snackPosition: SnackPosition.TOP);
          _isLoading.value = false;
        });
      });
    } catch (e) {
      _isLoading.value = false;
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
      String? printer = await SecureStorage().getData();
      if (printer == 'A4') {
        await CreanceCartPDF.generate(creance!, monnaieStorage.monney);
      }
      if (printer == 'A6') {
        await CreanceCartPDFA6.generate(creance!, monnaieStorage);
      }
    } catch (e) {
      _isLoading.value = false;
      _isLoading.value = false;
      Get.snackbar("Erreur lors de la soumission", "$e",
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

  Future<void> venteHisotory(List<CartModel> cartItemList) async {
    cartItemList.forEach((item) async {
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
          created: item.created,
          createdAt: item.createdAt);
      await venteCartController.venteCartApi.insertData(venteCartModel);
    });

    // for (var item in cartItemList) {
    //   double priceTotal = 0;
    //   if (double.parse(item.quantityCart) >= double.parse(item.qtyRemise)) {
    //     priceTotal =
    //         double.parse(item.quantityCart) * double.parse(item.remise);
    //   } else {
    //     priceTotal =
    //         double.parse(item.quantityCart) * double.parse(item.priceCart);
    //   }
    //   final venteCartModel = VenteCartModel(
    //       idProductCart: item.idProductCart,
    //       quantityCart: item.quantityCart,
    //       priceTotalCart: priceTotal.toString(),
    //       unite: item.unite,
    //       tva: item.tva,
    //       remise: item.remise,
    //       qtyRemise: item.qtyRemise,
    //       succursale: item.succursale,
    //       signature: item.signature,
    //       created: item.created);
    //   await venteCartController.venteCartApi.insertData(venteCartModel);
    // }
  }

  Future<void> gainVentes(List<CartModel> cartItemList) async {
    cartItemList.forEach((item) async {
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
    });

    // for (var item in cartItemList) {
    //   double gainTotal = 0;
    //   if (double.parse(item.quantityCart) >= double.parse(item.qtyRemise)) {
    //     gainTotal =
    //         (double.parse(item.remise) - double.parse(item.priceAchatUnit)) *
    //             double.parse(item.quantityCart);
    //   } else {
    //     gainTotal =
    //         (double.parse(item.priceCart) - double.parse(item.priceAchatUnit)) *
    //             double.parse(item.quantityCart);
    //   }
    //   final gainModel = GainModel(
    //       sum: gainTotal,
    //       succursale: item.succursale,
    //       signature: item.signature,
    //       created: item.created);
    //   await gainController.gainApi.insertData(gainModel);
    // }
  }

  updateAchat(CartModel cart) async {
    try {
      _isLoadingCancel.value = true;
      final achatQtyList = achatController.achatList
          .where((e) => e.idProduct == cart.idProductCart);

      final achatQty = achatQtyList
          .map(
              (e) => double.parse(e.quantity) + double.parse(cart.quantityCart))
          .first;

      final achatIdProduct = achatQtyList.map((e) => e.idProduct).first;
      final achatQuantityAchat = achatQtyList.map((e) => e.quantityAchat).first;
      final achatAchatUnit = achatQtyList.map((e) => e.priceAchatUnit).first;
      final achatPrixVenteUnit = achatQtyList.map((e) => e.prixVenteUnit).first;
      final achatUnite = achatQtyList.map((e) => e.unite).first;
      final achatId = achatQtyList.map((e) => e.id).first;
      final achattva = achatQtyList.map((e) => e.tva).first;
      final achatRemise = achatQtyList.map((e) => e.remise).first;
      final achatQtyRemise = achatQtyList.map((e) => e.qtyRemise).first;
      final achatQtyLivre = achatQtyList.map((e) => e.qtyLivre).first;
      final achatSuccursale = achatQtyList.map((e) => e.succursale).first;
      final achatSignature = achatQtyList.map((e) => e.signature).first;
      final achatCreated = achatQtyList.map((e) => e.created).first;

      final achatModel = AchatModel(
          id: achatId!,
          idProduct: achatIdProduct,
          quantity: achatQty.toString(),
          quantityAchat: achatQuantityAchat,
          priceAchatUnit: achatAchatUnit,
          prixVenteUnit: achatPrixVenteUnit,
          unite: achatUnite,
          tva: achattva,
          remise: achatRemise,
          qtyRemise: achatQtyRemise,
          qtyLivre: achatQtyLivre,
          succursale: achatSuccursale,
          signature: achatSignature,
          created: achatCreated);
      await achatController.achatApi.updateData(achatModel);
      deleteData(cart.id!);
      _isLoadingCancel.value = false;
    } catch (e) {
      _isLoadingCancel.value = false;
      Get.snackbar("Une Erreur ", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }
}
