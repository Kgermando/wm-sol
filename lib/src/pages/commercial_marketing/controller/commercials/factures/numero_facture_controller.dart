import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/comm_marketing/commerciale/number_facture_api.dart';
import 'package:wm_solution/src/models/comm_maketing/number_facture.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class NumeroFactureController extends GetxController
    with StateMixin<List<NumberFactureModel>> {
  final NumberFactureApi numberFactureApi = NumberFactureApi();
  final ProfilController profilController = Get.find();

  var numberFactureList = <NumberFactureModel>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  void getList() async {
    await numberFactureApi.getAllData().then((response) {
      numberFactureList.assignAll(response);
      change(numberFactureList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await numberFactureApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await numberFactureApi.deleteData(id).then((value) {
        numberFactureList.clear();
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
}
