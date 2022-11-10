import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/logistiques/entretien_api.dart'; 
import 'package:wm_solution/src/models/logistiques/entretien_model.dart';
import 'package:wm_solution/src/models/logistiques/immobilier_model.dart';
import 'package:wm_solution/src/models/logistiques/material_model.dart';
import 'package:wm_solution/src/models/logistiques/mobilier_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart'; 
import 'package:wm_solution/src/pages/logistique/controller/immobiliers/immobilier_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/materiels/materiel_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/mobiliers/mobilier_controller.dart';

class EntretienController extends GetxController
    with StateMixin<List<EntretienModel>> {
  final EntretienApi entretienApi = EntretienApi();
  final ProfilController profilController = Get.put(ProfilController());
  final MaterielController materielController = Get.put(MaterielController());
  final ImmobilierController immobilierController =
      Get.put(ImmobilierController());
  final MobilierController mobilierController = Get.put(MobilierController());

  var entretienList = <EntretienModel>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  // Approbations
  String approbationDD = '-';
  TextEditingController motifDDController = TextEditingController();

  String? nom;
  String? typeObjet;
  String? typeMaintenance;
  TextEditingController dureeTravauxController = TextEditingController();

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
    dureeTravauxController.dispose();
    super.dispose();
  }

  void clear() {
    motifDDController.clear();
    dureeTravauxController.clear();
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
    await entretienApi.getAllData().then((response) {
      entretienList.assignAll(response);
      change(entretienList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await entretienApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await entretienApi.deleteData(id).then((value) { 
        entretienList.clear();
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
      final dataItem = EntretienModel(
          nom: nom.toString(),
          typeObjet: typeObjet.toString(),
          typeMaintenance: typeMaintenance.toString(),
          dureeTravaux: dureeTravauxController.text,
          signature: profilController.user.matricule,
          created: DateTime.now(),
          approbationDD: '-',
          motifDD: '-',
          signatureDD: '-');
      await entretienApi.insertData(dataItem).then((value) {
        clear();
        entretienList.clear();
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

  void submitUpdate(EntretienModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = EntretienModel(
          id: data.id,
          nom: nom.toString(),
          typeObjet: typeObjet.toString(),
          typeMaintenance: typeMaintenance.toString(),
          dureeTravaux: dureeTravauxController.text,
          signature: profilController.user.matricule,
          created: data.created,
          approbationDD: '-',
          motifDD: '-',
          signatureDD: '-');
      await entretienApi.updateData(dataItem).then((value) {
        clear();
        entretienList.clear();
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

  void submitDD(EntretienModel data) async {
    try {
      _isLoading.value = true;
      final entretienModel = EntretienModel(
          id: data.id!,
          nom: data.nom,
          typeObjet: data.typeObjet,
          typeMaintenance: data.typeMaintenance,
          dureeTravaux: data.dureeTravaux,
          signature: data.signature,
          created: data.created,
          approbationDD: approbationDD,
          motifDD:
              (motifDDController.text == '') ? '-' : motifDDController.text,
          signatureDD: profilController.user.matricule);
      await entretienApi.updateData(entretienModel).then((value) {
        clear();
        entretienList.clear();
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
