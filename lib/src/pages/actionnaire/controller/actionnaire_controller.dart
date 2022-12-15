import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/actionnaires/actionnaire_api.dart';
import 'package:wm_solution/src/api/actionnaires/actionnaire_cotisation_api.dart';
import 'package:wm_solution/src/models/actionnaire/actionnaire_model.dart';
import 'package:wm_solution/src/models/rh/agent_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class ActionnaireController extends GetxController
    with StateMixin<List<ActionnaireModel>> {
  final ActionnaireApi actionnaireApi = ActionnaireApi();
  final ActionnaireCotisationApi actionnaireCotisationApi =
      ActionnaireCotisationApi();
  final ProfilController profilController = Get.find();

  List<ActionnaireModel> actionnaireList = [];
  List<ActionnaireModel> actionnaireLimitList = [];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  TextEditingController montantController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController moyenPaiementController = TextEditingController();
  TextEditingController numeroTransactionController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  @override
  void dispose() {
    montantController.dispose();
    noteController.dispose();
    moyenPaiementController.dispose();
    numeroTransactionController.dispose();

    super.dispose();
  }

  void clear() {
    montantController.clear();
    noteController.clear();
    moyenPaiementController.clear();
    numeroTransactionController.clear();
  }

  void getList() async {
    await actionnaireApi.getAllData().then((response) async {
      actionnaireList.clear();
      actionnaireList.addAll(response);

      await actionnaireApi.getAllDataLimit().then((response) {
      actionnaireLimitList.clear();
      actionnaireLimitList.addAll(response);
      change(actionnaireList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    }); 
      change(actionnaireList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    }); 
  }

   detailView(int id) async {
    final data = await actionnaireApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await actionnaireApi.deleteData(id).then((value) {
        actionnaireList.clear();
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

  void submit(AgentModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = ActionnaireModel(
          nom: data.nom,
          postNom: data.postNom,
          prenom: data.prenom,
          email: data.email,
          telephone: data.telephone,
          adresse: data.adresse,
          sexe: data.sexe,
          matricule: data.matricule,
          signature: profilController.user.matricule,
          created: DateTime.now(),
          cotisations: 0.0);
      await actionnaireApi.insertData(dataItem).then((value) {
        actionnaireList.clear();
        getList();
        Get.back();
        Get.snackbar("Actionnaire ajouté avec succès!",
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
