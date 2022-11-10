import 'package:get/get.dart'; 
import 'package:wm_solution/src/models/comm_maketing/campaign_model.dart';
import 'package:wm_solution/src/models/devis/devis_models.dart';
import 'package:wm_solution/src/models/exploitations/projet_model.dart';
import 'package:wm_solution/src/models/rh/paiement_salaire_model.dart';
import 'package:wm_solution/src/models/rh/transport_restauration_model.dart';
import 'package:wm_solution/src/pages/marketing/controller/campaigns/compaign_controller.dart';
import 'package:wm_solution/src/pages/devis/controller/devis_controller.dart';
import 'package:wm_solution/src/pages/exploitations/controller/projets/projet_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/salaires/salaire_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/transport_rest/transport_rest_controller.dart';

class ObservationNotifyController extends GetxController {
  final SalaireController salaireController = Get.find();
  final TransportRestController transportRestController = Get.find();
  final CampaignController campaignController = Get.find();
  final DevisController devisController = Get.find();
  final ProjetController projetController = Get.find();
  
  var salaireList = <PaiementSalaireModel>[].obs;
  var transRestList = <TransportRestaurationModel>[].obs;
  var campaignList = <CampaignModel>[].obs;
  var devisList = <DevisModel>[].obs;
  var projetList = <ProjetModel>[].obs; 

  @override
  void onInit() {
    super.onInit();
    getCount();
  }

 

  void getCount() async {
    salaireList.assignAll(salaireController.paiementSalaireList
        .where((element) =>
            element.createdAt.month == DateTime.now().month &&
            element.createdAt.year == DateTime.now().year &&
            element.approbationDD == 'Approved' &&
            element.approbationBudget == 'Approved' &&
            element.approbationFin == 'Approved' &&
            element.observation == "false")
        .toList());
    transRestList.assignAll(transportRestController.transportRestaurationList
        .where((element) =>
            element.approbationDG == 'Approved' &&
            element.approbationDD == 'Approved' &&
            element.approbationBudget == 'Approved' &&
            element.approbationFin == 'Approved' &&
            element.observation == "false")
        .toList());
    campaignList.assignAll(campaignController.campaignList
        .where((element) =>
            element.approbationDG == 'Approved' &&
            element.approbationDD == 'Approved' &&
            element.approbationBudget == 'Approved' &&
            element.approbationFin == 'Approved' &&
            element.observation == "false")
        .toList());
    devisList.assignAll(devisController.devisList
        .where((element) =>
            element.approbationDG == 'Approved' &&
            element.approbationDD == 'Approved' &&
            element.approbationBudget == 'Approved' &&
            element.approbationFin == 'Approved' &&
            element.observation == "false")
        .toList());
    projetList.assignAll(projetController.projetList
        .where((element) =>
            element.approbationDG == 'Approved' &&
            element.approbationDD == 'Approved' &&
            element.approbationBudget == 'Approved' &&
            element.approbationFin == 'Approved' &&
            element.observation == "false")
        .toList()); 
     
  }
}
