import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/mails/mail_api.dart';
import 'package:wm_solution/src/models/mail/mail_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class MaillingController extends GetxController
    with StateMixin<List<MailModel>> {
  final MailApi mailApi = MailApi();
  final ProfilController profilController = Get.find();

  var mailList = <MailModel>[].obs;


  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;


  
  @override
  void onInit() {
    super.onInit();
    getList();
  }

  void getList() async {
    await mailApi.getAllData().then((response) {
      mailList.assignAll(response); 
      change(mailList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  Future detailView(int id) async {
    try {
      _isLoading.value = true;
      await mailApi.getOneData(id).then((value) {
        _isLoading.value = false;
      });
    } catch (e) {
      _isLoading.value = false;
      Get.snackbar(
        "Erreur s'est produite",
        "$e",
        backgroundColor: Colors.red,
      );
    }
  }


}
