import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/comm_marketing/commerciale/livraison_history_api.dart';
import 'package:wm_solution/src/models/comm_maketing/livraiason_history_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class HistoryLivraisonController extends GetxController
    with StateMixin<List<LivraisonHistoryModel>> {
  final LivraisonHistoryApi livraisonHistorylivraisonHistoryApi =
      LivraisonHistoryApi();
  final ProfilController profilController = Get.find();

  var livraisonHistoryList = <LivraisonHistoryModel>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  void getList() async {
    await livraisonHistorylivraisonHistoryApi.getAllData().then((response) {
      livraisonHistoryList.assignAll(response);
      change(livraisonHistoryList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await livraisonHistorylivraisonHistoryApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await livraisonHistorylivraisonHistoryApi.deleteData(id).then((value) {
        livraisonHistoryList.clear();
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
