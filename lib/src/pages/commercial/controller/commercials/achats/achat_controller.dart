import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/commerciale/achat_api.dart';
import 'package:wm_solution/src/api/commerciale/cart_api.dart';
import 'package:wm_solution/src/models/comm_maketing/achat_model.dart';
import 'package:wm_solution/src/models/comm_maketing/cart_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class AchatController extends GetxController with StateMixin<List<AchatModel>> {
  final AchatApi achatApi = AchatApi();
  final CartApi cartApi = CartApi();
  final ProfilController profilController = Get.find();

  var achatList = <AchatModel>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  TextEditingController controllerQuantityCart = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  @override
  void dispose() {
    controllerQuantityCart.dispose();
    super.dispose();
  }

  void getList() async {
    await achatApi.getAllData().then((response) {
      achatList.assignAll(response);
      change(achatList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await achatApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await achatApi.deleteData(id).then((value) {
        achatList.clear();
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

  void submit(AchatModel achat) async {
    try {
      _isLoading.value = true;
      var qty = double.parse(achat.quantity) -
          double.parse(controllerQuantityCart.text);

      final cartModel = CartModel(
          idProductCart: achat.idProduct,
          quantityCart: controllerQuantityCart.text,
          priceCart: achat.prixVenteUnit,
          priceAchatUnit: achat.priceAchatUnit,
          unite: achat.unite,
          tva: achat.tva,
          remise: achat.remise,
          qtyRemise: achat.qtyRemise,
          succursale: profilController.user.succursale,
          signature: profilController.user.matricule,
          created: DateTime.now());
      await cartApi.insertData(cartModel).then((value) async {
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
            created: DateTime.now());
        await achatApi.updateData(achatModel).then((value) {
          achatList.clear();
          getList();
          Get.back();
          Get.snackbar("Soumission effectuée avec succès!",
              "Le document a bien été sauvegader",
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
