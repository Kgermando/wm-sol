import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/logistiques/mobilier_api.dart';
import 'package:wm_solution/src/models/logistiques/mobilier_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class MobilierController extends GetxController
    with StateMixin<List<MobilierModel>> {
  final MobilierApi mobilierApi = MobilierApi();
  final ProfilController profilController = Get.find();

  List<MobilierModel> mobilierList = [];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  // Approbations
  String approbationDD = '-';
  TextEditingController motifDDController = TextEditingController();

  TextEditingController nomController = TextEditingController();
  TextEditingController modeleController = TextEditingController();
  TextEditingController marqueController = TextEditingController();
  TextEditingController descriptionMobilierController = TextEditingController();
  TextEditingController nombreController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  @override
  void dispose() {
    motifDDController.dispose();
    nomController.dispose();
    modeleController.dispose();
    marqueController.dispose();
    descriptionMobilierController.dispose();
    nombreController.dispose();
    super.dispose();
  }

  void clear() {
    approbationDD = '-';
    nomController.clear();
    modeleController.clear();
    marqueController.clear();
    descriptionMobilierController.clear();
    nombreController.clear();
  }

  void getList() async {
    await mobilierApi.getAllData().then((response) {
      mobilierList.clear();
      mobilierList.assignAll(response);
      change(mobilierList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await mobilierApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await mobilierApi.deleteData(id).then((value) {
        mobilierList.clear();
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

  void submit() async {
    try {
      _isLoading.value = true;
      final dataItem = MobilierModel(
          nom: nomController.text,
          modele: modeleController.text,
          marque: marqueController.text,
          descriptionMobilier: descriptionMobilierController.text,
          nombre: nombreController.text,
          signature: profilController.user.matricule,
          created: DateTime.now(),
          approbationDD: '-',
          motifDD: '-',
          signatureDD: '-');
      await mobilierApi.insertData(dataItem).then((value) {
        clear();
        mobilierList.clear();
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
      _isLoading.value = false;
      Get.snackbar("Erreur de soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }

  void submitUpdate(MobilierModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = MobilierModel(
          id: data.id,
          nom: nomController.text,
          modele: modeleController.text,
          marque: marqueController.text,
          descriptionMobilier: descriptionMobilierController.text,
          nombre: nombreController.text,
          signature: profilController.user.matricule,
          created: data.created,
          approbationDD: '-',
          motifDD: '-',
          signatureDD: '-');
      await mobilierApi.updateData(dataItem).then((value) {
        clear();
        mobilierList.clear();
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
      _isLoading.value = false;
      Get.snackbar("Erreur de soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }

  void submitDD(MobilierModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = MobilierModel(
          id: data.id!,
          nom: data.nom,
          modele: data.modele,
          marque: data.marque,
          descriptionMobilier: data.descriptionMobilier,
          nombre: data.nombre,
          signature: data.signature,
          created: data.created,
          approbationDD: approbationDD,
          motifDD:
              (motifDDController.text == '') ? '-' : motifDDController.text,
          signatureDD: profilController.user.matricule);
      await mobilierApi.updateData(dataItem).then((value) {
        clear();
        mobilierList.clear();
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
      _isLoading.value = false;
      Get.snackbar("Erreur de soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }
}
