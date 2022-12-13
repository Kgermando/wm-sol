import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/comptabilite/bilan_api.dart';
import 'package:wm_solution/src/models/comptabilites/bilan_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';

class BilanController extends GetxController with StateMixin<List<BilanModel>> {
  final BilanApi bilanApi = BilanApi();
  final ProfilController profilController = Get.find();

  List<BilanModel> bilanList = [];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  TextEditingController titleBilanController = TextEditingController();

  // Approbations
  final formKeyBudget = GlobalKey<FormState>();

  String approbationDG = '-';
  String approbationDD = '-';
  TextEditingController motifDDController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  @override
  void dispose() {
    motifDDController.dispose();
    titleBilanController.dispose();
    super.dispose();
  }

  void clear() {
    motifDDController.clear();
    titleBilanController.clear();
  }

  void getList() async {
    await bilanApi.getAllData().then((response) {
      bilanList.clear();
      bilanList.addAll(response);
      change(bilanList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await bilanApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await bilanApi.deleteData(id).then((value) {
        bilanList.clear();
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
      final bilan = BilanModel(
          titleBilan: titleBilanController.text,
          signature: profilController.user.matricule,
          created: DateTime.now(),
          isSubmit: 'false',
          approbationDD: '-',
          motifDD: '-',
          signatureDD: '-');
      await bilanApi.insertData(bilan).then((value) {
        clear(); 
        Get.toNamed(ComptabiliteRoutes.comptabiliteBilanDetail, arguments: value);
        Get.snackbar("Soumission effectuée avec succès!",
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

  void sendDD(BilanModel data) async {
    try {
      _isLoading.value = true;
      final bilanModel = BilanModel(
          id: data.id,
          titleBilan: data.titleBilan,
          signature: data.signature,
          created: data.created,
          isSubmit: 'true',
          approbationDD: data.approbationDD,
          motifDD: data.motifDD,
          signatureDD: data.signatureDD);
      await bilanApi.updateData(bilanModel).then((value) {
        clear();
        bilanList.clear();
        getList();
        Get.back();
        Get.snackbar("Soumission effectuée avec succès!",
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

  void submitDD(BilanModel data) async {
    try {
      _isLoading.value = true;
      final bilanModel = BilanModel(
          id: data.id,
          titleBilan: data.titleBilan,
          signature: data.signature,
          created: data.created,
          isSubmit: 'true',
          approbationDD: approbationDD,
          motifDD:
              (motifDDController.text == '') ? '-' : motifDDController.text,
          signatureDD: profilController.user.matricule);
      await bilanApi.updateData(bilanModel).then((value) {
        clear();
        bilanList.clear();
        getList();
        Get.back();
        Get.snackbar("Soumission effectuée avec succès!",
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
