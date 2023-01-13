import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/commerciale/commercial/vente_cart_api.dart';
import 'package:wm_solution/src/models/commercial/vente_cart_model.dart';

class VenteEffectueController extends GetxController
    with StateMixin<List<VenteCartModel>> {
  final VenteCartApi venteCartApi = VenteCartApi();

  List<VenteCartModel> venteCartList = [];

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    getList();
    super.onInit();
  }

  void getList() async {
    await venteCartApi.getAllData().then((response) {
      venteCartList.clear();
      venteCartList.addAll(response);
      change(venteCartList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await venteCartApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await venteCartApi.deleteData(id).then((value) {
        venteCartList.clear();
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
}
