import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/actionnaires/actionnaire_api.dart';
import 'package:wm_solution/src/api/actionnaires/actionnaire_cotisation_api.dart';
import 'package:wm_solution/src/api/actionnaires/actionnaire_transfer_api.dart';
import 'package:wm_solution/src/models/actionnaire/actionnaire_model.dart';
import 'package:wm_solution/src/models/actionnaire/actionnaire_transfert_model.dart';
import 'package:wm_solution/src/pages/actionnaire/controller/actionnaire_controller.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class ActionnaireTransfertController extends GetxController
    with StateMixin<List<ActionnaireTransfertModel>> {
  final ActionnaireApi actionnaireApi = ActionnaireApi();
  final ActionnaireCotisationApi actionnaireCotisationApi =
      ActionnaireCotisationApi();
  final ActionnaireTransfertApi actionnaireTransfertApi =
      ActionnaireTransfertApi();
  final ProfilController profilController = Get.find();
  final ActionnaireController actionnaireController = Get.find();

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
      _isLoading.value = false;
      Get.snackbar("Erreur de soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }

  void transfertAction(
      ActionnaireModel data, String montant, String matriculeEnvoi) async {
    try {
      _isLoading.value = true;
      ActionnaireModel personRecoi = actionnaireController.actionnaireList
          .where((element) => element.matricule == matriculeRecu.toString())
          .first;
      final dataItemRecoit = ActionnaireModel(
          id: personRecoi.id,
          nom: personRecoi.nom,
          postNom: personRecoi.postNom,
          prenom: personRecoi.prenom,
          email: personRecoi.email,
          telephone: personRecoi.telephone,
          adresse: personRecoi.adresse,
          sexe: personRecoi.sexe,
          matricule: personRecoi.matricule,
          signature: personRecoi.signature,
          created: personRecoi.created,
          cotisations: personRecoi.cotisations + double.parse(montant));
      await actionnaireApi.updateData(dataItemRecoit).then((value) async {
        final transfert = ActionnaireTransfertModel(
            matriculeEnvoi: matriculeEnvoi, // Celui qui donne l'argent
            matriculeRecu:
                matriculeRecu.toString(), // Celui qui recoit l'argent
            montant: montant,
            signature: profilController.user.matricule,
            created: DateTime.now());
        await actionnaireTransfertApi.insertData(transfert).then((value) async {
          final dataItem = ActionnaireModel(
              id: data.id,
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
          await actionnaireApi.updateData(dataItem).then((value) async {
            clear();
            actionnaireTransfertList.clear();
            getList();
            Get.snackbar("Transferer effectuée avec succès!",
                "Le transferer a bien été effectuée",
                backgroundColor: Colors.green,
                icon: const Icon(Icons.check),
                snackPosition: SnackPosition.TOP);
            _isLoading.value = false;
          });
        });
      });
    } catch (e) {
      _isLoading.value = false;
      Get.snackbar("Erreur de soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }
}
