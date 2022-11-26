import 'package:get/get.dart';
import 'package:wm_solution/src/pages/marketing/controller/agenda/agenda_controller.dart';
import 'package:wm_solution/src/pages/marketing/controller/annuaire/annuaire_controller.dart';
import 'package:wm_solution/src/pages/marketing/controller/campaigns/compaign_controller.dart';

class DashboardMarketingController extends GetxController {
  final CampaignController campaignController = Get.find();
  final AnnuaireController annuaireController = Get.find();
  final AgendaController agendaController = Get.find();

  final _campaignCount = 0.obs;
  int get campaignCount => _campaignCount.value;
  final _annuaireCount = 0.obs;
  int get annuaireCount => _annuaireCount.value;
  final _agendaCount = 0.obs;
  int get agendaCount => _agendaCount.value;
  final _succursaleCount = 0.obs;
  int get succursaleCount => _succursaleCount.value;

  final _sumGain = 0.0.obs;
  double get sumGain => _sumGain.value;
  final _sumVente = 0.0.obs;
  double get sumVente => _sumVente.value;
  final _sumDCreance = 0.0.obs;
  double get sumDCreance => _sumDCreance.value;

  @override
  void onInit() {
    getList();
    super.onInit();
  }

 
  void getList() async {
    var annuaire = await annuaireController.annuaireApi.getAllData();
    var agenda = await agendaController.agendaApi.getAllData();
    var campaigns = await campaignController.campaignApi.getAllData();

    _annuaireCount.value = annuaire.length;
    _agendaCount.value = agenda.length;

    _campaignCount.value = campaigns
        .where((element) =>
            element.approbationDD == "Approved" &&
            element.approbationBudget == "Approved" &&
            element.approbationFin == "Approved")
        .length;
  }
}
