import 'package:get/get.dart';
import 'package:wm_solution/src/models/budgets/ligne_budgetaire_model.dart';
import 'package:wm_solution/src/models/charts/courbe_budget_model.dart';
import 'package:wm_solution/src/pages/budgets/controller/budget_previsionnel_controller.dart';
import 'package:wm_solution/src/pages/budgets/controller/ligne_budgetaire_controller.dart';

class DashboardBudgetController extends GetxController {
  final BudgetPrevisionnelController budgetPrevisionnelController =
      Get.put(BudgetPrevisionnelController());
  final LignBudgetaireController lignBudgetaireController =
      Get.put(LignBudgetaireController());

  final _coutTotal = 0.0.obs;
  double get coutTotal => _coutTotal.value;
  final _poursentExecutionTotal = 0.0.obs;
  double get poursentExecutionTotal => _poursentExecutionTotal.value;
  final _poursentExecution = 0.0.obs;
  double get poursentExecution => _poursentExecution.value;
  final _sommeEnCours = 0.0.obs;
  double get sommeEnCours => _sommeEnCours.value;
  final _sommeRestantes = 0.0.obs;
  double get sommeRestantes => _sommeRestantes.value;
  final _caisseSolde = 0.0.obs;
  double get caisseSolde => _caisseSolde.value;
  final _banqueSolde = 0.0.obs;
  double get banqueSolde => _banqueSolde.value;
  final _finExterieurSolde = 0.0.obs;
  double get finExterieurSolde => _finExterieurSolde.value;

  List<CourbeBudgetModel> courbeBanqueList = [];
  List<CourbeBudgetModel> courbeCaisseList = [];
  List<CourbeBudgetModel> courbeFinExterieurList = [];

  final _caisse = 0.0.obs;
  double get caisse => _caisse.value;
  final _banque = 0.0.obs;
  double get banque => _banque.value;
  final _finExterieur = 0.0.obs;
  double get finExterieur => _finExterieur.value;
  final _caisseSortie = 0.0.obs;
  double get caisseSortie => _caisseSortie.value;
  final _banqueSortie = 0.0.obs;
  double get banqueSortie => _banqueSortie.value;
  final _finExterieurSortie = 0.0.obs;
  double get finExterieurSortie => _finExterieurSortie.value;

  // Ligne budgetaires
  List<LigneBudgetaireModel> ligneBudgetaireList = [];

  @override
  void onReady() {
    getData();
    super.onReady();
  }

  void getData() async {
    var ligneBudgetaire =
        await lignBudgetaireController.lIgneBudgetaireApi.getAllData();

    var courbeBanque = await lignBudgetaireController.lIgneBudgetaireApi
        .getAllDataBanqueMouth();
    var courbeCaisse = await lignBudgetaireController.lIgneBudgetaireApi
        .getAllDataCaisseMouth();
    var courbeFinExterieur = await lignBudgetaireController.lIgneBudgetaireApi
        .getAllDataFinExterieurMouth();

    courbeBanqueList.addAll(courbeBanque);
    courbeCaisseList.addAll(courbeCaisse);
    courbeFinExterieurList.addAll(courbeFinExterieur);

    ligneBudgetaireList = ligneBudgetaire
        .where((element) => DateTime.now().isBefore(element.periodeBudgetFin))
        .toList();

    for (var element in ligneBudgetaireList) {
      _coutTotal.value += double.parse(element.coutTotal);
      _caisse.value += double.parse(element.caisse);
      _banque.value += double.parse(element.banque);
      _finExterieur.value += double.parse(element.finExterieur);
      _caisseSortie.value += element.caisseSortie;
      _banqueSortie.value += element.banqueSortie;
      _finExterieurSortie.value += element.finExterieurSortie;
    }

    _caisseSolde.value = caisse - caisseSortie;
    _banqueSolde.value = banque - banqueSortie;
    _finExterieurSolde.value = finExterieur - finExterieurSortie;

    _sommeEnCours.value = caisseSortie + banqueSortie + finExterieurSortie;
    _sommeRestantes.value = caisseSolde + banqueSolde + finExterieurSolde;

    _poursentExecutionTotal.value = sommeRestantes * 100 / coutTotal;

    _poursentExecution.value = 100 - poursentExecutionTotal;
  }
}
