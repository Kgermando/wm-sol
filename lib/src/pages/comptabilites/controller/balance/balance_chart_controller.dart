import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/comptabilite/balance_api.dart';
import 'package:wm_solution/src/models/comptabilites/balance_model.dart'; 

class BalanceChartController extends GetxController
    with StateMixin<List<BalanceChartModel>> {
  final BalanceApi balanceApi = BalanceApi(); 
 
  List<BalanceChartModel> balanceChartList = [];

  ScrollController balanceScroll = ScrollController();


  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
 
  @override
  void onInit() {
    super.onInit();
    getList();
  }

 
 
  void getList() async {
    balanceScroll.addListener(() {
      if (balanceScroll.position.pixels ==
          balanceScroll.position.maxScrollExtent) {}
    });
     
    await balanceApi.getAllChartData().then((response) {
      balanceChartList.clear();
      balanceChartList.addAll(response);
      change(balanceChartList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await balanceApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await balanceApi.deleteData(id).then((value) {
        balanceChartList.clear();
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
 
 
}
