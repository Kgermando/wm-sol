import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/logistiques/carburant_api.dart';
import 'package:wm_solution/src/models/comm_maketing/annuaire_model.dart';
import 'package:wm_solution/src/models/logistiques/anguin_model.dart';
import 'package:wm_solution/src/models/logistiques/carburant_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/marketing/controller/annuaire/annuaire_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/automobiles/engin_controller.dart';
import 'package:wm_solution/src/utils/carburant_dropdown.dart';

class CarburantController extends GetxController
    with StateMixin<List<CarburantModel>> {
  final CarburantApi carburantApi = CarburantApi();
  final ProfilController profilController = Get.put(ProfilController());
  final EnginController enginController = Get.put(EnginController());
  final AnnuaireController annuaireController = Get.put(AnnuaireController());

  var carburantList = <CarburantModel>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  // Approbations
  String approbationDD = '-';
  TextEditingController motifDDController = TextEditingController();

  List<String> carburantDropList = CarburantDropdown().carburantDrop;

  String? operationEntreSortie;
  String? typeCaburant;
  String? fournisseur;
  TextEditingController nomeroFactureAchatController = TextEditingController();
  TextEditingController prixAchatParLitreController = TextEditingController();
  TextEditingController nomReceptionisteController = TextEditingController();
  String? numeroPlaque;
  TextEditingController qtyAchatController = TextEditingController();
  TextEditingController dateHeureSortieAnguinController =
      TextEditingController();

  List<AnguinModel> enginList = [];
  List<AnnuaireModel> annuaireList = [];

  @override
  void onInit() {
    super.onInit();
    getList();
    getData();
  }

  @override
  void dispose() {
    motifDDController.dispose();
    nomeroFactureAchatController.dispose();
    prixAchatParLitreController.dispose();
    nomReceptionisteController.dispose();
    qtyAchatController.dispose();
    dateHeureSortieAnguinController.dispose();
    super.dispose();
  }

  void clearTextEditingControllers() {
    motifDDController.clear();
    nomeroFactureAchatController.clear();
    prixAchatParLitreController.clear();
    nomReceptionisteController.clear();
    qtyAchatController.clear();
    dateHeureSortieAnguinController.clear();
 
  }

  void getData() async {
    enginList = enginController.enginList
        .where((element) =>
            element.approbationDG == "Approved" &&
            element.approbationDD == "Approved")
        .toList();
    annuaireList = annuaireController.annuaireList
        .where((element) => element.categorie == 'Fournisseur')
        .toList();
  }

  void getList() async {
    await carburantApi.getAllData().then((response) {
      carburantList.assignAll(response);
      change(carburantList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await carburantApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await carburantApi.deleteData(id).then((value) {
        carburantList.clear();
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
      final dataItem = CarburantModel(
          operationEntreSortie: operationEntreSortie.toString(),
          typeCaburant: typeCaburant.toString(),
          fournisseur: (fournisseur == '') ? '-' : fournisseur.toString(),
          nomeroFactureAchat: (nomeroFactureAchatController.text == '')
              ? '-'
              : nomeroFactureAchatController.text,
          prixAchatParLitre: (prixAchatParLitreController.text == '')
              ? '-'
              : prixAchatParLitreController.text,
          nomReceptioniste: (nomReceptionisteController.text == '')
              ? '-'
              : nomReceptionisteController.text,
          numeroPlaque: (numeroPlaque == '') ? '-' : numeroPlaque.toString(),
          dateHeureSortieAnguin: DateTime.parse(
              (dateHeureSortieAnguinController.text == '')
                  ? "2099-12-31 00:00:00"
                  : dateHeureSortieAnguinController.text),
          qtyAchat: qtyAchatController.text,
          signature: profilController.user.matricule,
          created: DateTime.now(),
          approbationDD: '-',
          motifDD: '-',
          signatureDD: '-');
      await carburantApi.insertData(dataItem).then((value) {
        carburantList.clear();
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

  // void submitUpdate(CarburantModel data) async {
  //   try {
  //     _isLoading.value = true;

  //     await carburantApi.updateData(dataItem).then((value) {
  //       carburantList.clear();
  //       getList();
  //       Get.back();
  //       Get.snackbar("Soumission effectuée avec succès!",
  //           "Le document a bien été sauvegader",
  //           backgroundColor: Colors.green,
  //           icon: const Icon(Icons.check),
  //           snackPosition: SnackPosition.TOP);
  //       _isLoading.value = false;
  //     });
  //   } catch (e) {
  //     Get.snackbar("Erreur de soumission", "$e",
  //         backgroundColor: Colors.red,
  //         icon: const Icon(Icons.check),
  //         snackPosition: SnackPosition.TOP);
  //   }
  // }

  void submitDD(CarburantModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = CarburantModel(
          id: data.id!,
          operationEntreSortie: data.operationEntreSortie,
          typeCaburant: data.typeCaburant,
          fournisseur: data.fournisseur,
          nomeroFactureAchat: data.nomeroFactureAchat,
          prixAchatParLitre: data.prixAchatParLitre,
          nomReceptioniste: data.nomReceptioniste,
          numeroPlaque: data.numeroPlaque,
          dateHeureSortieAnguin: data.dateHeureSortieAnguin,
          qtyAchat: data.qtyAchat,
          signature: data.signature,
          created: data.created,
          approbationDD: approbationDD,
          motifDD:
              (motifDDController.text == '') ? '-' : motifDDController.text,
          signatureDD: profilController.user.matricule);
      await carburantApi.updateData(dataItem).then((value) {
        carburantList.clear();
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
