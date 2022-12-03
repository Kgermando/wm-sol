import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/budgets/departement_budget_model.dart';
import 'package:wm_solution/src/models/budgets/ligne_budgetaire_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/budgets/components/budget_previsionnel/approbation_budget_previsionnel.dart';
import 'package:wm_solution/src/pages/budgets/components/budget_previsionnel/solde_budget.dart';
import 'package:wm_solution/src/pages/budgets/controller/budget_previsionnel_controller.dart';
import 'package:wm_solution/src/pages/budgets/controller/ligne_budgetaire_controller.dart';
import 'package:wm_solution/src/pages/budgets/view/ligne_budgetaire.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class DetailBudgetPrevisionnel extends StatefulWidget {
  const DetailBudgetPrevisionnel(
      {super.key, required this.departementBudgetModel});
  final DepartementBudgetModel departementBudgetModel;

  @override
  State<DetailBudgetPrevisionnel> createState() =>
      _DetailBudgetPrevisionnelState();
}

class _DetailBudgetPrevisionnelState extends State<DetailBudgetPrevisionnel> {
  final ProfilController profilController = Get.find();
  final BudgetPrevisionnelController controller = Get.find();
  final LignBudgetaireController lignBudgetaireController =
      Get.put(LignBudgetaireController());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Budgets";

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final debut = widget.departementBudgetModel.periodeDebut;
    final fin = widget.departementBudgetModel.periodeFin;

    final panding = now.compareTo(debut) < 0;
    final biginLigneBudget = now.isAfter(debut); // now.compareTo(debut) > 0;
    final expiredLigneBudget = now.isAfter(fin); //now.compareTo(fin) > 0;

    return Scaffold(
        key: scaffoldKey,
        appBar: headerBar(
            context, scaffoldKey, title, widget.departementBudgetModel.title),
        drawer: const DrawerMenu(),
        floatingActionButton:
            (widget.departementBudgetModel.approbationDD == '-' &&
                    widget.departementBudgetModel.approbationDG == '-')
                ? FloatingActionButton.extended(
                    label: const Text("Ajouter ligne budgetaire"),
                    tooltip: "Ajout une nouvelle ligne budgetaire",
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      Get.toNamed(BudgetRoutes.budgetLignebudgetaireAdd,
                          arguments: widget.departementBudgetModel);
                    },
                  )
                : Container(),
        body: lignBudgetaireController.obx(
          onLoading: loadingPage(context),
          onEmpty: const Text('Aucune donnée'),
          onError: (error) => loadingError(context, error!),
          (state) => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                  visible: !Responsive.isMobile(context),
                  child: const Expanded(flex: 1, child: DrawerMenu())),
              Expanded(
                  flex: 5,
                  child: SingleChildScrollView(
                      controller: ScrollController(),
                      physics: const ScrollPhysics(),
                      child: Container(
                        margin: const EdgeInsets.only(
                            top: p20, bottom: p8, right: p20, left: p20),
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          children: [
                            Card(
                              elevation: 3,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: p20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TitleWidget(
                                            title: widget
                                                .departementBudgetModel.title),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                IconButton(
                                                    tooltip: 'Rafraichir',
                                                    onPressed: () {
                                                      Navigator.pushNamed(
                                                          context,
                                                          BudgetRoutes
                                                              .budgetBudgetPrevisionelDetail,
                                                          arguments: widget
                                                              .departementBudgetModel);
                                                    },
                                                    icon: Icon(Icons.refresh,
                                                        color: Colors
                                                            .green.shade700)),
                                                if (widget
                                                        .departementBudgetModel
                                                        .isSubmit ==
                                                    'false')
                                                  IconButton(
                                                      tooltip:
                                                          'Soumettre chez le directeur du budget',
                                                      onPressed: () {
                                                        alertDialog();
                                                      },
                                                      icon: const Icon(
                                                          Icons.send),
                                                      color: Colors
                                                          .teal),
                                                if (widget
                                                        .departementBudgetModel
                                                        .isSubmit ==
                                                    'false')
                                                  IconButton(
                                                      tooltip: 'Supprimer',
                                                      onPressed: () async {
                                                        alertDeleteDialog(
                                                            controller);
                                                      },
                                                      icon: const Icon(
                                                          Icons.delete),
                                                      color:
                                                          Colors.red.shade700),
                                              ],
                                            ),
                                            SelectableText(
                                                DateFormat("dd-MM-yyyy HH:mm")
                                                    .format(widget
                                                        .departementBudgetModel
                                                        .created),
                                                textAlign: TextAlign.start),
                                            if (widget.departementBudgetModel
                                                    .isSubmit ==
                                                'true')
                                              Column(
                                                children: [
                                                  if (panding)
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              p10),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: 15,
                                                            height: 15,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .orange
                                                                  .shade700,
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: p10),
                                                          Text("En attente...",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .orange
                                                                      .shade700))
                                                        ],
                                                      ),
                                                    ),
                                                  if (biginLigneBudget)
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              p10),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: 15,
                                                            height: 15,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .green
                                                                  .shade700,
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: p10),
                                                          Text("En cours...",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .green
                                                                      .shade700))
                                                        ],
                                                      ),
                                                    ),
                                                  if (expiredLigneBudget)
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              p10),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: 15,
                                                            height: 15,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .red.shade700,
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: p10),
                                                          Text("Obsolète!",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red
                                                                      .shade700))
                                                        ],
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            if (widget.departementBudgetModel
                                                    .isSubmit ==
                                                'false')
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(p10),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: 15,
                                                      height: 15,
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .purple.shade700,
                                                        shape: BoxShape.circle,
                                                      ),
                                                    ),
                                                    const SizedBox(width: p10),
                                                    Text("En constitution...",
                                                        style: TextStyle(
                                                            color: Colors.purple
                                                                .shade700))
                                                  ],
                                                ),
                                              )
                                          ],
                                        )
                                      ],
                                    ),
                                    dataWidget(),
                                    Divider(color: Colors.red.shade700),
                                    soldeBudgets(state!),
                                    Divider(color: Colors.red.shade700)
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: p20),
                            LigneBudgetaire(
                              departementBudgetModel:
                                  widget.departementBudgetModel,
                              lignBudgetaireController:
                                  lignBudgetaireController,
                              ligneBudgetaireList: state,
                            ),
                            const SizedBox(height: p20),
                            if (widget.departementBudgetModel.isSubmit ==
                                'true')
                              ApprobationBudgetPrevisionnel(
                                  data: widget.departementBudgetModel,
                                  controller: controller,
                                  profilController: profilController),
                            const SizedBox(
                              height: p20,
                            ),
                          ],
                        ),
                      )))
            ],
          ),
        ));
  }

  Widget dataWidget() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.all(p10),
      child: Column(
        children: [
          ResponsiveChildWidget(
            child1: Text('Titre :',
                textAlign: TextAlign.start,
                style: bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(widget.departementBudgetModel.title,
                textAlign: TextAlign.start, style: bodyMedium),
          ),
          Divider(color: mainColor),
          ResponsiveChildWidget(
            child1: Text('Date de début :',
                textAlign: TextAlign.start,
                style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(
                DateFormat("dd-MM-yyyy")
                    .format(widget.departementBudgetModel.periodeDebut),
                textAlign: TextAlign.start,
                style: bodyMedium),
          ),
          Divider(color: mainColor),
          ResponsiveChildWidget(
            child1: Text('Date de Fin :',
                textAlign: TextAlign.start,
                style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
            child2: SelectableText(
                DateFormat("dd-MM-yyyy")
                    .format(widget.departementBudgetModel.periodeFin),
                textAlign: TextAlign.start,
                style: bodyMedium),
          ),
        ],
      ),
    );
  }

  Widget soldeBudgets(List<LigneBudgetaireModel> state) {
    double coutTotal = 0.0;
    double poursentExecutionTotal = 0.0;
    double poursentExecution = 0.0;
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
    List<LigneBudgetaireModel> ligneBudgetaireCoutTotalList = [];

    // Cout total ligne budgetaires
    ligneBudgetaireCoutTotalList = state.where((element) =>
      element.reference == widget.departementBudgetModel.id).toList();

    for (var element in ligneBudgetaireCoutTotalList) {
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

    poursentExecutionTotal =
        (caisseSolde + banqueSolde + finExterieurSolde) * 100 / coutTotal;
    
    poursentExecution = 100 - poursentExecutionTotal;

    return SoldeBudgets(
        coutTotal: coutTotal,
        caisseSolde: caisseSolde,
        banqueSolde: banqueSolde,
        finExterieurSolde: finExterieurSolde,
        touxExecutions: poursentExecution);
  }

  alertDialog() {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              title: Text('Etes-vous sûr de vouloir faire ceci ?',
                  style: TextStyle(color: Colors.green.shade700)),
              content: const SizedBox(
                  height: 100,
                  width: 100,
                  child: Text(
                      "Cette action permet de soumettre le document chez du direteur du budget")),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: Text('Annuler',
                      style: TextStyle(color: Colors.green.shade700)),
                ),
                TextButton(
                  onPressed: () {
                    controller.submitToDD(widget.departementBudgetModel);
                    Navigator.pop(context, 'ok');
                  },
                  child: Text('OK',
                      style: TextStyle(color: Colors.green.shade700)),
                ),
              ],
            );
          });
        });
  }

  alertDeleteDialog(BudgetPrevisionnelController controller) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              title: Text('Etes-vous sûr de vouloir faire ceci ?',
                  style: TextStyle(color: Colors.red.shade700)),
              content: const SizedBox(
                  height: 100,
                  width: 100,
                  child: Text("Cette action permet de supprimer le budget")),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: Text('Annuler',
                      style: TextStyle(color: Colors.red.shade700)),
                ),
                TextButton(
                  onPressed: () {
                    controller
                        .deleteData(widget.departementBudgetModel.id!);
                    Navigator.pop(context, 'ok');
                  },
                  child:
                      Text('OK', style: TextStyle(color: Colors.red.shade700)),
                ),
              ],
            );
          });
        });
  }
}
