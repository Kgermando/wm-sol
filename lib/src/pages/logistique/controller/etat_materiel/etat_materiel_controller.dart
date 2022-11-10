import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/logistiques/etat_materiel_api.dart';
import 'package:wm_solution/src/models/logistiques/etat_materiel_model.dart';
import 'package:wm_solution/src/models/logistiques/material_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart'; 
import 'package:wm_solution/src/pages/logistique/controller/materiels/materiel_controller.dart'; 

class EtatMaterielController extends GetxController
    with StateMixin<List<EtatMaterielModel>> {
  final EtatMaterielApi etatMaterielApi = EtatMaterielApi();
  final ProfilController profilController = Get.put(ProfilController());
  final MaterielController materielController = Get.put(MaterielController()); 

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
  List<MaterielModel> materielList = [];

  @override
  void onInit() {
    super.onInit();
    getList();
    getData();
  }

  @override
  void dispose() {
    motifDDController.dispose();
    super.dispose();
  }

  void getData() async {
    materielList = materielController.materielList
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
