import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/logistiques/anguin_api.dart';
import 'package:wm_solution/src/models/logistiques/anguin_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/utils/enguins_dropdown.dart';

class EnginController extends GetxController
    with StateMixin<List<AnguinModel>> {
  final AnguinApi enginsApi = AnguinApi();
  final ProfilController profilController = Get.find();

  var enginList = <AnguinModel>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  int numberPlaque = 0;

  final genreDrop = EnguinsDropdown().enginDropdown;

    // Approbations
  String approbationDG = '-';
  String approbationDD = '-';
  TextEditingController motifDGController = TextEditingController();
  TextEditingController motifDDController = TextEditingController();




  final TextEditingController nomController = TextEditingController();
  final TextEditingController modeleController = TextEditingController();
  final TextEditingController marqueController = TextEditingController();
  final TextEditingController numeroChassieController = TextEditingController();
  final TextEditingController couleurController = TextEditingController();
  String? genre;
  final TextEditingController qtyMaxReservoirController =
      TextEditingController();
  final TextEditingController dateFabricationController =
      TextEditingController();
  final TextEditingController nomeroPLaqueController = TextEditingController();
  final TextEditingController kilometrageInitialeController =
      TextEditingController();
  final TextEditingController provenanceController = TextEditingController();
  final TextEditingController typeCaburantController = TextEditingController();
  final TextEditingController typeMoteurController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getList();
  }

@override
  void dispose() {
    motifDGController.dispose();
    motifDDController.dispose();
    nomController.dispose();
    modeleController.dispose();
    marqueController.dispose();
    numeroChassieController.dispose();
    couleurController.dispose();
    qtyMaxReservoirController.dispose();
    dateFabricationController.dispose();
    nomeroPLaqueController.dispose();
    kilometrageInitialeController.dispose();
    provenanceController.dispose();
    typeCaburantController.dispose();
    typeMoteurController.dispose();

    super.dispose();
  }
  void getList() async {
    await enginsApi.getAllData().then((response) {
      enginList.assignAll(response);
      change(enginList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await enginsApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await enginsApi.deleteData(id).then((value) {
        enginList.clear();
        getList();
        // Get.back();
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
       String numero = '';
      if (numberPlaque < 10) {
        numero = "00$numberPlaque";
      } else if (numberPlaque < 99) {
        numero = "0$numberPlaque";
      } else {
        numero = "$numberPlaque";
      }
      final dataItem = AnguinModel(
        nom: nomController.text,
        modele: modeleController.text,
        marque: marqueController.text,
        numeroChassie: numeroChassieController.text,
        couleur: couleurController.text,
        genre: genre.toString(),
        qtyMaxReservoir: qtyMaxReservoirController.text,
        dateFabrication: DateTime.parse(dateFabricationController.text),
        nomeroPLaque: nomeroPLaqueController.text,
        nomeroEntreprise: numero,
        kilometrageInitiale: kilometrageInitialeController.text,
        provenance: provenanceController.text,
        typeCaburant: typeCaburantController.text,
        typeMoteur: typeMoteurController.text,
        signature: profilController.user.matricule, 
        created: DateTime.now(),
        approbationDG: '-',
        motifDG: '-',
        signatureDG: '-',
        approbationDD: '-',
        motifDD: '-',
        signatureDD: '-');
      await enginsApi.insertData(dataItem).then((value) {
        enginList.clear();
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

  void submitUpdate(AnguinModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = AnguinModel(
        id: data.id!,
        nom: nomController.text,
        modele: modeleController.text,
        marque: marqueController.text,
        numeroChassie: numeroChassieController.text,
        couleur: couleurController.text,
        genre: genre.toString(),
        qtyMaxReservoir: qtyMaxReservoirController.text,
        dateFabrication: DateTime.parse(dateFabricationController.text),
        nomeroPLaque: nomeroPLaqueController.text,
        nomeroEntreprise: data.nomeroEntreprise,
        kilometrageInitiale: kilometrageInitialeController.text,
        provenance: provenanceController.text,
        typeCaburant: typeCaburantController.text,
        typeMoteur: typeMoteurController.text,
        signature: profilController.user.matricule, 
        created: data.created,
        approbationDG: '-',
        motifDG: '-',
        signatureDG: '-',
        approbationDD: '-',
        motifDD: '-',
        signatureDD: '-'
      );
      await enginsApi.updateData(dataItem).then((value) {
        enginList.clear();
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

  void submitDG(AnguinModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = AnguinModel(
          id: data.id!,
          nom: data.nom,
          modele: data.modele,
          marque: data.marque,
          numeroChassie: data.numeroChassie,
          couleur: data.couleur,
          genre: data.genre,
          qtyMaxReservoir: data.qtyMaxReservoir,
          dateFabrication: data.dateFabrication,
          nomeroPLaque: data.nomeroPLaque,
          nomeroEntreprise: data.nomeroEntreprise,
          kilometrageInitiale: data.kilometrageInitiale,
          provenance: data.provenance,
          typeCaburant: data.typeCaburant,
          typeMoteur: data.typeMoteur,
          signature: data.signature, 
          created: data.created,
          approbationDG: approbationDG,
          motifDG:
              (motifDGController.text == '') ? '-' : motifDGController.text,
          signatureDG: profilController.user.matricule,
          approbationDD: data.approbationDD,
          motifDD: data.motifDD,
          signatureDD: data.signatureDD);
      await enginsApi.updateData(dataItem).then((value) {
        enginList.clear();
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

  void submitDD(AnguinModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = AnguinModel(
          id: data.id!,
          nom: data.nom,
          modele: data.modele,
          marque: data.marque,
          numeroChassie: data.numeroChassie,
          couleur: data.couleur,
          genre: data.genre,
          qtyMaxReservoir: data.qtyMaxReservoir,
          dateFabrication: data.dateFabrication,
          nomeroPLaque: data.nomeroPLaque,
          nomeroEntreprise: data.nomeroEntreprise,
          kilometrageInitiale: data.kilometrageInitiale,
          provenance: data.provenance,
          typeCaburant: data.typeCaburant,
          typeMoteur: data.typeMoteur,
          signature: data.signature, 
          created: data.created,
          approbationDG: '-',
          motifDG: '-',
          signatureDG: '-',
          approbationDD: approbationDD,
          motifDD:
              (motifDDController.text == '') ? '-' : motifDDController.text,
          signatureDD: profilController.user.matricule);
      await enginsApi.updateData(dataItem).then((value) {
        enginList.clear();
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
