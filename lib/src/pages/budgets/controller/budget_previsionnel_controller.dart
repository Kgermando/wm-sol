import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/budgets/departement_budget_api.dart';
import 'package:wm_solution/src/models/budgets/departement_budget_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class BudgetPrevisionnelController extends GetxController
    with StateMixin<List<DepartementBudgetModel>> {
  DepeartementBudgetApi depeartementBudgetApi = DepeartementBudgetApi();
  final ProfilController profilController = Get.find();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;


  @override
  void onInit() {
    super.onInit();
    depeartementBudgetApi.getAllData().then((response) {
      change(response, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

}
