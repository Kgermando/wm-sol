import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/rh/trans_rest_agents_api.dart';
import 'package:wm_solution/src/models/rh/transport_restauration_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class TransportRestPersonnelsController extends GetxController
    with StateMixin<List<TransRestAgentsModel>> {
  final TransRestAgentsApi transRestAgentsApi = TransRestAgentsApi();
  final ProfilController profilController = Get.find();

  List<TransRestAgentsModel> transRestAgentList = [];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final _isChecked = false.obs;
  bool get isChecked => _isChecked.value;

  final _isDeleting = false.obs;
  bool get isDeleting => _isDeleting.value;

  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController matriculeController = TextEditingController();
  final TextEditingController montantController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  @override
  void dispose() {
    nomController.dispose();
    prenomController.dispose();
    matriculeController.dispose();
    montantController.dispose();
    super.dispose();
  }

  void clear() {
    nomController.clear();
    prenomController.clear();
    matriculeController.clear();
    matriculeController.text.isEmpty;
    montantController.clear();
  }

  void getList() {
    transRestAgentsApi.getAllData().then((response) {
      transRestAgentList.clear();
      transRestAgentList.addAll(response);
      change(response, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await transRestAgentsApi.getOneData(id);
    return data;
  }

  void submitTransRestAgents(TransportRestaurationModel data) async {
    try {
      final form = formKey.currentState!;
      if (form.validate()) {
        _isLoading.value = true;
        final transRest = TransRestAgentsModel(
            reference: data.id!,
            nom: nomController.text,
            prenom: prenomController.text,
            matricule: matriculeController.text,
            montant: montantController.text,
            observation: "false");
        await transRestAgentsApi.insertData(transRest).then((value) {
          clear();
          transRestAgentList.clear();
          getList();
          Get.back();
          Get.snackbar("Ajouté avec succès!",
              "Vous avez ajouté ${nomController.text} à la liste",
              duration: const Duration(seconds: 5),
              backgroundColor: Colors.green,
              icon: const Icon(Icons.check),
              snackPosition: SnackPosition.TOP);
          _isLoading.value = false;
        });
        form.reset();
      }
    } catch (e) {
      Get.snackbar("Erreur de soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }

  void updateTransRestAgents(TransRestAgentsModel data) async {
    try {
      final form = formKey.currentState!;
      if (form.validate()) {
        _isLoading.value = true;
        final transRest = TransRestAgentsModel(
            reference: data.id!,
            nom: data.nom,
            prenom: data.prenom,
            matricule: data.matricule,
            montant: data.montant,
            observation: "true");
        await transRestAgentsApi.insertData(transRest).then((value) {
          clear();
          transRestAgentList.clear();
          getList();
          Get.back();
          Get.snackbar("Ajouté avec succès!",
              "Vous avez ajouté ${nomController.text} à la liste",
              duration: const Duration(seconds: 5),
              backgroundColor: Colors.green,
              icon: const Icon(Icons.check),
              snackPosition: SnackPosition.TOP);
          _isLoading.value = false;
        });
        form.reset();
      }
    } catch (e) {
      Get.snackbar("Erreur de soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }

  void deleteTransRestAgents(int id) async {
    try {
      _isLoading.value = true;
      await transRestAgentsApi.deleteData(id).then((value) {
        transRestAgentList.clear();
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
}
