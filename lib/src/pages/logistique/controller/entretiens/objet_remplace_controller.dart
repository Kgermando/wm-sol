import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/logistiques/objet_remplace_api.dart';
import 'package:wm_solution/src/models/logistiques/entretien_model.dart';
import 'package:wm_solution/src/models/logistiques/objet_remplace_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/entretiens/entretiens_controller.dart';

class ObjetRemplaceController extends GetxController
    with StateMixin<List<ObjetRemplaceModel>> {
  final ObjetRemplaceApi objetRemplaceApi = ObjetRemplaceApi();
  final EntretienController entretienController = EntretienController();
  final ProfilController profilController = Get.find();

  ScrollController controllerTable = ScrollController();

  List<ObjetRemplaceModel> objetRemplaceList = [];

  final GlobalKey<FormState> formObjetKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  TextEditingController nomObjetController = TextEditingController();
  TextEditingController coutController = TextEditingController();
  TextEditingController caracteristiqueController = TextEditingController();
  TextEditingController observationController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  @override
  void dispose() {
    nomObjetController.dispose();
    coutController.dispose();
    caracteristiqueController.dispose();
    observationController.dispose();

    super.dispose();
  }

  void clear() {
    nomObjetController.clear();
    coutController.clear();
    caracteristiqueController.clear();
    observationController.clear();
  }

  void getList() async {
    await objetRemplaceApi.getAllData().then((response) {
      objetRemplaceList.clear();
      objetRemplaceList.addAll(response);
      change(objetRemplaceList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await objetRemplaceApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await objetRemplaceApi.deleteData(id).then((value) {
        clear();
        objetRemplaceList.clear();
        getList();
        Get.back();
        Get.snackbar("Supprim?? avec succ??s!", "Cet ??l??ment a bien ??t?? supprim??",
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

  void submitObjetRemplace(EntretienModel data) async {
    try {
      _isLoading.value = true;
      final objetRemplace = ObjetRemplaceModel(
          reference: data.id!,
          nom: nomObjetController.text,
          cout: coutController.text,
          caracteristique: caracteristiqueController.text,
          observation: observationController.text);
      await objetRemplaceApi.insertData(objetRemplace).then((value) {
        clear();
        objetRemplaceList.clear();
        getList();
        // Get.back();
        Get.snackbar("Soumission effectu??e avec succ??s!",
            "Le document a bien ??t?? sauvegad??",
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

  void submitUpdate(ObjetRemplaceModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = ObjetRemplaceModel(
          id: data.id!,
          reference: data.reference,
          nom: nomObjetController.text,
          cout: coutController.text,
          caracteristique: caracteristiqueController.text,
          observation: observationController.text);
      await objetRemplaceApi.updateData(dataItem).then((value) {
        clear();
        objetRemplaceList.clear();
        getList();
        Get.back();
        Get.snackbar("Soumission effectu??e avec succ??s!",
            "Le document a bien ??t?? sauvegad??",
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
