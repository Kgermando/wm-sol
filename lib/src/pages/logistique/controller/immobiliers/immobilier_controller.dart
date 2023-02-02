import 'package:flutter/material.dart';
import 'package:get/get.dart';  
import 'package:wm_solution/src/api/logistiques/immobiler_api.dart'; 
import 'package:wm_solution/src/models/logistiques/immobilier_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class ImmobilierController extends GetxController
    with StateMixin<List<ImmobilierModel>> {
  final ImmobilierApi immobilierApi = ImmobilierApi();
  final ProfilController profilController = Get.find();

  List<ImmobilierModel> immobilierList = [];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  // Approbations
  String approbationDG = '-';
  String approbationDD = '-';
  TextEditingController motifDGController = TextEditingController();
  TextEditingController motifDDController = TextEditingController();

  TextEditingController typeAllocationController = TextEditingController();
  TextEditingController adresseController = TextEditingController();
  TextEditingController numeroCertificatController = TextEditingController();
  TextEditingController superficieController = TextEditingController();
  TextEditingController dateAcquisitionController = TextEditingController();
 
  @override
  void onInit() {
    super.onInit();
    getList();
  }

  @override
  void dispose() {
    motifDGController.dispose();
    motifDDController.dispose();
    typeAllocationController.dispose();
    adresseController.dispose();
    numeroCertificatController.dispose();
    superficieController.dispose();
    dateAcquisitionController.dispose();

    super.dispose();
  }

  void clear() {
    approbationDG = '-';
    approbationDD = '-';
    motifDGController.clear();
    motifDDController.clear();
    typeAllocationController.clear();
    adresseController.clear();
    numeroCertificatController.clear();
    superficieController.clear();
    dateAcquisitionController.clear();
  }

  void getList() async {
    await immobilierApi.getAllData().then((response) {
      immobilierList.clear();
      immobilierList.addAll(response);
      change(immobilierList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await immobilierApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await immobilierApi.deleteData(id).then((value) {
        immobilierList.clear();
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
      final dataItem = ImmobilierModel(
          typeAllocation: typeAllocationController.text,
          adresse: adresseController.text,
          numeroCertificat: numeroCertificatController.text,
          superficie: superficieController.text,
          dateAcquisition: DateTime.parse(dateAcquisitionController.text),
          signature: profilController.user.matricule,
          created: DateTime.now(),
          approbationDG: '-',
          motifDG: '-',
          signatureDG: '-',
          approbationDD: '-',
          motifDD: '-',
          signatureDD: '-');
      await immobilierApi.insertData(dataItem).then((value) {
        clear();
        immobilierList.clear();
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

  void submitUpdate(ImmobilierModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = ImmobilierModel(
          id: data.id,
          typeAllocation: typeAllocationController.text,
          adresse: adresseController.text,
          numeroCertificat: numeroCertificatController.text,
          superficie: superficieController.text,
          dateAcquisition: DateTime.parse(dateAcquisitionController.text),
          signature: profilController.user.matricule,
          created: data.created,
          approbationDG: '-',
          motifDG: '-',
          signatureDG: '-',
          approbationDD: '-',
          motifDD: '-',
          signatureDD: '-');
      await immobilierApi.updateData(dataItem).then((value) {
        clear();
        immobilierList.clear();
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

  void submitDG(ImmobilierModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = ImmobilierModel(
          id: data.id!,
          typeAllocation: data.typeAllocation,
          adresse: data.adresse,
          numeroCertificat: data.numeroCertificat,
          superficie: data.superficie,
          dateAcquisition: data.dateAcquisition,
          signature: data.signature,
          created: data.created,
          approbationDG: approbationDG,
          motifDG:
              (motifDGController.text == '') ? '-' : motifDGController.text,
          signatureDG: profilController.user.matricule,
          approbationDD: data.approbationDD,
          motifDD: data.motifDD,
          signatureDD: data.signatureDD);
      await immobilierApi.updateData(dataItem).then((value) {
        clear();
        immobilierList.clear();
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

  void submitDD(ImmobilierModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = ImmobilierModel(
          id: data.id!,
          typeAllocation: data.typeAllocation,
          adresse: data.adresse,
          numeroCertificat: data.numeroCertificat,
          superficie: data.superficie,
          dateAcquisition: data.dateAcquisition,
          signature: data.signature,
          created: data.created,
          approbationDG: '-',
          motifDG: '-',
          signatureDG: '-',
          approbationDD: approbationDD,
          motifDD:
              (motifDDController.text == '') ? '-' : motifDDController.text,
          signatureDD: profilController.user.matricule);
      await immobilierApi.updateData(dataItem).then((value) {
        clear();
        immobilierList.clear();
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
