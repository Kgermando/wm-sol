import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/budgets/ligne_budgetaire_api.dart'; 
import 'package:wm_solution/src/models/budgets/ligne_budgetaire_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class LignBudgetaireController extends GetxController
    with StateMixin<List<LigneBudgetaireModel>> {
  LIgneBudgetaireApi lIgneBudgetaireApi = LIgneBudgetaireApi();
  final ProfilController profilController = Get.find();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    lIgneBudgetaireApi.getAllData().then((response) {
      change(response, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }
}
