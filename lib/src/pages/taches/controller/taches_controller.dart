import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as flutter_quill;
import 'package:get/get.dart';
import 'package:wm_solution/src/api/exploitations/taches_api.dart';
import 'package:wm_solution/src/models/taches/tache_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class TachesController extends GetxController
    with StateMixin<List<TacheModel>> {
  final TachesApi tachesApi = TachesApi();
  final ProfilController profilController = Get.put(ProfilController());

  var tachesList = <TacheModel>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  TextEditingController jalonController = TextEditingController();
  // TextEditingController tacheController = TextEditingController();
  flutter_quill.QuillController quillController =
      flutter_quill.QuillController.basic();

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
    // tacheController.dispose();
    quillController.dispose();

    super.dispose();
  }

  void clear() {
    agent == null;
    jalonController.clear();
    // tacheController.clear();
    quillController.clear();
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
    var json = jsonEncode(quillController.document.toDelta().toJson());
    try {
      _isLoading.value = true;
      final dataItem = TacheModel(
          nom: nom, // Nom du projet ou campaign
          numeroTache: "${length + 1}",
          agent: agent.toString(),
          jalon: jalonController.text,
          tache: json,
          signatureResp: profilController.user.matricule,
          created: DateTime.now(),
          readResponsable: 'Ouvert',
          departement: departement,
          reference: id,
          readAgent: 'Non Lu');
      await tachesApi.insertData(dataItem).then((value) {
        clear();
        tachesList.clear();
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

  void submitUpdate(TacheModel data) async {
    var json = jsonEncode(quillController.document.toDelta().toJson());
    try {
      _isLoading.value = true;
      final dataItem = TacheModel(
        id: data.id,
        nom: data.nom,
        numeroTache: data.numeroTache,
        agent: agent.toString(),
        jalon: jalonController.text,
        tache: json,
        signatureResp: profilController.user.matricule,
        created: data.created,
        readResponsable: data.readResponsable,
        departement: data.departement,
        reference: data.reference,
        readAgent: data.readAgent,
      );
      await tachesApi.updateData(dataItem).then((value) {
        clear();
        tachesList.clear();
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

  void submitRead(TacheModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = TacheModel(
          id: data.id,
          nom: data.nom,
          numeroTache: data.numeroTache,
          agent: data.agent,
          jalon: data.jalon,
          tache: data.tache,
          signatureResp: data.signatureResp,
          created: data.created,
          readResponsable: 'Fermer',
          departement: data.departement,
          reference: data.reference,
          readAgent: data.readAgent);
      await tachesApi.updateData(dataItem).then((value) {
        clear();
        tachesList.clear();
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

  void submitReadAgent(TacheModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = TacheModel(
          id: data.id,
          nom: data.nom,
          numeroTache: data.numeroTache,
          agent: data.agent,
          jalon: data.jalon,
          tache: data.tache,
          signatureResp: data.signatureResp,
          created: data.created,
          readResponsable: data.readResponsable,
          departement: data.departement,
          reference: data.reference,
          readAgent: 'Lu');
      await tachesApi.updateData(dataItem).then((value) {
        clear();
        tachesList.clear();
        getList();
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
