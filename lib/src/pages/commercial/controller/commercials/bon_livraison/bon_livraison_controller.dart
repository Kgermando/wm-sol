import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/commerciale/commercial/bon_livraison_api.dart';
import 'package:wm_solution/src/models/commercial/achat_model.dart';
import 'package:wm_solution/src/models/commercial/bon_livraison.dart';
import 'package:wm_solution/src/models/commercial/livraiason_history_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/achats/achat_controller.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/history/history_livraison.dart';

class BonLivraisonController extends GetxController
    with StateMixin<List<BonLivraisonModel>> {
  final BonLivraisonApi bonLivraisonApi = BonLivraisonApi();
  final ProfilController profilController = Get.find();
  final AchatController achatController = Get.put(AchatController());
  final HistoryLivraisonController historyLivraisonController =
      Get.put(HistoryLivraisonController());

  List<BonLivraisonModel> bonLivraisonList = [];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  void getList() async {
    await bonLivraisonApi.getAllData().then((response) {
      bonLivraisonList.clear();
      bonLivraisonList.addAll(response);
      change(bonLivraisonList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await bonLivraisonApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await bonLivraisonApi.deleteData(id).then((value) {
        bonLivraisonList.clear();
        getList();
        Get.back();
        Get.snackbar("Supprimé avec succès!", "Cet élément a bien été supprimé",
            backgroundColor: Colors.green,
            icon: const Icon(Icons.check),
            snackPosition: SnackPosition.TOP);
        _isLoading.value = false;
      });
    } catch (e) {
      _isLoading.value = false;
      Get.snackbar("Erreur de soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }

  // Livraison vers succursale
  void bonLivraisonStock(BonLivraisonModel data) async {
    try {
      _isLoading.value = true;
      // Update Bon livraison
      final bonLivraisonModel = BonLivraisonModel(
          id: data.id!,
          idProduct: data.idProduct,
          quantityAchat: data.quantityAchat,
          priceAchatUnit: data.priceAchatUnit,
          prixVenteUnit: data.prixVenteUnit,
          unite: data.unite,
          firstName: data.firstName,
          lastName: data.lastName,
          tva: data.tva,
          remise: data.remise,
          qtyRemise: data.qtyRemise,
          accuseReception: 'true',
          accuseReceptionFirstName: profilController.user.prenom.toString(),
          accuseReceptionLastName: profilController.user.nom.toString(),
          succursale: data.succursale,
          signature: profilController.user.matricule,
          created: DateTime.now());
      await BonLivraisonApi().updateData(bonLivraisonModel).then((value) async {
        var achatDataList = achatController.achatList
            .where((p0) => p0.idProduct == value.idProduct)
            .toSet()
            .toList();

        if (achatDataList.isNotEmpty) {
          var achatItem = achatDataList.first;
          var achatQtyId = achatItem.id;
          var achatQty = achatItem.quantityAchat;
          var achatQtyRestante = achatItem.quantity;
          var pAU = achatItem.priceAchatUnit;
          var pVU = achatItem.prixVenteUnit;
          var dateAchat = achatItem.created;
          var succursaleAchat = achatItem.succursale;
          var tvaAchat = achatItem.tva;
          var remiseAchat = achatItem.remise;
          var qtyRemiseAchat = achatItem.qtyRemise;
          var qtyLivreAchat = achatItem.qtyLivre;
          // LA qtyAchatRestante est additionner à la qty de livraison de stocks global
          double qtyAchatDisponible =
              double.parse(achatQtyRestante) + double.parse(data.quantityAchat);

          // Add Livraison history si la succursale == la succursale de ravitaillement
          var margeBenMap = (double.parse(pVU) - double.parse(pAU)) *
              double.parse(achatQtyRestante);

          var margeBenRemise = (double.parse(remiseAchat) - double.parse(pAU)) *
              double.parse(achatQtyRestante);
          // Insert to Historique de Livraisons Stocks au comptant
          final livraisonHistoryModel = LivraisonHistoryModel(
              idProduct: data.idProduct,
              quantityAchat: achatQty.toString(),
              quantity: achatQtyRestante.toString(),
              priceAchatUnit: pAU.toString(),
              prixVenteUnit: pVU.toString(),
              unite: data.unite,
              margeBen: margeBenMap.toString(),
              tva: tvaAchat.toString(),
              remise: remiseAchat.toString(),
              qtyRemise: qtyRemiseAchat.toString(),
              margeBenRemise: margeBenRemise.toString(),
              qtyLivre: qtyLivreAchat,
              succursale: succursaleAchat.toString(),
              signature: data.signature,
              created: dateAchat);
          await historyLivraisonController.livraisonHistorylivraisonHistoryApi
              .insertData(livraisonHistoryModel)
              .then((value) async {
            // Update AchatModel
            final achatModel = AchatModel(
                id: achatQtyId,
                idProduct: data.idProduct,
                quantity: qtyAchatDisponible.toString(),
                quantityAchat: qtyAchatDisponible
                    .toString(), // Qty Achat est additionné à la qty livré
                priceAchatUnit: data.priceAchatUnit,
                prixVenteUnit: data.prixVenteUnit,
                unite: data.unite,
                tva: data.tva,
                remise: data.remise,
                qtyRemise: data.qtyRemise,
                qtyLivre: data.quantityAchat,
                succursale: data.succursale,
                signature: profilController.user.matricule,
                created: DateTime.now());
            await achatController.achatApi.updateData(achatModel).then((value) {
              bonLivraisonList.clear();
              getList();
              Get.back();
              Get.snackbar("Bon de Livraison effectuée avec succès!",
                  "La Livraison a bien été réçu",
                  backgroundColor: Colors.green,
                  icon: const Icon(Icons.check),
                  snackPosition: SnackPosition.TOP);
              _isLoading.value = false;
            });
          });
        } else {
          // add to Stocks au comptant
          final achatModel = AchatModel(
              idProduct: data.idProduct,
              quantity: data.quantityAchat,
              quantityAchat: data.quantityAchat, // Qty de livraison (entrant)
              priceAchatUnit: data.priceAchatUnit,
              prixVenteUnit: data.prixVenteUnit,
              unite: data.unite,
              tva: data.tva,
              remise: data.remise,
              qtyRemise: data.qtyRemise,
              qtyLivre: data.quantityAchat,
              succursale: data.succursale,
              signature: profilController.user.matricule,
              created: DateTime.now());
          await achatController.achatApi
              .insertData(achatModel)
              .then((value) async {
            // Add Livraison history si la succursale == la succursale de ravitaillement
            var margeBenMap = (double.parse(value.prixVenteUnit) -
                    double.parse(value.priceAchatUnit)) *
                double.parse(value.quantity);

            var margeBenRemise = (double.parse(value.remise) -
                    double.parse(value.priceAchatUnit)) *
                double.parse(value.quantity);
            // Insert to Historique de Livraisons Stocks au comptant
            final livraisonHistoryModel = LivraisonHistoryModel(
              idProduct: data.idProduct,
              quantityAchat: value.quantityAchat,
              quantity: value.quantity,
              priceAchatUnit: value.priceAchatUnit,
              prixVenteUnit: value.prixVenteUnit,
              unite: data.unite,
              margeBen: margeBenMap.toString(),
              tva: value.tva,
              remise: value.remise,
              qtyRemise: value.qtyRemise,
              margeBenRemise: margeBenRemise.toString(),
              qtyLivre: value.quantityAchat,
              succursale: value.succursale,
              signature: data.signature,
              created: value.created,
            );
            await historyLivraisonController.livraisonHistorylivraisonHistoryApi
                .insertData(livraisonHistoryModel)
                .then((value) {
              bonLivraisonList.clear();
              getList();
              Get.back();
              Get.snackbar("Bon de Livraison effectuée avec succès!",
                  "La Livraison a bien été réçu",
                  backgroundColor: Colors.green,
                  icon: const Icon(Icons.check),
                  snackPosition: SnackPosition.TOP);
              _isLoading.value = false;
            });
          });
        }
      });
    } catch (e) {
      _isLoading.value = false;
      Get.snackbar("Erreur de soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }
}
