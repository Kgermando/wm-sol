import 'package:get/get.dart';
import 'package:wm_solution/src/models/budgets/ligne_budgetaire_model.dart';
import 'package:wm_solution/src/pages/budgets/controller/budget_previsionnel_controller.dart';
import 'package:wm_solution/src/pages/budgets/controller/ligne_budgetaire_controller.dart';

class DashboardBudgetController extends GetxController {
  final BudgetPrevisionnelController budgetPrevisionnelController = Get.find();
  final LignBudgetaireController lignBudgetaireController = Get.find();

  double coutTotal = 0.0;
  double poursentExecutionTotal = 0.0;
  double poursentExecution = 0.0;
  double sommeEnCours = 0.0;
  double sommeRestantes = 0.0;
  double caisseSolde = 0.0;
  double banqueSolde = 0.0;
  double finExterieurSolde = 0.0;

  double caisse = 0.0;
  double banque = 0.0;
  double finExterieur = 0.0;
  double caisseSortie = 0.0;
  double banqueSortie = 0.0;
  double finExterieurSortie = 0.0;

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

    ligneBudgetaireList = ligneBudgetaire
        .where((element) => DateTime.now().isBefore(element.periodeBudgetFin))
        .toList();

    for (var element in ligneBudgetaireList) {
      coutTotal += double.parse(element.coutTotal);
      caisse += double.parse(element.caisse);
      banque += double.parse(element.banque);
      finExterieur += double.parse(element.finExterieur);
      caisseSortie += element.caisseSortie;
      banqueSortie += element.banqueSortie;
      finExterieurSortie += element.finExterieurSortie;
    }

    caisseSolde = caisse - caisseSortie;
    banqueSolde = banque - banqueSortie;
    finExterieurSolde = finExterieur - finExterieurSortie;

    sommeEnCours = caisseSortie + banqueSortie + finExterieurSortie;
    sommeRestantes = caisseSolde + banqueSolde + finExterieurSolde;

    poursentExecutionTotal = sommeRestantes * 100 / coutTotal;

    poursentExecution =  100 - poursentExecutionTotal;
  }
}
