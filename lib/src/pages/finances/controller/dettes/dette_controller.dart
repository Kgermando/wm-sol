import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/finances/dette_api.dart';
import 'package:wm_solution/src/models/finances/creance_dette_model.dart';
import 'package:wm_solution/src/models/finances/dette_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/finances/controller/creance_dettes/creance_dette_controller.dart';

class DetteController extends GetxController with StateMixin<List<DetteModel>> {
  final DetteApi detteApi = DetteApi();
  final ProfilController profilController = Get.find();
  final CreanceDetteController creanceDetteController = Get.find();

  var detteList = <DetteModel>[].obs;

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
  void dispose() {
    nomCompletController.dispose();
    pieceJustificativeController.dispose();
    libelleController.dispose();
    montantController.dispose();
    motifDGController.dispose();
    motifDDController.dispose();
    super.dispose();
  }

  void clear() {
    nomCompletController.clear();
    pieceJustificativeController.clear();
    libelleController.clear();
    montantController.clear();
    motifDGController.clear();
    motifDDController.clear();
  }

  void getList() async {
    await detteApi.getAllData().then((response) {
      detteList.assignAll(response);
      List<DetteModel?> data = detteList
          .where((element) =>
              element.approbationDG == "Approved" &&
              element.approbationDD == "Approved")
          .toList();
      creanceDetteList.value = creanceDetteController.creanceDetteList
          .where((element) => element.creanceDette == 'dettes')
          .toList();

      for (var item in data) {
        _nonPaye.value += double.parse(item!.montant);
      }

      for (var item in creanceDetteList) {
        _paye.value += double.parse(item.montant);
      }
      change(detteList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await detteApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await detteApi.deleteData(id).then((value) {
        detteList.clear();
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
      final dataItem = DetteModel(
          nomComplet: nomCompletController.text,
          pieceJustificative: pieceJustificativeController.text,
          libelle: libelleController.text,
          montant: montantController.text,
          numeroOperation: 'Transaction-Dette-${detteList.length + 1}',
          statutPaie: 'false',
          signature: profilController.user.matricule,
          created: DateTime.now(),
          approbationDG: '-',
          motifDG: '-',
          signatureDG: '-',
          approbationDD: '-',
          motifDD: '-',
          signatureDD: '-');
      await detteApi.insertData(dataItem).then((value) {
        clear();
        detteList.clear();
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

  void submitUpdate(DetteModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = DetteModel(
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
      await detteApi.updateData(dataItem).then((value) {
        clear();
        detteList.clear();
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

  void submitobservation(DetteModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = DetteModel(
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
      await detteApi.updateData(dataItem).then((value) {
        clear();
        detteList.clear();
        // getList();
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

  void submitDG(DetteModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = DetteModel(
          id: data.id,
          nomComplet: data.nomComplet,
          pieceJustificative: data.pieceJustificative,
          libelle: data.libelle,
          montant: data.montant,
          numeroOperation: data.numeroOperation,
          statutPaie: data.statutPaie,
          signature: data.signature,
          created: data.created,
          approbationDG: approbationDG,
          motifDG:
              (motifDGController.text == '') ? '-' : motifDGController.text,
          signatureDG: profilController.user.matricule,
          approbationDD: data.approbationDD,
          motifDD: data.motifDD,
          signatureDD: data.signatureDD);
      await detteApi.updateData(dataItem).then((value) {
        clear();
        detteList.clear();
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

  void submitDD(DetteModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = DetteModel(
          id: data.id,
          nomComplet: data.nomComplet,
          pieceJustificative: data.pieceJustificative,
          libelle: data.libelle,
          montant: data.montant,
          numeroOperation: data.numeroOperation,
          statutPaie: data.statutPaie,
          signature: data.signature,
          created: data.created,
          approbationDG: '-',
          motifDG: '-',
          signatureDG: '-',
          approbationDD: approbationDD,
          motifDD:
              (motifDDController.text == '') ? '-' : motifDDController.text,
          signatureDD: profilController.user.matricule);
      await detteApi.updateData(dataItem).then((value) {
        clear();
        detteList.clear();
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
