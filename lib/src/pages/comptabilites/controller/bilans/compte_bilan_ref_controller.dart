import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/comptabilite/compte_bilan_ref_api.dart';
import 'package:wm_solution/src/models/comptabilites/bilan_model.dart';
import 'package:wm_solution/src/models/comptabilites/compte_bilan_ref_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class CompteBilanRefController extends GetxController
    with StateMixin<List<CompteBilanRefModel>> {
  final CompteBilanRefApi compteBilanRefApi = CompteBilanRefApi();
  final ProfilController profilController = Get.find();

  var compteBilanRefList = <CompteBilanRefModel>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  String? comptes;
  TextEditingController montantController = TextEditingController();
  String? type;

  // For PDF
  List<CompteBilanRefModel> compteActifList = [];
  List<CompteBilanRefModel> comptePassifList = [];
  List<CompteBilanRefModel> compteBilanRefFilter = [];

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  @override
  void dispose() {
    montantController.dispose();
    super.dispose();
  }

  void getList() async {
    await compteBilanRefApi.getAllData().then((response) {
      compteBilanRefList.assignAll(response);
      change(compteBilanRefList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await compteBilanRefApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await compteBilanRefApi.deleteData(id).then((value) {
        compteBilanRefList.clear();
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

  void submit(BilanModel data) async {
    try {
      _isLoading.value = true;
      final compteBilanRefModel = CompteBilanRefModel(
          id: 0,
          reference: data.id!,
          comptes: comptes.toString(),
          montant:
              (montantController.text == "") ? "0" : montantController.text,
          type: type.toString());
      await compteBilanRefApi.insertData(compteBilanRefModel).then((value) {
        compteBilanRefList.clear();
        getList();
        Get.back();
        Get.snackbar("Soumission effectuée avec succès!",
            "Le document a bien été sauvegader",
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

  void submitEdit(CompteBilanRefModel bilanRef) async {
    try {
      _isLoading.value = true;
      final compteBilanRefModel = CompteBilanRefModel(
          id: bilanRef.id,
          reference: bilanRef.reference,
          comptes: (comptes.toString() == "")
              ? bilanRef.comptes
              : comptes.toString(),
          montant: (montantController.text == "")
              ? bilanRef.montant
              : montantController.text,
          type: (type.toString() == "") ? bilanRef.type : type.toString());
      await compteBilanRefApi.updateData(compteBilanRefModel).then((value) {
        compteBilanRefList.clear();
        getList();
        Get.back();
        Get.snackbar("Mise à jour effectuée avec succès!",
            "Le document a bien été modifié",
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
