import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/settings/monnaie_api.dart';
import 'package:wm_solution/src/models/settings/monnaie_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class MonnaieStorage extends GetxController {
  final MonnaieApi monnaieApi = MonnaieApi();
  final ProfilController profilController = Get.find();

  final _monney = '\$'.obs;
  String get monney => _monney.value;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  void getList() async {
    await monnaieApi.getAllData().then((response) {
      _monney.value = response.first.monnaie;
    });
  }
 

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await monnaieApi.deleteData(id).then((value) {
        getList();
        // Get.back();
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

  void submit(String simbol, String lettre) async {
    try {
      _isLoading.value = true;
      final dataItem = MonnaieModel(
          monnaie: simbol,
          monnaieEnlettre: lettre,
          signature: profilController.user.matricule,
          created: DateTime.now()
        );
      await monnaieApi.insertData(dataItem).then((value) {
        // clear(); 
        getList();
        Get.back();
        Get.snackbar("Monnaie effectuée avec succès!",
            "Le document a bien été sauvegadé",
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

  void updateData(String simbol, String lettre) async {
    try {
      _isLoading.value = true;
      final dataItem = MonnaieModel(
        monnaie: simbol,
        monnaieEnlettre: lettre,
        signature: profilController.user.matricule,
        created: DateTime.now()
      );
      await monnaieApi.updateData(dataItem).then((value) {
        // clear();
        getList();
        Get.back();
        Get.snackbar("Modification effectuée avec succès!",
            "Le document a bien été sauvegadé",
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
