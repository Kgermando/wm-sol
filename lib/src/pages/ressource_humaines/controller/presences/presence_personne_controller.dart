import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/rh/presence_personnel_api.dart';
import 'package:wm_solution/src/models/rh/presence_model.dart';
import 'package:wm_solution/src/models/rh/presence_personnel_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class PresencePersonneController extends GetxController
    with StateMixin<List<PresencePersonnelModel>> {
  final PresencePersonnelApi presencePersonnelApi = PresencePersonnelApi();

  final ProfilController profilController = Get.find();

  var presencePersonneList = <PresencePersonnelModel>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final _isHoursCumulsWork = 0.obs; // Nombre dheures depuis le debut de travail
  final _isJoursWork = 0.obs; // Nombre des jours dans un mois
  final _isHoursWork = 0.obs; // Nombre des Heures dans un mois
  int get isHoursCumulsWork => _isHoursCumulsWork.value;
  int get isJoursWork => _isJoursWork.value;
  int get isHoursWork => _isHoursWork.value;

  TextEditingController identifiantController = TextEditingController();
  TextEditingController motifController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getList();

    for (var element in presencePersonneList) {
      _isHoursCumulsWork.value +=
          element.createdSortie.hour - element.created.hour;
    }

    _isJoursWork.value += presencePersonneList.length;

    for (var element in presencePersonneList) {
      _isHoursWork.value += element.createdSortie.hour - element.created.hour;
    }
  }

  @override
  void dispose() {
    identifiantController.dispose();
    motifController.dispose();
    super.dispose();
  }  
  
  void clear() {
    identifiantController.clear();
    motifController.clear(); 
  }

  void getList() async {
    await presencePersonnelApi.getAllData().then((response) {
      presencePersonneList.assignAll(response);
      change(presencePersonneList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await presencePersonnelApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await presencePersonnelApi.deleteData(id).then((value) {
        presencePersonneList.clear();
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

  void submit(PresenceModel data) async {
    try {
      _isLoading.value = true;
      final presence = PresencePersonnelModel(
          reference: data.id!,
          identifiant: identifiantController.text,
          motif: motifController.text,
          sortie: 'false',
          signature: profilController.user.matricule,
          signatureFermeture: '-',
          created: DateTime.now(),
          createdSortie: DateTime.now());
      await presencePersonnelApi.insertData(presence).then((value) {
        clear();
        presencePersonneList.clear();
        getList();
        Get.back();
        Get.snackbar("Presence effectuée avec succès!",
            "${identifiantController.text} est présent",
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

  void submitSortie(PresenceModel data, PresencePersonnelModel personne,
      String sortieBoolean) async {
    try {
      _isLoading.value = true;
      final presence = PresencePersonnelModel(
          id: personne.id,
          reference: data.id!,
          identifiant: personne.identifiant,
          motif: personne.motif,
          sortie: sortieBoolean,
          signature: personne.signature,
          signatureFermeture: profilController.user.matricule,
          created: personne.created,
          createdSortie: DateTime.now());
      await presencePersonnelApi.updateData(presence).then((value) {
        clear();
        presencePersonneList.clear();
        getList();
        Get.back();
        Get.snackbar("Sortie effectuée avec succès!",
            "${identifiantController.text} est sortie",
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
