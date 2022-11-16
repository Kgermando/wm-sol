import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/finances/creance_dette_api.dart';
import 'package:wm_solution/src/models/finances/creance_dette_model.dart';
import 'package:wm_solution/src/models/finances/creances_model.dart';
import 'package:wm_solution/src/models/finances/dette_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class CreanceDetteController extends GetxController
    with StateMixin<List<CreanceDetteModel>> {
  final CreanceDetteApi creanceDetteApi = CreanceDetteApi();
  final ProfilController profilController = Get.find();

  var creanceDetteList = <CreanceDetteModel>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final TextEditingController nomCompletController = TextEditingController();
  final TextEditingController pieceJustificativeController =
      TextEditingController();
  final TextEditingController libelleController = TextEditingController();
  final TextEditingController montantController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  @override
  void dispose() {
    nomCompletController.dispose();
    pieceJustificativeController.dispose();
    libelleController.dispose();
    montantController.dispose();
    super.dispose();
  }

  void clear() {
    nomCompletController.clear();
    pieceJustificativeController.clear();
    libelleController.clear();
    montantController.clear();
  }

  void getList() async {
    await creanceDetteApi.getAllData().then((response) {
      creanceDetteList.assignAll(response);
      change(creanceDetteList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await creanceDetteApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await creanceDetteApi.deleteData(id).then((value) {
        creanceDetteList.clear();
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

  void submitCreance(CreanceModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = CreanceDetteModel(
          reference: data.id!,
          nomComplet: nomCompletController.text,
          pieceJustificative: pieceJustificativeController.text,
          libelle: libelleController.text,
          montant: montantController.text,
          creanceDette: "creances",
          signature: profilController.user.matricule,
          created: DateTime.now());
      await creanceDetteApi.insertData(dataItem).then((value) {
        clear();
        creanceDetteList.clear();
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

  void submitDette(DetteModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = CreanceDetteModel(
          reference: data.id!,
          nomComplet: nomCompletController.text,
          pieceJustificative: pieceJustificativeController.text,
          libelle: libelleController.text,
          montant: montantController.text,
          creanceDette: "dettes",
          signature: profilController.user.matricule,
          created: DateTime.now());
      await creanceDetteApi.insertData(dataItem).then((value) {
        clear();
        creanceDetteList.clear();
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

  void submitUpdate(CreanceDetteModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = CreanceDetteModel(
          id: data.id,
          reference: data.reference,
          nomComplet: nomCompletController.text,
          pieceJustificative: pieceJustificativeController.text,
          libelle: libelleController.text,
          montant: montantController.text,
          creanceDette: data.creanceDette,
          signature: profilController.user.matricule,
          created: DateTime.now());
      await creanceDetteApi.updateData(dataItem).then((value) {
        clear();
        creanceDetteList.clear();
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
