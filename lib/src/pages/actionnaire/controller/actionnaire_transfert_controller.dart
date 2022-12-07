import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/actionnaires/actionnaire_api.dart';
import 'package:wm_solution/src/api/actionnaires/actionnaire_cotisation_api.dart';
import 'package:wm_solution/src/api/actionnaires/actionnaire_transfer_api.dart';
import 'package:wm_solution/src/models/actionnaire/actionnaire_model.dart';
import 'package:wm_solution/src/models/actionnaire/actionnaire_transfert_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class ActionnaireTransfertController extends GetxController
    with StateMixin<List<ActionnaireTransfertModel>> {
  final ActionnaireApi actionnaireApi = ActionnaireApi();
  final ActionnaireCotisationApi actionnaireCotisationApi =
      ActionnaireCotisationApi();
  final ActionnaireTransfertApi actionnaireTransfertApi =
      ActionnaireTransfertApi();
  final ProfilController profilController = Get.find();

  List<ActionnaireTransfertModel> actionnaireTransfertList = [];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  String? matriculeRecu;
  TextEditingController montantController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  @override
  void dispose() {
    montantController.dispose();
    super.dispose();
  }

  void clear() {
    matriculeRecu = null;
    montantController.clear();
  }

  void getList() async {
    await actionnaireTransfertApi.getAllData().then((response) {
      actionnaireTransfertList.clear();
      actionnaireTransfertList.addAll(response);
      change(actionnaireTransfertList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  void detailView(int id) => actionnaireTransfertApi.getOneData(id);

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await actionnaireTransfertApi.deleteData(id).then((value) {
        actionnaireTransfertList.clear();
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

  void transfertAction(ActionnaireModel data) async {
    try {
      _isLoading.value = true;
      final transfert = ActionnaireTransfertModel(
          matriculeEnvoi: data.matricule,
          matriculeRecu: matriculeRecu.toString(),
          montant: montantController.text,
          signature: profilController.user.matricule,
          created: DateTime.now());
      await actionnaireTransfertApi.insertData(transfert).then((value) async {
        final dataItem = ActionnaireModel(
            nom: data.nom,
            postNom: data.postNom,
            prenom: data.prenom,
            email: data.email,
            telephone: data.telephone,
            adresse: data.adresse,
            sexe: data.sexe,
            matricule: data.matricule,
            signature: data.signature,
            created: data.created,
            cotisations: data.cotisations - double.parse(value.montant));
        await actionnaireApi.updateData(dataItem).then((value) {
          clear();
          actionnaireTransfertList.clear();
          getList();
          Get.back();
          Get.snackbar("Transferer effectuée avec succès!",
              "Le transferer a bien été effectuée",
              backgroundColor: Colors.green,
              icon: const Icon(Icons.check),
              snackPosition: SnackPosition.TOP);
          _isLoading.value = false;
        });
      });
    } catch (e) {
      Get.snackbar("Erreur de soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }
}
