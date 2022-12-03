import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/commerciale/produit_model_api.dart';
import 'package:wm_solution/src/models/commercial/prod_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class ProduitModelController extends GetxController
    with StateMixin<List<ProductModel>> {
  final ProduitModelApi produitModelApi = ProduitModelApi();
  final ProfilController profilController = Get.find();

  List<ProductModel> produitModelList = [];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  TextEditingController categorieController = TextEditingController();
  TextEditingController sousCategorie1Controller = TextEditingController();
  TextEditingController sousCategorie2Controller = TextEditingController();
  TextEditingController sousCategorie3Controller = TextEditingController();
  TextEditingController uniteController =
      TextEditingController(); // sousCategorie4

  // Approbations
  String approbationDG = '-';
  String approbationDD = '-';
  TextEditingController motifDGController = TextEditingController();
  TextEditingController motifDDController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  @override
  void dispose() {
    categorieController.dispose();
    sousCategorie1Controller.dispose();
    sousCategorie2Controller.dispose();
    sousCategorie3Controller.dispose();
    uniteController.dispose();

    super.dispose();
  }

  void clear() {
    categorieController.clear();
    sousCategorie1Controller.clear();
    sousCategorie2Controller.clear();
    sousCategorie3Controller.clear();
    uniteController.clear();
  }

  void getList() async {
    await produitModelApi.getAllData().then((response) {
      produitModelList.clear();
      getList();
      produitModelList.addAll(response);
      change(produitModelList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await produitModelApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await produitModelApi.deleteData(id).then((value) {
        clear();
        produitModelList.clear();
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
      final idProductform =
          "${categorieController.text}-${sousCategorie1Controller.text}-${sousCategorie2Controller.text}-${sousCategorie3Controller.text}-${uniteController.text}";
      final dataItem = ProductModel(
          categorie: categorieController.text,
          sousCategorie1: (sousCategorie1Controller.text == "")
              ? '-'
              : sousCategorie1Controller.text,
          sousCategorie2: (sousCategorie2Controller.text == "")
              ? '-'
              : sousCategorie2Controller.text,
          sousCategorie3: (sousCategorie3Controller.text == "")
              ? '-'
              : sousCategorie3Controller.text,
          sousCategorie4:
              (uniteController.text == "") ? '-' : uniteController.text,
          idProduct: idProductform,
          signature: profilController.user.matricule,
          created: DateTime.now(),
          approbationDD: '-',
          motifDD: '-',
          signatureDD: '-');
      await produitModelApi.insertData(dataItem).then((value) {
        clear();
        produitModelList.clear();
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

  void submitUpdate(ProductModel data) async {
    try {
      _isLoading.value = true;
      final idProductform =
          "${categorieController.text}-${sousCategorie1Controller.text}-${sousCategorie2Controller.text}-${sousCategorie3Controller.text}-${uniteController.text}";
      final dataItem = ProductModel(
          id: data.id,
          categorie: categorieController.text,
          sousCategorie1: sousCategorie1Controller.text,
          sousCategorie2: sousCategorie2Controller.text,
          sousCategorie3: sousCategorie3Controller.text,
          sousCategorie4: uniteController.text,
          idProduct: idProductform,
          signature: profilController.user.matricule,
          created: DateTime.now(),
          approbationDD: '-',
          motifDD: '-',
          signatureDD: '-');
      await produitModelApi.updateData(dataItem).then((value) {
        clear();
        produitModelList.clear();
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

  void submitDD(ProductModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = ProductModel(
          id: data.id!,
          categorie: data.categorie,
          sousCategorie1: data.sousCategorie1,
          sousCategorie2: data.sousCategorie2,
          sousCategorie3: data.sousCategorie3,
          sousCategorie4: data.sousCategorie4,
          idProduct: data.idProduct,
          signature: data.signature,
          created: data.created,
          approbationDD: approbationDD,
          motifDD:
              (motifDDController.text == '') ? '-' : motifDDController.text,
          signatureDD: profilController.user.matricule);
      await produitModelApi.updateData(dataItem).then((value) {
        clear();
        produitModelList.clear();
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
