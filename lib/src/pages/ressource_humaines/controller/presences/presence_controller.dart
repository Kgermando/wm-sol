import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/api/rh/presence_api.dart';
import 'package:wm_solution/src/models/rh/presence_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class PresenceController extends GetxController
    with StateMixin<List<PresenceModel>> {
  final PresenceApi presenceApi = PresenceApi();

  final ProfilController profilController = Get.find();

  var presenceList = <PresenceModel>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  void getList() async {
    await presenceApi.getAllData().then((response) {
      presenceList.assignAll(response);
      // print("list data  ${response.length}");
      change(presenceList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await presenceApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await presenceApi.deleteData(id).then((value) {
        presenceList.clear();
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
      final presenceModel = PresenceModel(
          title:
              "Présence du ${DateFormat("dd-MM-yyyy").format(DateTime.now())}",
          signature: profilController.user.matricule,
          created: DateTime.now());
      await presenceApi.insertData(presenceModel).then((value) {
        presenceList.clear();
        getList();
        Get.back();

        Get.snackbar(
            "Liste Presence créé avec succès!", "Nouvelle liste de presence.",
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
