import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/comptabilite/journal_api.dart';
import 'package:wm_solution/src/models/comptabilites/balance_model.dart';
import 'package:wm_solution/src/models/comptabilites/journal_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/balance/balance_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/balance/balance_sum_controller.dart';

class JournalController extends GetxController
    with StateMixin<List<JournalModel>> {
  final JournalApi journalApi = JournalApi();
  final ProfilController profilController = Get.find();
  final BalanceController balanceController = Get.put(BalanceController());
  final BalanceSumController balanceSumController =
      Get.put(BalanceSumController());

  List<JournalModel> journalList = [];
  int numOpration = 1;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  String? comptesAllSelectDebit;
  String? comptesAllSelectCredit;
  String? compteDebit;
  String? compteCredit;
  TextEditingController numeroOperationController = TextEditingController();
  TextEditingController libeleController = TextEditingController();
  TextEditingController montantController = TextEditingController(); 
  TextEditingController tvaController = TextEditingController();
  TextEditingController remarqueController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  @override
  void dispose() {
    numeroOperationController.dispose();
    libeleController.dispose();
    montantController.dispose(); 
    tvaController.dispose();
    remarqueController.dispose();
    super.dispose();
  }

  void clear() {
    numeroOperationController.clear();
    libeleController.clear();
    montantController.clear(); 
    tvaController.clear();
    remarqueController.clear();
  }

  void getList() async {
    await journalApi.getAllData().then((response) {
      journalList.clear();
      numOpration = response.length + 1;
      journalList.addAll(response); 
      change(journalList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await journalApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await journalApi.deleteData(id).then((value) {
        journalList.clear();
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
      String numero = '';
      if (numOpration < 10) {
        numero = "00$numOpration";
      } else if (numOpration < 99) {
        numero = "0$numOpration";
      } else {
        numero = "$numOpration";
      }
      _isLoading.value = true;
      final journalModel = JournalModel(
        numeroOperation: numero,
        libele: libeleController.text,
        compteDebit: compteDebit.toString(),
        montantDebit: (montantController.text == "")
            ? "0"
            : montantController.text,
        compteCredit: compteCredit.toString(),
        montantCredit: (montantController.text == "")
            ? "0"
            : montantController.text,
        signature: profilController.user.matricule,
        created: DateTime.now(),
        locker: "false",
      );
      await journalApi.insertData(journalModel).then((value) async {
        final debitItem = BalanceModel(
            numeroOperation: value.numeroOperation,
            libele: value.libele,
            comptes: value.compteDebit,
            debit: (value.montantDebit == "") ? "0" : value.montantDebit,
            credit: "0",
            signature: profilController.user.matricule,
            created: DateTime.now());
        await balanceController.balanceApi
            .insertData(debitItem)
            .then((bal) async {
          final creditItem = BalanceModel(
              numeroOperation: value.numeroOperation,
              libele: value.libele,
              comptes: value.compteCredit,
              debit: "0",
              credit: (value.montantCredit == "") ? "0" : value.montantCredit,
              signature: profilController.user.matricule,
              created: DateTime.now());
          await balanceController.balanceApi
              .insertData(creditItem)
              .then((value) {
            clear();
            journalList.clear();
            balanceSumController.balanceSumList.clear();
            balanceSumController.getList();
            getList();
            Get.snackbar("Soumission effectuée avec succès!",
                "Le document a bien été sauvegader",
                backgroundColor: Colors.green,
                icon: const Icon(Icons.check),
                snackPosition: SnackPosition.TOP);
            _isLoading.value = false;
          });
        });
      });
    } catch (e) {
      Get.snackbar("Erreur de soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }

  void submitUpdate(JournalModel data) async {
    try {
      _isLoading.value = true;
      final journalModel = JournalModel(
          id: data.id,
          numeroOperation: data.numeroOperation,
          libele: libeleController.text,
          compteDebit: compteDebit.toString(),
          montantDebit: (montantController.text == "")
              ? data.montantDebit
              : montantController.text,
          compteCredit: compteCredit.toString(),
          montantCredit: (montantController.text == "")
              ? data.montantDebit
              : montantController.text,
          signature: profilController.user.matricule,
          created: data.created,
          locker: data.locker);
      await journalApi.updateData(journalModel).then((value) {
        clear();
        journalList.clear();
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
}
