import 'package:get/get.dart';
import 'package:wm_solution/src/models/rh/paiement_salaire_model.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/personnels/personnels_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/salaires/salaire_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/transport_rest/transport_rest_controller.dart';

class DashobardRHController extends GetxController {
  final PersonnelsController personnelsController =
      Get.put(PersonnelsController());
  final SalaireController salaireController = Get.put(SalaireController());
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


  void getData() async {
    var personnels = await personnelsController.personnelsApi.getAllData();
    _agentsCount.value = personnels.length;
    _agentActifCount.value =
        personnels.where((element) => element.statutAgent == 'Actif').length;
    _agentInactifCount.value =
        personnels.where((element) => element.statutAgent == 'Inactif').length;
    _agentFemmeCount.value =
        personnels.where((element) => element.sexe == 'Femme').length;
    _agentHommeCount.value =
        personnels.where((element) => element.sexe == 'Homme').length;

    var salaires = await salaireController.paiementSalaireApi.getAllData();
    _agentNonPaye.value = salaires
        .where((element) =>
            element.observation == 'false' &&
            element.createdAt.month == DateTime.now().month &&
            element.createdAt.year == DateTime.now().year)
        .length;

    salaireList = salaires
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

    update();
  }
}
