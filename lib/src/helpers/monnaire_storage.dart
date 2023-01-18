import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart'; 
import 'package:wm_solution/src/api/settings/monnaie_api.dart';
import 'package:wm_solution/src/models/settings/monnaie_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class MonnaieStorage extends GetxController
    with StateMixin<List<MonnaieModel>> {
  final MonnaieApi monnaieApi = MonnaieApi();
  final ProfilController profilController = Get.find();

  static const _keyMonnaie = 'monnaie';
  GetStorage box = GetStorage();


  List<MonnaieModel> monnaieList = [];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final _monney = '\$'.obs;
  String get monney => _monney.value;

  TextEditingController symbolController = TextEditingController();
  TextEditingController monnaieEnLettreController = TextEditingController();


  @override
  void onInit() {
    super.onInit();
    getList(); 
  }

  
  @override
  void dispose() {
    symbolController.dispose();
    monnaieEnLettreController.dispose(); 
    super.dispose();
  }

  void clear() { 
    symbolController.clear();
    monnaieEnLettreController.clear(); 
  }


  void getList() async {
    await monnaieApi.getAllData().then((response) {
      monnaieList.clear();
      monnaieList.addAll(response);
      if (monnaieList.isEmpty) {
        final data = box.read(_keyMonnaie);
        _monney.value = json.decode(data);
      } else {
        _monney.value = monnaieList
          .where((element) => element.isActive == 'true')
          .first
          .monnaie;
      } 
      change(monnaieList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
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

  void submit() async {
    try {
      _isLoading.value = true;
      final dataItem = MonnaieModel(
          monnaie: symbolController.text,
          monnaieEnlettre: monnaieEnLettreController.text,
          signature: profilController.user.matricule,
          created: DateTime.now(),
          isActive: 'false');
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

  void updateData(MonnaieModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = MonnaieModel(
          monnaie: symbolController.text,
          monnaieEnlettre: monnaieEnLettreController.text,
          signature: profilController.user.matricule,
          created: DateTime.now(),
          isActive: 'false'
      );
      await monnaieApi.updateData(dataItem).then((value) {
        clear();
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

  void activeMonnaie(MonnaieModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = MonnaieModel(
        monnaie: data.monnaie,
        monnaieEnlettre: data.monnaieEnlettre,
        signature: data.signature,
        created: data.created,
        isActive: 'true'
      );
      await monnaieApi.updateData(dataItem).then((value) {
        clear();
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


  // setData(value) async {
  //   box.write(_keyMonnaie, json.encode(value));
  // }

  // removeData() async {
  //   await box.remove(_keyMonnaie);
  // }

}
