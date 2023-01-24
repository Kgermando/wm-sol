import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/devis/devis_list_objets_api.dart';
import 'package:wm_solution/src/models/devis/devis_list_objets_model.dart';
import 'package:wm_solution/src/models/devis/devis_models.dart';

class DevisListObjetController extends GetxController
    with StateMixin<List<DevisListObjetsModel>> {
  final DevisListObjetsApi devisListObjetsApi = DevisListObjetsApi();

  var devisListObjetList = <DevisListObjetsModel>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  double quantity = 0.0;
  TextEditingController designationController = TextEditingController();
  double montantUnitaire = 0.0;
  double montantGlobal = 0.0;

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  @override
  void dispose() {
    designationController.dispose();
    super.dispose();
  }

  void clear() {
    designationController.clear();
  }

  void getList() async {
    devisListObjetsApi.getAllData().then((response) {
      devisListObjetList.clear();
      devisListObjetList.assignAll(response);
      change(response, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await devisListObjetsApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await devisListObjetsApi.deleteData(id).then((value) {
        devisListObjetList.clear();
        getList();
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

  Future<void> submitObjet(DevisModel data) async {
    try {
      double qty = (quantity == 0) ? 1 : quantity;
      montantGlobal = qty * montantUnitaire;
      final devisListObjetsModel = DevisListObjetsModel(
        reference: data.id!,
        title: data.title,
        quantity: qty.toString(),
        designation: designationController.text,
        montantUnitaire: montantUnitaire.toString(),
        montantGlobal: montantGlobal.toString(),
      );
      await devisListObjetsApi.insertData(devisListObjetsModel).then((value) {
        clear();
        devisListObjetList.clear();
        getList();
        Get.back();
        Get.snackbar(
            "Objet ajoutée avec succès!", "Le document a bien été soumis",
            backgroundColor: Colors.green,
            icon: const Icon(Icons.check),
            snackPosition: SnackPosition.TOP);
        _isLoading.value = false;
      });
    } catch (e) {
      _isLoading.value = false;
      Get.snackbar("Erreur lors de la soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }

  Future<void> submitUpdateObjet(DevisListObjetsModel data) async {
    try {
      double qty = (quantity == 0) ? 1 : quantity;
      montantGlobal = qty * montantUnitaire;
      final devisListObjetsModel = DevisListObjetsModel(
        id: data.id,
        reference: data.reference,
        title: data.title,
        quantity: qty.toString(),
        designation: designationController.text,
        montantUnitaire: montantUnitaire.toString(),
        montantGlobal: montantGlobal.toString(),
      );
      await devisListObjetsApi.updateData(devisListObjetsModel).then((value) {
        clear();
        devisListObjetList.clear();
        getList();
        Get.back();
        Get.snackbar(
            "Objet Modifié avec succès!", "Le document a bien été soumis",
            backgroundColor: Colors.green,
            icon: const Icon(Icons.check),
            snackPosition: SnackPosition.TOP);
        _isLoading.value = false;
      });
    } catch (e) {
      _isLoading.value = false;
      Get.snackbar("Erreur lors de la soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }
}
