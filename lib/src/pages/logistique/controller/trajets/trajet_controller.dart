import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/logistiques/trajet_api.dart';
import 'package:wm_solution/src/models/logistiques/material_model.dart';
import 'package:wm_solution/src/models/logistiques/trajet_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class TrajetController extends GetxController
    with StateMixin<List<TrajetModel>> {
  final TrajetApi trajetApi = TrajetApi();
  final ProfilController profilController = Get.find();

  List<TrajetModel> trajetList = [];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  // Approbations
  String approbationDD = '-';
  TextEditingController motifDDController = TextEditingController();

  TextEditingController nomeroEntrepriseController = TextEditingController();
  TextEditingController conducteurController = TextEditingController();
  TextEditingController trajetDeController = TextEditingController();
  TextEditingController trajetAController = TextEditingController();
  TextEditingController missionController = TextEditingController();
  TextEditingController kilometrageSoriteController = TextEditingController();
  TextEditingController kilometrageRetourController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  @override
  void dispose() {
    motifDDController.dispose();
    conducteurController.dispose();
    trajetDeController.dispose();
    trajetAController.dispose();
    missionController.dispose();
    kilometrageSoriteController.dispose();
    kilometrageRetourController.dispose();

    super.dispose();
  }

  void clearTextEditingControllers() {
    motifDDController.clear();
    conducteurController.clear();
    trajetDeController.clear();
    trajetAController.clear();
    missionController.clear();
    kilometrageSoriteController.clear();
    kilometrageRetourController.clear();
  }

  void getList() async {
    await trajetApi.getAllData().then((response) {
      trajetList.clear();
      trajetList.addAll(response);
      change(trajetList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await trajetApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await trajetApi.deleteData(id).then((value) {
        trajetList.clear();
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

  void submit(MaterielModel data) async {
    try {
      _isLoading.value = true;
      final trajetModel = TrajetModel(
          nomeroEntreprise: data.identifiant,
          conducteur: conducteurController.text,
          trajetDe: trajetDeController.text,
          trajetA: trajetAController.text,
          mission: missionController.text,
          kilometrageSorite: kilometrageSoriteController.text,
          kilometrageRetour: '-',
          signature: profilController.user.matricule,
          reference: data.id!,
          created: DateTime.now(),
          approbationDD: '-',
          motifDD: '-',
          signatureDD: '-');
      await trajetApi.insertData(trajetModel).then((value) {
        clearTextEditingControllers();
        trajetList.clear();
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

  void submitUpdate(TrajetModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = TrajetModel(
          id: data.id!,
          nomeroEntreprise: data.nomeroEntreprise,
          conducteur: data.conducteur,
          trajetDe: data.trajetDe,
          trajetA: data.trajetA,
          mission: data.mission,
          kilometrageSorite: data.kilometrageSorite,
          kilometrageRetour:
              kilometrageRetourController.text, // Retour de l'engin
          signature: profilController.user.matricule,
          reference: data.reference,
          created: DateTime.now(),
          approbationDD: '-',
          motifDD: '-',
          signatureDD: '-');
      await trajetApi.updateData(dataItem).then((value) {
        clearTextEditingControllers();
        trajetList.clear();
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

  void submitDD(TrajetModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = TrajetModel(
          id: data.id!,
          nomeroEntreprise: data.nomeroEntreprise,
          conducteur: data.conducteur,
          trajetDe: data.trajetDe,
          trajetA: data.trajetA,
          mission: data.mission,
          kilometrageSorite: data.kilometrageSorite,
          kilometrageRetour: data.kilometrageRetour,
          signature: data.signature,
          reference: data.reference,
          created: data.created,
          approbationDD: approbationDD,
          motifDD:
              (motifDDController.text == '') ? '-' : motifDDController.text,
          signatureDD: profilController.user.matricule);
      await trajetApi.updateData(dataItem).then((value) {
        trajetList.clear();
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
