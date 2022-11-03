import 'package:get/get.dart'; 
import 'package:wm_solution/src/models/rh/paiement_salaire_model.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/personnels/personnels_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/salaires/salaire_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/transport_rest/transport_rest_controller.dart';

class DashobardNotifyController extends GetxController { 
  final PersonnelsController personnelsController =
      Get.put(PersonnelsController());
  final SalaireController salaireController =
      Get.put(SalaireController());
  final TransportRestController transportRestController =
      Get.put(TransportRestController());  

  List<PaiementSalaireModel> salaireList = []; 
 
  final _totalEnveloppeSalaire = 0.0.obs;
  double get totalEnveloppeSalaire => _totalEnveloppeSalaire.value;

 
  final _agentsCount = 0.obs;
  int get agentsCount => _agentsCount.value;

  final _agentActifCount = 0.obs;
  int get agentActifCount => _agentActifCount.value;

  final _agentInactifCount = 0.obs;
  int get agentInactifCount => _agentInactifCount.value;

    final _agentFemmeCount = 0.obs;
  int get agentFemmeCount => _agentFemmeCount.value;


  final _agentHommeCount = 0.obs;
  int get agentHommeCount => _agentHommeCount.value;

  final _agentNonPaye = 0.obs;
  int get agentNonPaye => _agentNonPaye.value;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  @override
  void refresh() {
    getData();
    super.refresh();
  }
 
  Future<void> getData() async {
     _agentsCount.value = personnelsController.personnelsList.length;
    _agentActifCount.value =
        personnelsController.personnelsList
        .where((element) => element.statutAgent == 'true').length;
    _agentInactifCount.value =
        personnelsController.personnelsList
        .where((element) => element.statutAgent == 'false').length;
    _agentFemmeCount.value = personnelsController.personnelsList
        .where((element) => element.sexe == 'Femme').length;
    _agentHommeCount.value = personnelsController.personnelsList
        .where((element) => element.sexe == 'Homme').length;
    _agentNonPaye.value = salaireController.paiementSalaireList
        .where((element) =>
            element.observation == 'false' &&
            element.createdAt.month == DateTime.now().month &&
            element.createdAt.year == DateTime.now().year)
        .length;

    salaireList = salaireController.paiementSalaireList
        .where((element) =>
            element.createdAt.month == DateTime.now().month &&
            element.createdAt.year == DateTime.now().year &&
            element.approbationDD == "Approved" &&
            element.approbationBudget == "Approved" &&
            element.approbationFin == "Approved" &&
            element.observation == "true")
        .toList();

    for (var element in salaireList) {
      _totalEnveloppeSalaire.value += double.parse(element.salaire);
    }
  }
}
