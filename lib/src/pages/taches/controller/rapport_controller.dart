import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/exploitations/rapport_api.dart';
import 'package:wm_solution/src/models/taches/rapport_model.dart';
import 'package:wm_solution/src/models/taches/tache_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class RapportController extends GetxController
    with StateMixin<List<RapportModel>> {
  final RapportApi rapportApi = RapportApi();
  final ProfilController profilController = Get.find();

  var rapportList = <RapportModel>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
 
  QuillController quillControllerRead = QuillController.basic();
  QuillController quillController = QuillController.basic();

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  @override
  void dispose() {
    quillControllerRead.dispose();
    quillController.dispose();
    super.dispose();
  }

  void clear() {
    quillControllerRead.clear();
    quillController.clear();
  }

  void getList() async {
    await rapportApi.getAllData().then((response) {
      rapportList.assignAll(response);
      change(rapportList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await rapportApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await rapportApi.deleteData(id).then((value) {
        rapportList.clear();
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

  void submit(TacheModel data) async {
    var json = jsonEncode(quillController.document.toDelta().toJson());
    print("quill $json");
    try {
      _isLoading.value = true;
      final dataItem = RapportModel(
          nom: data.nom,
          numeroTache: data.numeroTache,
          rapport: json, // rapportController.text,
          signature: profilController.user.matricule.toString(),
          created: DateTime.now(),
          reference: data.id!);
      await rapportApi.insertData(dataItem).then((value) {
        clear();
        rapportList.clear();
        getList();
        Get.back();
        Get.snackbar("Soumission effectuée avec succès!",
            "Le document a bien été sauvegadé",
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

  void submitUpdate(RapportModel data) async {
    var json = jsonEncode(quillController.document.toDelta().toJson());
    try {
      _isLoading.value = true;
      final dataItem = RapportModel(
          id: data.id,
          nom: data.nom,
          numeroTache: data.numeroTache,
          rapport: json, // rapportController.text,
          signature: profilController.user.matricule.toString(),
          created: DateTime.now(),
          reference: data.id!);
      await rapportApi.updateData(dataItem).then((value) {
        clear();
        rapportList.clear();
        getList();
        Get.back();
        Get.snackbar("Soumission effectuée avec succès!",
            "Le document a bien été sauvegadé",
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
