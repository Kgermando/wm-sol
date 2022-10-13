import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/rh/performence_api.dart';
import 'package:wm_solution/src/models/rh/perfomence_model.dart';

class PerformenceController extends GetxController
    with StateMixin<List<PerformenceModel>> {
  PerformenceApi performenceApi = PerformenceApi();

  var performenceList = <PerformenceModel>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() { 
    super.onInit();
    getList();
  }

  void getList() async {
    await performenceApi.getAllData().then((response) {
      performenceList.assignAll(response);
      change(performenceList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

 
  detailView(int id) async {
    final data = await performenceApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await performenceApi.deleteData(id).then((value) {
        performenceList.clear();
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
}