import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/exploitations/taches_api.dart';
import 'package:wm_solution/src/models/taches/tache_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class TachesController extends GetxController
    with StateMixin<List<TacheModel>> {
  final TachesApi tachesApi = TachesApi();
  final ProfilController profilController = Get.find();

  var tachesList = <TacheModel>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  TextEditingController jalonController = TextEditingController();
  TextEditingController tacheController = TextEditingController();
  String? agent;
  bool soumettre = false;

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  @override
  void dispose() {
    jalonController.dispose();
    tacheController.dispose();

    super.dispose();
  }

  void getList() async {
    await tachesApi.getAllData().then((response) {
      tachesList.assignAll(response);
      change(tachesList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await tachesApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await tachesApi.deleteData(id).then((value) {
        tachesList.clear();
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

  void submit(String nom, int length, int id, String departement) async {
    try {
      _isLoading.value = true;
      final dataItem = TacheModel(
          nom: nom, // Nom du projet ou campaign
          numeroTache: "${length + 1}",
          agent: agent.toString(),
          jalon: jalonController.text,
          tache: tacheController.text,
          signatureResp: profilController.user.matricule,
          created: DateTime.now(),
          read: 'false',
          departement: departement,
          reference: id);
      await tachesApi.insertData(dataItem).then((value) {
        tachesList.clear();
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

  void submitUpdate(TacheModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = TacheModel(
          nom: data.nom,
          numeroTache: data.numeroTache,
          agent: agent.toString(),
          jalon: jalonController.text,
          tache: tacheController.text,
          signatureResp: profilController.user.matricule,
          created: data.created,
          read: data.read,
          departement: data.departement,
          reference: data.reference);
      await tachesApi.updateData(dataItem).then((value) {
        tachesList.clear();
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

  void submitRead(TacheModel data, String read) async {
    try {
      _isLoading.value = true;
      final dataItem = TacheModel(
          nom: data.nom,
          numeroTache: data.numeroTache,
          agent: agent.toString(),
          jalon: jalonController.text,
          tache: tacheController.text,
          signatureResp: profilController.user.matricule,
          created: data.created,
          read: read,
          departement: data.departement,
          reference: data.reference);
      await tachesApi.updateData(dataItem).then((value) {
        tachesList.clear();
        getList();
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
