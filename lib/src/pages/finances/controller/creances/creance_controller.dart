import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/finances/creance_api.dart';
import 'package:wm_solution/src/models/finances/creance_dette_model.dart';
import 'package:wm_solution/src/models/finances/creances_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/creance_dettes/creance_dette_controller.dart';

class CreanceController extends GetxController
    with StateMixin<List<CreanceModel>> {
  final CreanceApi creanceApi = CreanceApi();
  final ProfilController profilController = Get.find();
  final CreanceDetteController creanceDetteController = Get.find();

  var creanceList = <CreanceModel>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final TextEditingController nomCompletController = TextEditingController();
  final TextEditingController pieceJustificativeController =
      TextEditingController();
  final TextEditingController libelleController = TextEditingController();
  final TextEditingController montantController = TextEditingController();

  // Approbations
  final formKeyBudget = GlobalKey<FormState>();

  String approbationDG = '-';
  String approbationDD = '-';
  TextEditingController motifDGController = TextEditingController();
  TextEditingController motifDDController = TextEditingController();

  final _nonPaye = 0.0.obs; // total Créance
  double get nonPaye => _nonPaye.value;
  final _paye = 0.0.obs; // total creanceDette
  double get paye => _paye.value;

  var creanceDetteList = <CreanceDetteModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  @override
  void refresh() {
    getList();
    super.refresh();
  }

  @override
  void dispose() {
    nomCompletController.dispose();
    pieceJustificativeController.dispose();
    libelleController.dispose();
    montantController.dispose();
    motifDGController.dispose();
    motifDDController.dispose();
    super.dispose();
  }

  void getList() async {
    await creanceApi.getAllData().then((response) {
      creanceList.assignAll(response);
      List<CreanceModel?> data = creanceList
          .where((element) =>
              element.approbationDG == "Approved" &&
              element.approbationDD == "Approved")
          .toList();
      creanceDetteList.value = creanceDetteController.creanceDetteList
          .where((element) => element.creanceDette == 'creances')
          .toList();

      for (var item in data) {
        _nonPaye.value += double.parse(item!.montant);
      }

      for (var item in creanceDetteList) {
        _paye.value += double.parse(item.montant);
      }
      change(creanceList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await creanceApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await creanceApi.deleteData(id).then((value) {
        creanceList.clear();
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
      final dataItem = CreanceModel(
          nomComplet: nomCompletController.text,
          pieceJustificative: pieceJustificativeController.text,
          libelle: libelleController.text,
          montant: montantController.text,
          numeroOperation: 'Transaction-Creance-${creanceList.length + 1}',
          statutPaie: 'false',
          signature: profilController.user.matricule,
          created: DateTime.now(),
          approbationDG: '-',
          motifDG: '-',
          signatureDG: '-',
          approbationDD: '-',
          motifDD: '-',
          signatureDD: '-');
      await creanceApi.insertData(dataItem).then((value) {
        creanceList.clear();
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

  void submitUpdate(CreanceModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = CreanceModel(
          id: data.id,
          nomComplet: nomCompletController.text,
          pieceJustificative: pieceJustificativeController.text,
          libelle: libelleController.text,
          montant: montantController.text,
          numeroOperation: data.numeroOperation,
          statutPaie: data.statutPaie,
          signature: profilController.user.matricule,
          created: data.created,
          approbationDG: data.approbationDG,
          motifDG: data.motifDG,
          signatureDG: data.signatureDG,
          approbationDD: data.approbationDD,
          motifDD: data.motifDD,
          signatureDD: data.signatureDD);
      await creanceApi.updateData(dataItem).then((value) {
        creanceList.clear();
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

  void submitobservation(CreanceModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = CreanceModel(
          id: data.id,
          nomComplet: data.nomComplet,
          pieceJustificative: data.pieceJustificative,
          libelle: data.libelle,
          montant: data.montant,
          numeroOperation: data.numeroOperation,
          statutPaie: 'true',
          signature: data.signature,
          created: data.created,
          approbationDG: data.approbationDG,
          motifDG: data.motifDG,
          signatureDG: data.signatureDG,
          approbationDD: data.approbationDD,
          motifDD: data.motifDD,
          signatureDD: data.signatureDD);
      await creanceApi.updateData(dataItem).then((value) {
        creanceList.clear();
        getList();
        Get.back();
        Get.snackbar(
            "Créance payé avec succès!", "Le document a bien été sauvegader",
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

  void submitDG(CreanceModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = CreanceModel(
          id: data.id,
          nomComplet: nomCompletController.text,
          pieceJustificative: pieceJustificativeController.text,
          libelle: libelleController.text,
          montant: montantController.text,
          numeroOperation: data.numeroOperation,
          statutPaie: data.statutPaie,
          signature: profilController.user.matricule,
          created: data.created,
          approbationDG: approbationDG,
          motifDG:
              (motifDGController.text == '') ? '-' : motifDGController.text,
          signatureDG: profilController.user.matricule,
          approbationDD: data.approbationDD,
          motifDD: data.motifDD,
          signatureDD: data.signatureDD);
      await creanceApi.updateData(dataItem).then((value) {
        creanceList.clear();
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

  void submitDD(CreanceModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = CreanceModel(
          id: data.id,
          nomComplet: nomCompletController.text,
          pieceJustificative: pieceJustificativeController.text,
          libelle: libelleController.text,
          montant: montantController.text,
          numeroOperation: data.numeroOperation,
          statutPaie: data.statutPaie,
          signature: profilController.user.matricule,
          created: data.created,
          approbationDG: '-',
          motifDG: '-',
          signatureDG: '-',
          approbationDD: approbationDD,
          motifDD:
              (motifDDController.text == '') ? '-' : motifDDController.text,
          signatureDD: profilController.user.matricule);
      await creanceApi.updateData(dataItem).then((value) {
        creanceList.clear();
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
