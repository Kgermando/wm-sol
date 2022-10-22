import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/logistiques/objet_remplace_api.dart';
import 'package:wm_solution/src/models/logistiques/objet_remplace_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/entretiens/entretiens_controller.dart';

class ObjetRemplaceController extends GetxController
    with StateMixin<List<ObjetRemplaceModel>> {
  final ObjetRemplaceApi objetRemplaceApi = ObjetRemplaceApi();
  final EntretienController entretienController = EntretienController();
  final ProfilController profilController = Get.find();

  ScrollController controllerTable = ScrollController();
  
  var objetRemplaceList = <ObjetRemplaceModel>[].obs;

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
 

  void getList() async {
    await objetRemplaceApi.getAllData().then((response) {
      objetRemplaceList.assignAll(response);
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
        objetRemplaceList.clear();
        getList();
        // Get.back();
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


  void submitObjetRemplace() async {
    int? id = entretienController.entretienList.map((element) => element.id).last;
    try {
      _isLoading.value = true;
      final objetRemplace = ObjetRemplaceModel(
          reference:  id! + 1,
          nom: nomObjetController.text,
          cout: coutController.text,
          caracteristique: caracteristiqueController.text,
          observation: observationController.text);
      await objetRemplaceApi
          .insertData(objetRemplace)
          .then((value) {
        objetRemplaceList.clear();
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

 

  void submitUpdate(ObjetRemplaceModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = ObjetRemplaceModel(
          reference: data.reference,
          nom: nomObjetController.text,
          cout: coutController.text,
          caracteristique: caracteristiqueController.text,
          observation: observationController.text);
      await objetRemplaceApi.updateData(dataItem).then((value) {
        objetRemplaceList.clear();
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
