import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/logistiques/approvisionnement_api.dart';
import 'package:wm_solution/src/models/logistiques/approvisionnement_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/utils/dropdown.dart';

class ApprovisionnementController extends GetxController
    with StateMixin<List<ApprovisionnementModel>> {
  final ApprovisionnementApi approvisionnementApi = ApprovisionnementApi();
  final ProfilController profilController = Get.find();

  List<ApprovisionnementModel> approvisionnementList = [];

  ScrollController scrollController = ScrollController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  List<String> unitesList = Dropdown().unites;

  TextEditingController provisionController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  String? unite;
  String? fournisseur;

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  @override
  void dispose() {
    provisionController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  void clear() {
    provisionController.clear();
    quantityController.clear();
  }

  void getList() async {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {}
    });
    await approvisionnementApi.getAllData().then((response) {
      approvisionnementList.clear();
      approvisionnementList.addAll(response);
      change(approvisionnementList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await approvisionnementApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await approvisionnementApi.deleteData(id).then((value) {
        approvisionnementList.clear();
        getList();
        Get.back();
        Get.snackbar("Supprim?? avec succ??s!", "Cet ??l??ment a bien ??t?? supprim??",
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
      final dataItem = ApprovisionnementModel(
          provision: provisionController.text,
          quantityTotal: quantityController.text,
          quantity: quantityController.text,
          unite: unite.toString(),
          signature: profilController.user.matricule,
          created: DateTime.now(),
          fournisseur: fournisseur.toString());
      await approvisionnementApi.insertData(dataItem).then((value) {
        clear();
        approvisionnementList.clear();
        getList();
        Get.back();
        Get.snackbar("Soumission effectu??e avec succ??s!",
            "Le document a bien ??t?? sauvegad??",
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

  void submitRavitaillement(ApprovisionnementModel data) async {
    try {
      _isLoading.value = true;
      double qtyTotal = double.parse(data.quantityTotal) +
          double.parse(quantityController.text);
      double qtyDisponible =
          double.parse(data.quantity) + double.parse(quantityController.text);
      final dataItem = ApprovisionnementModel(
          id: data.id,
          provision: data.provision,
          quantityTotal: qtyTotal.toString(),
          quantity: qtyDisponible.toString(),
          unite: unite.toString(),
          signature: profilController.user.matricule,
          created: DateTime.now(),
          fournisseur: fournisseur.toString());
      await approvisionnementApi.updateData(dataItem).then((value) {
        clear();
        approvisionnementList.clear();
        getList();
        Get.back();
        Get.snackbar("Soumission effectu??e avec succ??s!",
            "Le document a bien ??t?? sauvegad??",
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

  void submitReste(
      ApprovisionnementModel data, TextEditingController qtyController) async {
    try {
      _isLoading.value = true;
      double qtyRestante =
          double.parse(data.quantity) - double.parse(qtyController.text);
      final dataItem = ApprovisionnementModel(
          id: data.id,
          provision: data.provision,
          quantityTotal: data.quantityTotal,
          quantity: qtyRestante.toString(),
          unite: data.unite,
          signature: data.signature,
          created: data.created,
          fournisseur: data.fournisseur);
      await approvisionnementApi.updateData(dataItem).then((value) {
        clear();
        approvisionnementList.clear();
        getList();
        Get.back();
        Get.snackbar("Soumission effectu??e avec succ??s!",
            "Le document a bien ??t?? sauvegad??",
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
