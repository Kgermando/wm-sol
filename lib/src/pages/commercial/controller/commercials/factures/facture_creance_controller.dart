import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/commerciale/creance_facture_api.dart';
import 'package:wm_solution/src/models/comm_maketing/creance_cart_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class FactureCreanceController extends GetxController
    with StateMixin<List<CreanceCartModel>> {
  final CreanceFactureApi creanceFactureApi = CreanceFactureApi();
  final ProfilController profilController = Get.find();

  var creanceFactureList = <CreanceCartModel>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  void getList() async {
    await creanceFactureApi.getAllData().then((response) {
      creanceFactureList.assignAll(response);
      change(creanceFactureList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await creanceFactureApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await creanceFactureApi.deleteData(id).then((value) {
        creanceFactureList.clear();
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
