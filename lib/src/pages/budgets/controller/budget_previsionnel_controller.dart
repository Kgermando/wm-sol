import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/budgets/departement_budget_api.dart';
import 'package:wm_solution/src/models/budgets/departement_budget_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class BudgetPrevisionnelController extends GetxController
    with StateMixin<List<DepartementBudgetModel>> {
  DepeartementBudgetApi depeartementBudgetApi = DepeartementBudgetApi();
  final ProfilController profilController = Get.find();

  List<DepartementBudgetModel> departementBudgetList = [];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  DateTimeRange? dateRange;

  // String? departement;
  TextEditingController titleController = TextEditingController();

  // List<String> departementList = Dropdown().departement;

  // Approbations
  final formKeyBudget = GlobalKey<FormState>();

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
    titleController.dispose();
    motifDGController.dispose();
    motifDDController.dispose();
    super.dispose();
  }

  void clear() {
    titleController.clear();
    motifDGController.clear();
    motifDDController.clear();
  }

  void getList() async {
    await depeartementBudgetApi.getAllData().then((response) {
      departementBudgetList.addAll(response);
      change(departementBudgetList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await depeartementBudgetApi.getOneData(id);
    return data;
  }

  deleteData(int id) async {
    try {
      _isLoading.value = true;
      await depeartementBudgetApi.deleteData(id).then((value) {
        departementBudgetList.clear();
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
      final departementBudgetModel = DepartementBudgetModel(
          title: titleController.text,
          departement: '-',
          periodeDebut: dateRange!.start,
          periodeFin: dateRange!.end,
          signature: profilController.user.matricule,
          createdRef: DateTime.now(),
          created: DateTime.now(),
          isSubmit: 'false',
          approbationDG: '-',
          motifDG: '-',
          signatureDG: '-',
          approbationDD: '-',
          motifDD: '-',
          signatureDD: '-');
      await depeartementBudgetApi
          .insertData(departementBudgetModel)
          .then((value) {
        clear();
        departementBudgetList.clear();
        Get.back();
        getList();
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

  void submitToDD(DepartementBudgetModel data) async {
    try {
      _isLoading.value = true;
      final departementBudgetModel = DepartementBudgetModel(
          id: data.id,
          title: data.title,
          departement: data.departement,
          periodeDebut: data.periodeDebut,
          periodeFin: data.periodeFin,
          signature: data.signature,
          createdRef: data.createdRef,
          created: data.created,
          isSubmit: 'true',
          approbationDG: data.approbationDG,
          motifDG: data.motifDG,
          signatureDG: data.signatureDG,
          approbationDD: data.approbationDD,
          motifDD: data.motifDD,
          signatureDD: data.signatureDD);
      await depeartementBudgetApi
          .updateData(departementBudgetModel)
          .then((value) {
        clear();
        departementBudgetList.clear();
        getList();
        Get.back();
        Get.snackbar("Soumis avec succès!", "Le document a bien été soumis",
            backgroundColor: Colors.green,
            icon: const Icon(Icons.check),
            snackPosition: SnackPosition.TOP);
        _isLoading.value = false;
      });
    } catch (e) {
      Get.snackbar("Erreur lors de la soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }

  void submitDG(DepartementBudgetModel data) async {
    try {
      _isLoading.value = true;
      final departementBudgetModel = DepartementBudgetModel(
          id: data.id,
          title: data.title,
          departement: data.departement,
          periodeDebut: data.periodeDebut,
          periodeFin: data.periodeFin,
          signature: data.signature,
          createdRef: data.createdRef,
          created: data.created,
          isSubmit: data.isSubmit,
          approbationDG: approbationDG,
          motifDG:
              (motifDGController.text == '') ? '-' : motifDGController.text,
          signatureDG: profilController.user.matricule,
          approbationDD: data.approbationDD,
          motifDD: data.motifDD,
          signatureDD: data.signatureDD);
      await depeartementBudgetApi
          .updateData(departementBudgetModel)
          .then((value) {
        clear();
        departementBudgetList.clear();
        getList();
        Get.back();
        Get.snackbar("Effectuée avec succès!", "Le document a bien été soumis",
            backgroundColor: Colors.green,
            icon: const Icon(Icons.check),
            snackPosition: SnackPosition.TOP);
        _isLoading.value = false;
      });
    } catch (e) {
      Get.snackbar("Erreur lors de la soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }

  void submitDD(DepartementBudgetModel data) async {
    try {
      _isLoading.value = true;
      final departementBudgetModel = DepartementBudgetModel(
          id: data.id,
          title: data.title,
          departement: data.departement,
          periodeDebut: data.periodeDebut,
          periodeFin: data.periodeFin,
          signature: data.signature,
          createdRef: data.createdRef,
          created: data.created,
          isSubmit: data.isSubmit,
          approbationDG: '-',
          motifDG: '-',
          signatureDG: '-',
          approbationDD: approbationDD,
          motifDD:
              (motifDDController.text == '') ? '-' : motifDDController.text,
          signatureDD: profilController.user.matricule);
      await depeartementBudgetApi
          .updateData(departementBudgetModel)
          .then((value) {
        clear();
        departementBudgetList.clear();
        getList();
        Get.back();
        Get.snackbar("Effectuée avec succès!", "Le document a bien été soumis",
            backgroundColor: Colors.green,
            icon: const Icon(Icons.check),
            snackPosition: SnackPosition.TOP);
        _isLoading.value = false;
      });
    } catch (e) {
      Get.snackbar("Erreur lors de la soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }
}
