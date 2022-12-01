import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/models/budgets/ligne_budgetaire_model.dart'; 
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/budgets/controller/ligne_budgetaire_controller.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/responsive_child4_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class DetailLigneBudgetaire extends StatefulWidget {
  const DetailLigneBudgetaire({super.key, required this.ligneBudgetaireModel});
  final LigneBudgetaireModel ligneBudgetaireModel;

  @override
  State<DetailLigneBudgetaire> createState() => _DetailLigneBudgetaireState();
}

class _DetailLigneBudgetaireState extends State<DetailLigneBudgetaire> {
  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Budgets";

  @override
  Widget build(BuildContext context) {
    final LignBudgetaireController controller = Get.find();

    return controller.obx(
        onLoading: loadingPage(context),
        onEmpty: const Text('Aucune donnée'),
        onError: (error) => loadingError(context, error!),
        (state) => Scaffold(
              key: scaffoldKey,
              appBar: headerBar(context, scaffoldKey, title,
                  widget.ligneBudgetaireModel.nomLigneBudgetaire),
              drawer: const DrawerMenu(),
              body: Row(
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: p20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              (Responsive.isDesktop(context))
                                                  ? MainAxisAlignment
                                                      .spaceBetween
                                                  : MainAxisAlignment.end,
                                          children: [
                                            if (Responsive.isDesktop(context))
                                              TitleWidget(
                                                  title: widget
                                                      .ligneBudgetaireModel
                                                      .nomLigneBudgetaire),
                                            Column(
                                              children: [
                                                SelectableText(
                                                    DateFormat(
                                                            "dd-MM-yyyy HH:mm")
                                                        .format(widget
                                                            .ligneBudgetaireModel
                                                            .created),
                                                    textAlign: TextAlign.start),
                                              ],
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: p30,
                                        ),
                                        dataWidget(),
                                        soldeBudgets(controller),
                                        const SizedBox(
                                          height: p20,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )))
                ],
              ),
            ));
  }

  Widget dataWidget() {
    final headline6 = Theme.of(context).textTheme.headline6;
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.all(p10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text('Ligne Budgetaire :',
                    textAlign: TextAlign.start,
                    style: bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: SelectableText(
                    widget.ligneBudgetaireModel.nomLigneBudgetaire,
                    textAlign: TextAlign.start,
                    style: bodyMedium),
              )
            ],
          ),
          Divider(color: mainColor),
          Row(
            children: [
              Expanded(
                child: Text('Département :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: SelectableText(widget.ligneBudgetaireModel.departement,
                    textAlign: TextAlign.start, style: bodyMedium),
              )
            ],
          ),
          Divider(color: mainColor),
          Row(
            children: [
              Expanded(
                child: Text('Fin Budgetaire :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: SelectableText(
                    DateFormat("dd-MM-yyyy")
                        .format(widget.ligneBudgetaireModel.periodeBudgetFin),
                    textAlign: TextAlign.start,
                    style: bodyMedium),
              )
            ],
          ),
          Divider(color: mainColor),
          Row(
            children: [
              Expanded(
                child: Text('Unité Choisie :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: SelectableText(widget.ligneBudgetaireModel.uniteChoisie,
                    textAlign: TextAlign.start, style: bodyMedium),
              )
            ],
          ),
          Divider(color: mainColor),
          Row(
            children: [
              Expanded(
                child: Text('Nombre d\'unité :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: SelectableText(widget.ligneBudgetaireModel.nombreUnite,
                    textAlign: TextAlign.start, style: bodyMedium),
              )
            ],
          ),
          Divider(color: mainColor),
          Row(
            children: [
              Expanded(
                child: Text('Coût Unitaire :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: SelectableText(
                    "${NumberFormat.decimalPattern('fr').format(double.parse(widget.ligneBudgetaireModel.coutUnitaire))} ${monnaieStorage.monney}",
                    textAlign: TextAlign.start,
                    style: bodyMedium),
              )
            ],
          ),
          Divider(color: mainColor),
          const SizedBox(height: p20),
          Row(
            children: [
              Expanded(
                child: Text('Coût Total :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: SelectableText(
                    "${NumberFormat.decimalPattern('fr').format(double.parse(widget.ligneBudgetaireModel.coutTotal))} ${monnaieStorage.monney}",
                    textAlign: TextAlign.start,
                    style: headline6!.copyWith(color: Colors.red.shade700)),
              )
            ],
          ),
          const SizedBox(height: p20),
          Divider(color: mainColor),
          Row(
            children: [
              Expanded(
                child: Text('Caisse :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: SelectableText(
                    "${NumberFormat.decimalPattern('fr').format(double.parse(widget.ligneBudgetaireModel.caisse))} ${monnaieStorage.monney}",
                    textAlign: TextAlign.start,
                    style: bodyMedium),
              )
            ],
          ),
          Divider(color: mainColor),
          Row(
            children: [
              Expanded(
                child: Text('Banque :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: SelectableText(
                    "${NumberFormat.decimalPattern('fr').format(double.parse(widget.ligneBudgetaireModel.banque))} ${monnaieStorage.monney}",
                    textAlign: TextAlign.start,
                    style: bodyMedium),
              )
            ],
          ),
          Divider(color: mainColor),
          Row(
            children: [
              Expanded(
                child: Text('Reste à trouver :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: SelectableText(
                    "${NumberFormat.decimalPattern('fr').format(double.parse(widget.ligneBudgetaireModel.finExterieur))} ${monnaieStorage.monney}",
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(color: Colors.orange.shade700)),
              )
            ],
          ),
          Divider(color: mainColor),
        ],
      ),
    );
  }

  Widget soldeBudgets(LignBudgetaireController controller) {
    // Differences entre les couts initial et les depenses
    double caisseSolde = 0.0;
    double banqueSolde = 0.0;
    double finExterieurSolde = 0.0;
    double touxExecutionsTotal = 0.0;
    double touxExecutions = 0.0;

    caisseSolde = double.parse(widget.ligneBudgetaireModel.caisse) -
        widget.ligneBudgetaireModel.caisseSortie;
    banqueSolde = double.parse(widget.ligneBudgetaireModel.banque) -
        widget.ligneBudgetaireModel.banqueSortie;
    finExterieurSolde = double.parse(widget.ligneBudgetaireModel.finExterieur) -
        widget.ligneBudgetaireModel.finExterieurSortie;

    touxExecutionsTotal = (caisseSolde + banqueSolde + finExterieurSolde) *
        100 /
        double.parse(widget.ligneBudgetaireModel.coutTotal);

    touxExecutions = 100 - touxExecutionsTotal; 

    final headline6 = Theme.of(context).textTheme.headline6;
    return ResponsiveChild4Widget(
        child1: Column(
          children: [
            const Text("Solde Caisse",
                style: TextStyle(fontWeight: FontWeight.bold)),
            SelectableText(
                "${NumberFormat.decimalPattern('fr').format(caisseSolde)} ${monnaieStorage.monney}",
                textAlign: TextAlign.center,
                style: headline6),
          ],
        ),
        child2: Container(
          decoration: BoxDecoration(
              border: Border(
            left: BorderSide(
              color: mainColor,
              width: 2,
            ),
          )),
          child: Column(
            children: [
              const Text("Solde Banque",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SelectableText(
                  "${NumberFormat.decimalPattern('fr').format(banqueSolde)} ${monnaieStorage.monney}",
                  textAlign: TextAlign.center,
                  style: headline6),
            ],
          ),
        ),
        child3: Container(
          decoration: BoxDecoration(
              border: Border(
            left: BorderSide(
              color: mainColor,
              width: 2,
            ),
          )),
          child: Column(
            children: [
              const Text("Solde Reste à trouver",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SelectableText(
                  "${NumberFormat.decimalPattern('fr').format(finExterieurSolde)} ${monnaieStorage.monney}",
                  textAlign: TextAlign.center,
                  style: headline6!.copyWith(color: Colors.orange.shade700)),
            ],
          ),
        ),
        child4: Column(
          children: [
            const Text("Taux d'executions",
                style: TextStyle(fontWeight: FontWeight.bold)),
            SelectableText(
                "${NumberFormat.decimalPattern('fr').format(double.parse(touxExecutions.toStringAsFixed(0)))} %",
                textAlign: TextAlign.center,
                style: headline6.copyWith(
                    color: (touxExecutions >= 50)
                        ? Colors.green.shade700
                        : Colors.red.shade700)),
          ],
        ));
  }
}
