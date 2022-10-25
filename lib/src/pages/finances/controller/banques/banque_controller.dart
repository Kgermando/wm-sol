import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/finances/banque_api.dart';
import 'package:wm_solution/src/models/finances/banque_model.dart';
import 'package:wm_solution/src/models/finances/banque_name_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/utils/dropdown.dart';
import 'package:wm_solution/src/utils/type_operation.dart';

class BanqueController extends GetxController
    with StateMixin<List<BanqueModel>> {
  final BanqueApi banqueApi = BanqueApi();
  final ProfilController profilController = Get.find();

  var banqueList = <BanqueModel>[].obs;

  final GlobalKey<FormState> formKeyDepot = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyRetrait = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  TextEditingController nomCompletController = TextEditingController();
  TextEditingController pieceJustificativeController = TextEditingController();
  TextEditingController libelleController = TextEditingController();
  TextEditingController montantController = TextEditingController();

  String? typeOperation; // For Update

  final List<String> typeCaisse = TypeOperation().typeVereCaisse;
  final List<String> departementList = Dropdown().departement;

  final _recette = 0.0.obs;
  double get recette => _recette.value;
  final _depenses = 0.0.obs;
  double get depenses => _depenses.value;

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
    super.dispose();
  }

  void getList() async {
    await banqueApi.getAllData().then((response) {
      banqueList.assignAll(response);
      List<BanqueModel?> recetteList = banqueList
          .where((element) => element.typeOperation == "Depot")
          .toList();
      List<BanqueModel?> depensesList = banqueList
          .where((element) => element.typeOperation == "Retrait")
          .toList();
      for (var item in recetteList) {
        _recette.value += double.parse(item!.montant);
      }
      for (var item in depensesList) {
        _depenses.value += double.parse(item!.montant);
      }
      change(banqueList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await banqueApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await banqueApi.deleteData(id).then((value) {
        banqueList.clear();
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

  void submitDepot(BanqueNameModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = BanqueModel(
          nomComplet: nomCompletController.text,
          pieceJustificative: pieceJustificativeController.text,
          libelle: libelleController.text,
          montant: montantController.text,
          departement: '-',
          typeOperation: 'Depot',
          numeroOperation: 'Transaction-Banque-${banqueList.length + 1}',
          signature: profilController.user.matricule,
          reference: data.id!,
          banqueName: data.nomComplet,
          created: DateTime.now());
      await banqueApi.insertData(dataItem).then((value) {
        banqueList.clear();
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
      _isLoading.value = false;
      Get.snackbar("Erreur de soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }

  void submitRetrait(BanqueNameModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = BanqueModel(
          nomComplet: nomCompletController.text,
          pieceJustificative: pieceJustificativeController.text,
          libelle: libelleController.text,
          montant: montantController.text,
          departement: '-',
          typeOperation: 'Retrait',
          numeroOperation: 'Transaction-Banque-${banqueList.length + 1}',
          signature: profilController.user.matricule,
          reference: data.id!,
          banqueName: data.nomComplet,
          created: DateTime.now());
      await banqueApi.insertData(dataItem).then((value) {
        banqueList.clear();
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
      _isLoading.value = false;
      Get.snackbar("Erreur de soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }

  void submitUpdate(BanqueModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = BanqueModel(
          id: data.id,
          nomComplet: nomCompletController.text,
          pieceJustificative: pieceJustificativeController.text,
          libelle: libelleController.text,
          montant: montantController.text,
          departement: data.departement,
          typeOperation: typeOperation.toString(),
          numeroOperation: data.numeroOperation,
          signature: profilController.user.matricule,
          reference: data.reference,
          banqueName: data.nomComplet,
          created: data.created);
      await banqueApi.updateData(dataItem).then((value) {
        banqueList.clear();
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
      _isLoading.value = false;
      Get.snackbar("Erreur de soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }
}
