import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/rh/performence_note_api.dart';
import 'package:wm_solution/src/models/rh/perfomence_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class PerformenceNoteController extends GetxController
    with StateMixin<List<PerformenceNoteModel>> {
  PerformenceNoteApi performenceNoteApi = PerformenceNoteApi();
  final ProfilController profilController = Get.find();

  List<PerformenceNoteModel> performenceNoteList = [];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final TextEditingController hospitaliteController = TextEditingController();
  final TextEditingController ponctualiteController = TextEditingController();
  final TextEditingController travailleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  @override
  void dispose() {
    hospitaliteController.dispose();
    ponctualiteController.dispose();
    travailleController.dispose();

    super.dispose();
  }

  void clear() {
    hospitaliteController.clear();
    ponctualiteController.clear();
    travailleController.clear();
  }

  void getList() async {
    await performenceNoteApi.getAllData().then((response) {
      performenceNoteList.clear();
      performenceNoteList.addAll(response);
      change(performenceNoteList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await performenceNoteApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await performenceNoteApi.deleteData(id).then((value) {
        performenceNoteList.clear();
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

  void submit(PerformenceModel data) async {
    try {
      _isLoading.value = true;
      final performenceNoteModel = PerformenceNoteModel(
          agent: data.agent,
          departement: data.departement,
          hospitalite: hospitaliteController.text,
          ponctualite: ponctualiteController.text,
          travaille: travailleController.text,
          note: noteController.text,
          signature: profilController.user.matricule,
          created: DateTime.now());
      await performenceNoteApi.insertData(performenceNoteModel).then((value) {
        clear();
        performenceNoteList.clear();
        getList();
        Get.back();
        Get.snackbar("Noté avec succès!", "Vous avez noté ${data.agent}",
            duration: const Duration(seconds: 5),
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
