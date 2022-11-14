import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/logistiques/approvion_reception_api.dart';
import 'package:wm_solution/src/models/logistiques/approvision_reception_model.dart';
import 'package:wm_solution/src/models/logistiques/approvisionnement_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/approvisions/approvisionnement_controller.dart';
import 'package:wm_solution/src/utils/dropdown.dart';

class ApprovisionReceptionController extends GetxController
    with StateMixin<List<ApprovisionReceptionModel>> {
  final ApprovisionReceptionApi approvisionReceptionApi =
      ApprovisionReceptionApi();
  final ProfilController profilController = Get.find();
  final ApprovisionnementController approvisionnementController = Get.find();

  var approvisionReceptionList = <ApprovisionReceptionModel>[].obs;

   ScrollController scrollController = ScrollController();

  final GlobalKey<FormState> receptionFormKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  List<String> departementList = Dropdown().departement;

  String? departement;
  TextEditingController provisionController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  TextEditingController uniteController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  @override
  void dispose() {
    provisionController.dispose();
    qtyController.dispose();
    uniteController.dispose();
    super.dispose();
  }

  void clear() {
    provisionController.clear();
    qtyController.clear();
    uniteController.clear();
  }

  void getList() async {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
     
      }
    });
    await approvisionReceptionApi.getAllData().then((response) {
      approvisionReceptionList.assignAll(response);
      change(approvisionReceptionList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await approvisionReceptionApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await approvisionReceptionApi.deleteData(id).then((value) {
        approvisionReceptionList.clear();
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

  submit(ApprovisionnementModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = ApprovisionReceptionModel(
          provision: data.provision,
          departement: departement.toString(),
          quantity: qtyController.text,
          unite: data.unite,
          signatureLivraison: profilController.user.matricule,
          created: DateTime.now(),
          accuseReception: 'false',
          signatureReception: '-',
          createdReception: DateTime.now(),
          livraisonAnnuler: 'false',
          reference: data.id!);
      await approvisionReceptionApi.insertData(dataItem).then((value) {
        clear();
        approvisionReceptionList.clear();
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

  void submitReception(ApprovisionReceptionModel data, String boolean) async {
    try {
      _isLoading.value = true;
      final dataItem = ApprovisionReceptionModel(
          id: data.id,
          provision: data.provision,
          departement: data.departement,
          quantity: data.quantity,
          unite: data.unite,
          signatureLivraison: data.signatureLivraison,
          created: data.created,
          accuseReception: boolean,
          signatureReception: profilController.user.matricule,
          createdReception: DateTime.now(),
          livraisonAnnuler: data.livraisonAnnuler,
          reference: data.reference);
      await approvisionReceptionApi.updateData(dataItem).then((value) {
        clear();
        approvisionReceptionList.clear();
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

  void submitLivraisonAnnuler(ApprovisionReceptionModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = ApprovisionReceptionModel(
          id: data.id,
          provision: data.provision,
          departement: data.departement,
          quantity: data.quantity,
          unite: data.unite,
          signatureLivraison: data.signatureLivraison,
          created: data.created,
          accuseReception: data.accuseReception,
          signatureReception: data.signatureReception,
          createdReception: DateTime.now(),
          livraisonAnnuler: 'true',
          reference: data.reference);
      await approvisionReceptionApi.updateData(dataItem).then((value) {
        var approvionnement = approvisionnementController.approvisionnementList
            .where((p0) => p0.id == value.reference)
            .last;

        var qtyAdded = double.parse(approvionnement.quantity) +
            double.parse(data.quantity);
        final approvionnementItem = ApprovisionnementModel(
            id: approvionnement.id,
            provision: approvionnement.provision,
            quantityTotal: approvionnement.quantityTotal,
            quantity: qtyAdded.toString(),
            unite: approvionnement.unite,
            signature: approvionnement.signature,
            created: approvionnement.created,
            fournisseur: approvionnement.fournisseur);
        approvisionnementController.approvisionnementApi
            .updateData(approvionnementItem)
            .then((value) {
          clear();
          approvisionReceptionList.clear();
          getList();
          Get.back();
          Get.snackbar("Soumission effectuée avec succès!",
              "Le document a bien été sauvegader",
              backgroundColor: Colors.green,
              icon: const Icon(Icons.check),
              snackPosition: SnackPosition.TOP);
          _isLoading.value = false;
        });
      });
    } catch (e) {
      Get.snackbar("Erreur de soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }
}
