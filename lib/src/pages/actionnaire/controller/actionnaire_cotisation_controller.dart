import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/actionnaires/actionnaire_api.dart';
import 'package:wm_solution/src/api/actionnaires/actionnaire_cotisation_api.dart';
import 'package:wm_solution/src/models/actionnaire/actionnaire_cotisation_model.dart';
import 'package:wm_solution/src/models/actionnaire/actionnaire_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class ActionnaireCotisationController extends GetxController
    with StateMixin<List<ActionnaireCotisationModel>> {
  final ActionnaireApi actionnaireApi = ActionnaireApi();
  final ActionnaireCotisationApi actionnaireCotisationApi =
      ActionnaireCotisationApi();
  final ProfilController profilController = Get.find();

  List<ActionnaireCotisationModel> actionnaireCotisationList = [];
  List<ActionnaireModel> actionnaireList = [];

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
    // moyenPaiementController = null;
    numeroTransactionController.clear();
  }

  void getList() async {
    actionnaireList = await actionnaireApi.getAllData();
    await actionnaireCotisationApi.getAllData().then((response) {
      actionnaireCotisationList.clear();
      actionnaireCotisationList.addAll(response);
      change(actionnaireCotisationList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  void detailView(int id) => actionnaireCotisationApi.getOneData(id);

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await actionnaireCotisationApi.deleteData(id).then((value) {
        actionnaireCotisationList.clear();
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

  void addCotisation(ActionnaireModel data) async {
    try {
      _isLoading.value = true;
      final cotisation = ActionnaireCotisationModel(
          reference: data.id!,
          nom: data.nom,
          postNom: data.postNom,
          prenom: data.prenom,
          matricule: data.matricule,
          montant:
              (montantController.text == "") ? '0.0' : montantController.text,
          note: (noteController.text == "") ? '-' : noteController.text,
          moyenPaiement: moyenPaiementController.text,
          numeroTransaction: numeroTransactionController.text,
          signature: profilController.user.matricule,
          created: DateTime.now());
      await actionnaireCotisationApi.insertData(cotisation).then((value) async {
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
            cotisations: data.cotisations + double.parse(value.montant));
        await actionnaireApi.updateData(dataItem).then((value) async {
          clear();
          actionnaireCotisationList.clear();
          getList();
          // Get.back();
          Get.snackbar("Cotisation ajouté avec succès!",
              "La Cotisation a bien été sauvegadé",
              backgroundColor: Colors.green,
              icon: const Icon(Icons.check),
              snackPosition: SnackPosition.TOP);
          _isLoading.value = false;
        });
      });
      _isLoading.value = false;
    } catch (e) {
      _isLoading.value = false;
      Get.snackbar("Erreur de soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }

  void transfertAction(ActionnaireModel data) async {
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
          signature: data.signature,
          created: data.created,
          cotisations: data.cotisations - double.parse(montantController.text));
      await actionnaireApi.updateData(dataItem).then((value) {
        clear();
        actionnaireCotisationList.clear();
        getList();
        Get.back();
        Get.snackbar("Archivage effectuée avec succès!",
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
