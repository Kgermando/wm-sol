import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/logistiques/approvisionnement_api.dart';
import 'package:wm_solution/src/models/logistiques/approvisionnement_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/utils/dropdown.dart';

class ApprovisionnementController extends GetxController
    with StateMixin<List<ApprovisionnementModel>> {
  final ApprovisionnementApi approvisionnementApi = ApprovisionnementApi();
  final ProfilController profilController = Get.find();

  var approvisionnementList = <ApprovisionnementModel>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  List<String> unitesList = Dropdown().unites;

  TextEditingController provisionController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  String? unite;

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  @override
  void dispose() {
    provisionController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  void getList() async {
    await approvisionnementApi.getAllData().then((response) {
      approvisionnementList.assignAll(response);
      change(approvisionnementList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await approvisionnementApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await approvisionnementApi.deleteData(id).then((value) {
        approvisionnementList.clear();
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

  void submit() async {
    try {
      _isLoading.value = true;
      final dataItem = ApprovisionnementModel(
          provision: provisionController.text,
          quantityTotal: quantityController.text,
          quantity: quantityController.text,
          unite: unite.toString(),
          signature: profilController.user.matricule,
          created: DateTime.now());
      await approvisionnementApi.insertData(dataItem).then((value) {
        approvisionnementList.clear();
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

  void submiRavitaillement(ApprovisionnementModel data) async {
    try {
      _isLoading.value = true;
      double qtyTotal = double.parse(data.quantityTotal) +
          double.parse(quantityController.text);
      double qtyDisponible =
          double.parse(data.quantity) + double.parse(quantityController.text);
      final dataItem = ApprovisionnementModel(
          provision: data.provision,
          quantityTotal: qtyTotal.toString(),
          quantity: qtyDisponible.toString(),
          unite: unite.toString(),
          signature: profilController.user.matricule,
          created: DateTime.now());
      await approvisionnementApi.updateData(dataItem).then((value) {
        approvisionnementList.clear();
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

  void submiReste(ApprovisionnementModel data) async {
    try {
      _isLoading.value = true;
      double qtyRestante =
          double.parse(data.quantity) - double.parse(quantityController.text);
      final dataItem = ApprovisionnementModel(
          provision: data.provision,
          quantityTotal: data.quantityTotal,
          quantity: qtyRestante.toString(),
          unite: unite.toString(),
          signature: profilController.user.matricule,
          created: DateTime.now());
      await approvisionnementApi.updateData(dataItem).then((value) {
        approvisionnementList.clear();
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
}
