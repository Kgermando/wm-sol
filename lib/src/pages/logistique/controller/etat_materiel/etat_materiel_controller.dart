import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/logistiques/etat_materiel_api.dart';
import 'package:wm_solution/src/models/logistiques/anguin_model.dart';
import 'package:wm_solution/src/models/logistiques/etat_materiel_model.dart';
import 'package:wm_solution/src/models/logistiques/immobilier_model.dart';
import 'package:wm_solution/src/models/logistiques/mobilier_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/automobiles/engin_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/immobiliers/immobilier_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/mobiliers/mobilier_controller.dart';

class EtatMaterielController extends GetxController
    with StateMixin<List<EtatMaterielModel>> {
  final EtatMaterielApi etatMaterielApi = EtatMaterielApi();
  final ProfilController profilController = Get.find();
  final EnginController enginController = Get.put(EnginController());
  final ImmobilierController immobilierController =
      Get.put(ImmobilierController());
  final MobilierController mobilierController = Get.put(MobilierController());

  var etatMaterielList = <EtatMaterielModel>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  // Approbations
  String approbationDD = '-';
  TextEditingController motifDDController = TextEditingController();

  String? nom;
  String? typeObjet;
  String? statut;

  String? statutObjet;

  List<String> nomList = [];
  List<MobilierModel> mobilierList = [];
  List<ImmobilierModel> immobilierList = [];
  List<AnguinModel> enguinsList = [];

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  @override
  void dispose() {
    motifDDController.dispose();

    super.dispose();
  }

  void getData() async {
    mobilierList = mobilierController.mobilierList
        .where((element) => element.approbationDD == "Approved")
        .toList();
    immobilierList = immobilierController.immobilierList
        .where((element) =>
            element.approbationDG == "Approved" &&
            element.approbationDD == "Approved")
        .toList();
    enguinsList = enginController.enginList
        .where((element) =>
            element.approbationDG == "Approved" &&
            element.approbationDD == "Approved")
        .toList();
  }

  void getList() async {
    await etatMaterielApi.getAllData().then((response) {
      etatMaterielList.assignAll(response);
      change(etatMaterielList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await etatMaterielApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await etatMaterielApi.deleteData(id).then((value) {
        etatMaterielList.clear();
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
      final dataItem = EtatMaterielModel(
          nom: nom.toString(),
          modele: '-',
          marque: '-',
          typeObjet: typeObjet.toString(),
          statut: statut.toString(),
          signature: profilController.user.matricule,
          created: DateTime.now(),
          approbationDD: '-',
          motifDD: '-',
          signatureDD: '-');
      await etatMaterielApi.insertData(dataItem).then((value) {
        etatMaterielList.clear();
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

  void submitUpdate(EtatMaterielModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = EtatMaterielModel(
          id: data.id,
          nom: nom.toString(),
          modele: data.modele,
          marque: data.marque,
          typeObjet: typeObjet.toString(),
          statut: statut.toString(),
          signature: profilController.user.matricule,
          created: data.created,
          approbationDD: '-',
          motifDD: '-',
          signatureDD: '-');
      await etatMaterielApi.updateData(dataItem).then((value) {
        etatMaterielList.clear();
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

  void submitStatut(EtatMaterielModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = EtatMaterielModel(
        id: data.id!,
        nom: data.nom,
        modele: data.modele,
        marque: data.marque,
        typeObjet: data.typeObjet,
        statut: statutObjet.toString(),
        signature: data.signature,
        created: data.created,
        approbationDD: data.approbationDD,
        motifDD: data.motifDD,
        signatureDD: data.signatureDD,
      );
      await etatMaterielApi.updateData(dataItem).then((value) {
        etatMaterielList.clear();
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

  void submitDD(EtatMaterielModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = EtatMaterielModel(
          id: data.id!,
          nom: data.nom,
          modele: data.modele,
          marque: data.marque,
          typeObjet: data.typeObjet,
          statut: data.statut,
          signature: data.signature,
          created: data.created,
          approbationDD: approbationDD,
          motifDD:
              (motifDDController.text == '') ? '-' : motifDDController.text,
          signatureDD: profilController.user.matricule);
      await etatMaterielApi.updateData(dataItem).then((value) {
        etatMaterielList.clear();
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
