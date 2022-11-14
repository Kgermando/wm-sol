import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/rh/paiement_salaire_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/budgets/controller/budget_previsionnel_controller.dart';
import 'package:wm_solution/src/pages/budgets/controller/ligne_budgetaire_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/salaires/salaire_pdf.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/salaires/salaire_controller.dart';
import 'package:wm_solution/src/widgets/print_widget.dart';
import 'package:wm_solution/src/widgets/responsive_child3_widget.dart';
import 'package:wm_solution/src/widgets/responsive_child4_widget.dart';
import 'package:wm_solution/src/widgets/responsive_child5_widget.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class BulletinSalaire extends StatefulWidget {
  const BulletinSalaire({super.key, required this.salaire});
  final PaiementSalaireModel salaire;

  @override
  State<BulletinSalaire> createState() => _BulletinSalaireState();
}

class _BulletinSalaireState extends State<BulletinSalaire> {
  final SalaireController controller = Get.find(); 
  final ProfilController profilController = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Ressources Humaines";

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: headerBar(context, scaffoldKey, title,
            "${widget.salaire.prenom} ${widget.salaire.nom}"),
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
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        children: [
                          dataWidget(controller),
                          const SizedBox(height: p30),
                          approbationWidget(controller, profilController)
                        ],
                      )),
                ))
          ],
        ),
      ),
    );
  }

  Widget dataWidget(SalaireController controller) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: p20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              PrintWidget(onPressed: () async {
                await SalairePdf.generate(widget.salaire);
              }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  child: Text(
                'Bulletin de paie du ${DateFormat("dd-MM-yyyy HH:mm").format(widget.salaire.createdAt)}',
                style: Theme.of(context).textTheme.headlineSmall,
              ))
            ],
          ),
          const SizedBox(
            height: p20,
          ),
          agentWidget(controller),
          const SizedBox(
            height: p10,
          ),
          salaireWidget(),
          const SizedBox(
            height: p10,
          ),
          heureSupplementaireWidget(),
          const SizedBox(
            height: p10,
          ),
          supplementTravailSamediDimancheJoursFerieWidget(),
          const SizedBox(
            height: p10,
          ),
          primeWidget(),
          const SizedBox(
            height: p10,
          ),
          diversWidget(),
          const SizedBox(
            height: p10,
          ),
          congesPayeWidget(),
          const SizedBox(
            height: p10,
          ),
          maladieAccidentWidget(),
          const SizedBox(
            height: p10,
          ),
          totalDuBrutWidget(),
          const SizedBox(
            height: p10,
          ),
          deductionWidget(),
          const SizedBox(
            height: p10,
          ),
          allocationsFamilialesWidget(),
          const SizedBox(
            height: p10,
          ),
          netAPayerWidget(),
          const SizedBox(
            height: p10,
          ),
          montantPrisConsiderationCalculCotisationsINSSWidget(),
          const SizedBox(
            height: p10,
          ),
        ]),
      ),
    );
  }

  Widget agentWidget(SalaireController controller) {
    
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;

    List<dynamic> depList = jsonDecode(profilController.user.departement); 
    return Column(
      children: [
        ResponsiveChildWidget(
            child1: Text(
              'Matricule',
              style: bodyMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
            child2: SelectableText(
              widget.salaire.matricule,
              style: bodyMedium,
            )),
        Divider(color: mainColor),
        ResponsiveChildWidget(
            child1: Text(
              'Numéro de securité sociale',
              style: bodyMedium.copyWith(fontWeight: FontWeight.bold),
            ),
            child2: SelectableText(
              widget.salaire.numeroSecuriteSociale,
              style: bodyMedium,
            )),
        Divider(color: mainColor),
        ResponsiveChildWidget(
            child1: Text(
              'Nom',
              style: bodyMedium.copyWith(fontWeight: FontWeight.bold),
            ),
            child2: SelectableText(
              widget.salaire.nom,
              style: bodyMedium,
            )),
        Divider(color: mainColor),
        ResponsiveChildWidget(
            child1: Text(
              'Prénom',
              style: bodyMedium.copyWith(fontWeight: FontWeight.bold),
            ),
            child2: SelectableText(
              widget.salaire.prenom,
              style: bodyMedium,
            )),
        Divider(color: mainColor),
        ResponsiveChildWidget(
            child1: Text(
              'Téléphone',
              style: bodyMedium.copyWith(fontWeight: FontWeight.bold),
            ),
            child2: SelectableText(
              widget.salaire.telephone,
              style: bodyMedium,
            )),
        Divider(color: mainColor),
        ResponsiveChildWidget(
            child1: Text(
              'Adresse',
              style: bodyMedium.copyWith(fontWeight: FontWeight.bold),
            ),
            child2: SelectableText(
              widget.salaire.adresse,
              style: bodyMedium,
            )),
        Divider(color: mainColor),
        ResponsiveChildWidget(
            child1: Text(
              'Département',
              style: bodyMedium.copyWith(fontWeight: FontWeight.bold),
            ),
            child2: SelectableText(
              widget.salaire.departement,
              style: bodyMedium,
            )),
        Divider(color: mainColor),
        ResponsiveChildWidget(
            child1: Text(
              'Services d\'affectation',
              style: bodyMedium.copyWith(fontWeight: FontWeight.bold),
            ),
            child2: SelectableText(
              widget.salaire.servicesAffectation,
              style: bodyMedium,
            )),
        Divider(color: mainColor),
        ResponsiveChildWidget(
            child1: Text(
              'Salaire',
              style: bodyMedium.copyWith(fontWeight: FontWeight.bold),
            ),
            child2: SelectableText(
              "${NumberFormat.decimalPattern('fr').format(double.parse(widget.salaire.salaire))} USD",
              style: bodyMedium.copyWith(color: Colors.blueGrey),
            )),
        Divider(color: mainColor),
        ResponsiveChild3Widget(
            child1: Text(
              'Observation',
              style: bodyMedium.copyWith(fontWeight: FontWeight.bold),
            ),
            child2: (widget.salaire.observation == 'false' &&
                depList.contains("Finances"))  
                ? checkboxRead(controller)
                : Container(),
            child3: (widget.salaire.observation == 'true')
                ? SelectableText(
                    'Payé',
                    style:
                        bodyMedium.copyWith(color: Colors.greenAccent.shade700),
                  )
                : SelectableText(
                    'Non payé',
                    style:
                        bodyMedium.copyWith(color: Colors.redAccent.shade700),
                  )),
        Divider(color: mainColor),
        ResponsiveChildWidget(
            child1: Text(
              'Mode de paiement',
              style: bodyMedium.copyWith(fontWeight: FontWeight.bold),
            ),
            child2: SelectableText(
              widget.salaire.modePaiement,
              style: bodyMedium,
            ))
      ],
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.red;
    }
    return Colors.green;
  }

  checkboxRead(SalaireController controller) {
    isChecked = false;
    return ListTile(
      leading: Checkbox(
        checkColor: Colors.white,
        fillColor: MaterialStateProperty.resolveWith(getColor),
        value: isChecked,
        onChanged: (bool? value) {
          setState(() {
            isChecked = value!;
            controller.submitObservation(widget.salaire);
          });
        },
      ),
      title: const Text("Confirmation de Paiement"),
    );
  }

  Widget salaireWidget() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final bodySmall = Theme.of(context).textTheme.bodySmall;
    return Container(
        padding: const EdgeInsets.only(top: p16, bottom: p16),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 1.0, color: mainColor),
            bottom: BorderSide(width: 1.0, color: mainColor),
          ),
        ),
        child: ResponsiveChildWidget(
            mainAxisAlignment: MainAxisAlignment.center,
            flex1: 3,
            flex2: 3,
            child1: Text('Salaires',
                style: bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
            child2: ResponsiveChild3Widget(
                mainAxisAlignment: MainAxisAlignment.center,
                flex1: 3,
                flex2: 3,
                flex3: 2,
                child1: Column(
                  children: [
                    Text(
                      'Durée',
                      style: bodySmall,
                    ),
                    SelectableText(
                      widget.salaire.tauxJourHeureMoisSalaire,
                      style: bodyMedium,
                    ),
                  ],
                ),
                child2: Column(
                  children: [
                    Text('%', style: bodySmall),
                    SelectableText(
                      widget.salaire.joursHeuresPayeA100PourecentSalaire,
                      style: bodyMedium,
                    ),
                  ],
                ),
                child3: Column(
                  children: [
                    Text('Total dû', style: bodySmall),
                    SelectableText(
                      (widget.salaire.totalDuSalaire == '-')
                          ? widget.salaire.totalDuSalaire
                          : "${NumberFormat.decimalPattern('fr').format(double.parse(widget.salaire.totalDuSalaire))} USD",
                      style: bodyMedium,
                    ),
                  ],
                ))));
  }

  Widget heureSupplementaireWidget() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final bodySmall = Theme.of(context).textTheme.bodySmall;
    return Container(
        padding: const EdgeInsets.only(top: p16, bottom: p16),
        decoration: BoxDecoration(
          border: Border(
            // top: BorderSide(width: 1.0),
            bottom: BorderSide(width: 1.0, color: mainColor),
          ),
        ),
        child: ResponsiveChildWidget(
            mainAxisAlignment: MainAxisAlignment.center,
            flex1: 3,
            flex2: 3,
            child1: Text('Heure supplementaire',
                style: bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
            child2: ResponsiveChild3Widget(
                mainAxisAlignment: MainAxisAlignment.center,
                flex1: 3,
                flex2: 3,
                flex3: 2,
                child1: Column(
                  children: [
                    Text(
                      'Nombre Heure',
                      style: bodySmall,
                    ),
                    SelectableText(
                      widget.salaire.nombreHeureSupplementaires,
                      style: bodyMedium,
                    ),
                  ],
                ),
                child2: Column(
                  children: [
                    Text(
                      'Taux',
                      style: bodySmall,
                    ),
                    SelectableText(
                      widget.salaire.tauxHeureSupplementaires,
                      style: bodyMedium,
                    ),
                  ],
                ),
                child3: Column(
                  children: [
                    Text(
                      'Total dû',
                      style: bodySmall,
                    ),
                    SelectableText(
                      widget.salaire.totalDuHeureSupplementaires,
                      style: bodyMedium,
                    ),
                  ],
                ))));
  }

  Widget supplementTravailSamediDimancheJoursFerieWidget() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final bodySmall = Theme.of(context).textTheme.bodySmall;
    return Container(
        padding: const EdgeInsets.only(top: p16, bottom: p16),
        decoration: BoxDecoration(
          border: Border(
            // top: BorderSide(width: 1.0),
            bottom: BorderSide(width: 1.0, color: mainColor),
          ),
        ),
        child: ResponsiveChildWidget(
            mainAxisAlignment: MainAxisAlignment.center,
            flex1: 3,
            flex2: 3,
            child1: SizedBox(
              width: MediaQuery.of(context).size.width / 1.5,
              child: Text(
                  'Supplement dû travail du samedi, du dimanche et jours ferié',
                  softWrap: true,
                  style: bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
            ),
            child2: Column(
              children: [
                Text(
                  'Supplement dû travail',
                  style: bodySmall,
                ),
                SelectableText(
                  widget.salaire.supplementTravailSamediDimancheJoursFerie,
                  style: bodyMedium,
                ),
              ],
            )));
  }

  Widget primeWidget() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final bodySmall = Theme.of(context).textTheme.bodySmall;
    return Container(
        padding: const EdgeInsets.only(top: p16, bottom: p16),
        decoration: BoxDecoration(
          border: Border(
            // top: BorderSide(width: 1.0),
            bottom: BorderSide(width: 1.0, color: mainColor),
          ),
        ),
        child: ResponsiveChildWidget(
            mainAxisAlignment: MainAxisAlignment.center,
            flex1: 3,
            flex2: 3,
            child1: Text('Prime',
                style: bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
            child2: Column(
              children: [
                Text(
                  'Prime',
                  style: bodySmall,
                ),
                SelectableText(
                  widget.salaire.prime,
                  style: bodyMedium,
                ),
              ],
            )));
  }

  Widget diversWidget() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final bodySmall = Theme.of(context).textTheme.bodySmall;
    return Container(
        padding: const EdgeInsets.only(top: p16, bottom: p16),
        decoration: BoxDecoration(
          border: Border(
            // top: BorderSide(width: 1.0),
            bottom: BorderSide(width: 1.0, color: mainColor),
          ),
        ),
        child: ResponsiveChildWidget(
            mainAxisAlignment: MainAxisAlignment.center,
            flex1: 3,
            flex2: 3,
            child1: Text('Divers',
                style: bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
            child2: Column(
              children: [
                Text(
                  'Divers',
                  style: bodySmall,
                ),
                SelectableText(
                  widget.salaire.divers,
                  style: bodyMedium,
                ),
              ],
            )));
  }

  Widget congesPayeWidget() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final bodySmall = Theme.of(context).textTheme.bodySmall;
    return Container(
        padding: const EdgeInsets.only(top: p16, bottom: p16),
        decoration: BoxDecoration(
          border: Border(
            // top: BorderSide(width: 1.0),
            bottom: BorderSide(width: 1.0, color: mainColor),
          ),
        ),
        child: ResponsiveChildWidget(
            mainAxisAlignment: MainAxisAlignment.center,
            flex1: 3,
            flex2: 3,
            child1: Text('Congés Payé',
                style: bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
            child2: ResponsiveChild3Widget(
                mainAxisAlignment: MainAxisAlignment.center,
                flex1: 3,
                flex2: 2,
                flex3: 2,
                child1: Column(
                  children: [
                    Text(
                      'Jours',
                      style: bodySmall,
                    ),
                    SelectableText(
                      widget.salaire.joursCongesPaye,
                      style: bodyMedium,
                    ),
                  ],
                ),
                child2: Column(
                  children: [
                    Text(
                      'Taux',
                      style: bodySmall,
                    ),
                    SelectableText(
                      widget.salaire.tauxCongesPaye,
                      style: bodyMedium,
                    ),
                  ],
                ),
                child3: Column(
                  children: [
                    Text(
                      'Total dû',
                      style: bodySmall,
                    ),
                    SelectableText(
                      widget.salaire.totalDuHeureSupplementaires,
                      style: bodyMedium,
                    ),
                  ],
                ))));
  }

  Widget maladieAccidentWidget() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final bodySmall = Theme.of(context).textTheme.bodySmall;
    return Container(
        padding: const EdgeInsets.only(top: p16, bottom: p16),
        decoration: BoxDecoration(
          border: Border(
            // top: BorderSide(width: 1.0),
            bottom: BorderSide(width: 1.0, color: mainColor),
          ),
        ),
        child: ResponsiveChildWidget(
            mainAxisAlignment: MainAxisAlignment.center,
            flex1: 3,
            flex2: 3,
            child1: Text('Maladie ou Accident',
                style: bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
            child2: ResponsiveChild3Widget(
                mainAxisAlignment: MainAxisAlignment.center,
                flex1: 3,
                flex2: 2,
                flex3: 2,
                child1: Column(
                  children: [
                    Text(
                      'Jours Payé',
                      style: bodySmall,
                    ),
                    SelectableText(
                      widget.salaire.jourPayeMaladieAccident,
                      style: bodyMedium,
                    ),
                  ],
                ),
                child2: Column(
                  children: [
                    Text(
                      'Taux',
                      style: bodySmall,
                    ),
                    SelectableText(
                      widget.salaire.tauxJournalierMaladieAccident,
                      style: bodyMedium,
                    ),
                  ],
                ),
                child3: Column(
                  children: [
                    Text(
                      'Total dû',
                      style: bodySmall,
                    ),
                    SelectableText(
                      widget.salaire.totalDuMaladieAccident,
                      style: bodyMedium,
                    ),
                  ],
                ))));
  }

  Widget totalDuBrutWidget() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final bodySmall = Theme.of(context).textTheme.bodySmall;
    return Container(
        padding: const EdgeInsets.only(top: p16, bottom: p16),
        decoration: BoxDecoration(
          border: Border(
            // top: BorderSide(width: 1.0),
            bottom: BorderSide(width: 1.0, color: mainColor),
          ),
        ),
        child: ResponsiveChildWidget(
            mainAxisAlignment: MainAxisAlignment.center,
            flex1: 3,
            flex2: 3,
            child1: Text('Total brut dû',
                style: bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
            child2: Column(
              children: [
                Text(
                  'Total',
                  style: bodySmall,
                ),
                SelectableText(
                  widget.salaire.totalDuBrut,
                  style: bodyMedium,
                ),
              ],
            )));
  }

  Widget deductionWidget() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final bodySmall = Theme.of(context).textTheme.bodySmall;
    return Container(
        padding: const EdgeInsets.only(top: p16, bottom: p16),
        decoration: BoxDecoration(
          border: Border(
            // top: BorderSide(width: 1.0),
            bottom: BorderSide(width: 1.0, color: mainColor),
          ),
        ),
        child: ResponsiveChildWidget(
            mainAxisAlignment: MainAxisAlignment.center,
            flex1: 3,
            flex2: 3,
            child1: Text('Déduction',
                style: bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
            child2: ResponsiveChild5Widget(
                mainAxisAlignment: MainAxisAlignment.center,
                flex1: 2,
                flex2: 2,
                flex3: 2,
                flex4: 2,
                flex5: 2,
                child1: Column(
                  children: [
                    Text(
                      'Pension',
                      style: bodySmall,
                    ),
                    SelectableText(
                      widget.salaire.pensionDeduction,
                      style: bodyMedium,
                    ),
                  ],
                ),
                child2: Column(
                  children: [
                    Text(
                      'Indemnité compensatrices',
                      style: bodySmall,
                    ),
                    SelectableText(
                      widget.salaire.indemniteCompensatricesDeduction,
                      style: bodyMedium,
                    ),
                  ],
                ),
                child3: Column(
                  children: [
                    Text(
                      'Avances',
                      style: bodySmall,
                    ),
                    SelectableText(
                      widget.salaire.avancesDeduction,
                      style: bodyMedium,
                    ),
                  ],
                ),
                child4: Column(
                  children: [
                    Text(
                      'Divers',
                      style: bodySmall,
                    ),
                    SelectableText(
                      widget.salaire.diversDeduction,
                      style: bodyMedium,
                    ),
                  ],
                ),
                child5: Column(
                  children: [
                    Text(
                      'Retenues fiscales',
                      style: bodySmall,
                    ),
                    SelectableText(
                      widget.salaire.retenuesFiscalesDeduction,
                      style: bodyMedium,
                    ),
                  ],
                ))));
  }

  Widget allocationsFamilialesWidget() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final bodySmall = Theme.of(context).textTheme.bodySmall;
    return Container(
        padding: const EdgeInsets.only(top: p16, bottom: p16),
        decoration: BoxDecoration(
          border: Border(
            // top: BorderSide(width: 1.0),
            bottom: BorderSide(width: 1.0, color: mainColor),
          ),
        ),
        child: ResponsiveChildWidget(
            mainAxisAlignment: MainAxisAlignment.center,
            flex1: 3,
            flex2: 3,
            child1: Text('Allocations familiales',
                style: bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
            child2: ResponsiveChild4Widget(
              mainAxisAlignment: MainAxisAlignment.center,
              flex1: 2,
              flex2: 2,
              flex3: 2,
              flex4: 2,
              child1: Column(
                children: [
                  Text(
                    'Nombre des enfants béneficaire',
                    style: bodySmall,
                  ),
                  SelectableText(
                    widget.salaire.nombreEnfantBeneficaireAllocationsFamiliales,
                    style: bodyMedium,
                  ),
                ],
              ),
              child2: Column(
                children: [
                  Text(
                    'Nombre des Jours',
                    style: bodySmall,
                  ),
                  SelectableText(
                    widget.salaire.nombreDeJoursAllocationsFamiliales,
                    style: bodyMedium,
                  ),
                ],
              ),
              child3: Column(
                children: [
                  Text(
                    'Taux journalier',
                    style: bodySmall,
                  ),
                  SelectableText(
                    widget.salaire.tauxJoursAllocationsFamiliales,
                    style: bodyMedium,
                  ),
                ],
              ),
              child4: Column(
                children: [
                  Text(
                    'Total à payer',
                    style: bodySmall,
                  ),
                  SelectableText(
                    widget.salaire.totalAPayerAllocationsFamiliales,
                    style: bodyMedium,
                  ),
                ],
              ),
            )));
  }

  Widget netAPayerWidget() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final bodySmall = Theme.of(context).textTheme.bodySmall;
    return Container(
        padding: const EdgeInsets.only(top: p16, bottom: p16),
        decoration: BoxDecoration(
          border: Border(
            // top: BorderSide(width: 1.0),
            bottom: BorderSide(width: 1.0, color: mainColor),
          ),
        ),
        child: ResponsiveChildWidget(
            mainAxisAlignment: MainAxisAlignment.center,
            child1: Text('Net à payer',
                style: bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
            child2: Column(
              children: [
                Text(
                  'Total à payer',
                  style: bodySmall,
                ),
                SelectableText(
                  widget.salaire.netAPayer,
                  style: bodyMedium,
                ),
              ],
            )));
  }

  Widget montantPrisConsiderationCalculCotisationsINSSWidget() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final bodySmall = Theme.of(context).textTheme.bodySmall;
    return Container(
        padding: const EdgeInsets.only(top: p16, bottom: p16),
        decoration: const BoxDecoration(
          border: Border(
              // top: BorderSide(width: 1.0),
              // bottom: BorderSide(width: 1.0, color: mainColor),
              ),
        ),
        child: ResponsiveChildWidget(
            mainAxisAlignment: MainAxisAlignment.center,
            child1: SizedBox(
              width: MediaQuery.of(context).size.width / 1.5,
              child: Text(
                  'Montant pris en consideration pour le calcul des cotisations INSS',
                  style: bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
            ),
            child2: Column(
              children: [
                Text(
                  'Montant pris pour la Cotisations INSS',
                  style: bodySmall,
                ),
                SelectableText(
                  widget.salaire.montantPrisConsiderationCalculCotisationsINSS,
                  style: bodyMedium,
                ),
              ],
            )));
  }

  Widget approbationWidget(
      SalaireController controller, ProfilController profilController) {
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    List<dynamic> depList = jsonDecode(profilController.user.departement);
    return Card(
      elevation: 3,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(p10),
          border: Border.all(
            color: Colors.red.shade700,
            width: 2.0,
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TitleWidget(title: "Approbations"),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add_task, color: Colors.green.shade700)),
              ],
            ),
            const SizedBox(height: p20),
            Divider(color: Colors.red[10]),
            Padding(
                padding: const EdgeInsets.all(p10),
                child: ResponsiveChildWidget(
                    flex1: 1,
                    flex2: 4,
                    child1: Text("Directeur de departement", style: bodyLarge),
                    child2: Column(
                      children: [
                        ResponsiveChild3Widget(
                            flex1: 2,
                            flex2: 3,
                            flex3: 2,
                            child1: Column(
                              children: [
                                const Text("Approbation"),
                                const SizedBox(height: p20),
                                Text(widget.salaire.approbationDD,
                                    style: bodyLarge!.copyWith(
                                        color: (widget.salaire.approbationDD ==
                                                "Unapproved")
                                            ? Colors.red.shade700
                                            : Colors.green.shade700)),
                              ],
                            ),
                            child2:
                                (widget.salaire.approbationDD == "Unapproved")
                                    ? Column(
                                        children: [
                                          const Text("Motif"),
                                          const SizedBox(height: p20),
                                          Text(widget.salaire.motifDD),
                                        ],
                                      )
                                    : Container(),
                            child3: Column(
                              children: [
                                const Text("Signature"),
                                const SizedBox(height: p20),
                                Text(widget.salaire.signatureDD),
                              ],
                            )),
                        if (widget.salaire.approbationDD == '-' &&
                            profilController.user.fonctionOccupe ==
                                "Directeur de departement")
                          Padding(
                              padding: const EdgeInsets.all(p10),
                              child: ResponsiveChildWidget(
                                  child1: approbationDDWidget(controller),
                                  child2:
                                      (controller.approbationDD == "Unapproved")
                                          ? motifDDWidget(controller)
                                          : Container())),
                      ],
                    ))),
            const SizedBox(height: p20),
            Divider(color: Colors.red[10]),
            Padding(
                padding: const EdgeInsets.all(p10),
                child: ResponsiveChildWidget(
                    flex1: 1,
                    flex2: 4,
                    child1: Text("Budget", style: bodyLarge),
                    child2: Column(
                      children: [
                        ResponsiveChild3Widget(
                            child1: Column(
                              children: [
                                const Text("Approbation"),
                                const SizedBox(height: p20),
                                Text(widget.salaire.approbationBudget,
                                    style: bodyLarge.copyWith(
                                        color:
                                            (widget.salaire.approbationBudget ==
                                                    "Unapproved")
                                                ? Colors.red.shade700
                                                : Colors.green.shade700)),
                              ],
                            ),
                            child2: (widget.salaire.approbationBudget ==
                                    "Unapproved")
                                ? Column(
                                    children: [
                                      const Text("Motif"),
                                      const SizedBox(height: p20),
                                      Text(widget.salaire.motifBudget),
                                    ],
                                  )
                                : Container(),
                            child3: Column(
                              children: [
                                const Text("Signature"),
                                const SizedBox(height: p20),
                                Text(widget.salaire.signatureBudget),
                              ],
                            )),
                        const SizedBox(height: p20),
                        ResponsiveChildWidget(
                            flex1: 2,
                            flex2: 2,
                            child1: Column(
                              children: [
                                const Text("Ligne Budgetaire"),
                                const SizedBox(height: p20),
                                Text(widget.salaire.ligneBudgetaire,
                                    style: bodyLarge.copyWith(
                                        color: Colors.purple.shade700)),
                              ],
                            ),
                            child2: Column(
                              children: [
                                const Text("Ressource"),
                                const SizedBox(height: p20),
                                Text(widget.salaire.ressource,
                                    style: bodyLarge.copyWith(
                                        color: Colors.purple.shade700)),
                              ],
                            )), 
                      if (widget.salaire.approbationBudget == '-' &&
                          profilController.user.fonctionOccupe ==
                              "Directeur de budget" ||
                      depList.contains('Budgets') &&
                          widget.salaire.approbationBudget == '-' &&
                          profilController.user.fonctionOccupe ==
                              "Directeur de finance" ||
                      depList.contains('Budgets') &&
                          widget.salaire.approbationBudget == '-' &&
                          profilController.user.fonctionOccupe ==
                              "Directeur de departement" ||
                      depList.contains('Budgets') &&
                          widget.salaire.approbationBudget == '-' &&
                          profilController.user.fonctionOccupe ==
                              "Directeur générale")
                          Padding(
                            padding: const EdgeInsets.all(p10),
                            child: Form(
                              key: controller.formKeyBudget,
                              child: Column(
                                children: [
                                  ResponsiveChildWidget(
                                      child1: ligneBudgtaireWidget(controller),
                                      child2: resourcesWidget(controller)),
                                  ResponsiveChildWidget(
                                      child1:
                                          approbationBudgetWidget(controller),
                                      child2: (controller.approbationBudget ==
                                              "Unapproved")
                                          ? motifBudgetWidget(controller)
                                          : Container())
                                ],
                              ),
                            ),
                          ),
                      ],
                    ))),
            const SizedBox(height: p20),
            Divider(color: Colors.red[10]),
            Padding(
              padding: const EdgeInsets.all(p10),
              child: ResponsiveChildWidget(
                  flex1: 1,
                  flex2: 4,
                  child1: Text("Finance", style: bodyLarge),
                  child2: Column(
                    children: [
                      ResponsiveChild3Widget(
                          flex1: 2,
                          flex2: 3,
                          flex3: 2,
                          child1: Column(
                            children: [
                              const Text("Approbation"),
                              const SizedBox(height: p20),
                              Text(widget.salaire.approbationFin,
                                  style: bodyLarge.copyWith(
                                      color: (widget.salaire.approbationFin ==
                                              "Unapproved")
                                          ? Colors.red.shade700
                                          : Colors.green.shade700)),
                            ],
                          ),
                          child2:
                              (widget.salaire.approbationFin == "Unapproved")
                                  ? Column(
                                      children: [
                                        const Text("Motif"),
                                        const SizedBox(height: p20),
                                        Text(widget.salaire.motifFin),
                                      ],
                                    )
                                  : Container(),
                          child3: Column(
                            children: [
                              const Text("Signature"),
                              const SizedBox(height: p20),
                              Text(widget.salaire.signatureFin),
                            ],
                          )), 
                      if (widget.salaire.approbationFin == '-' &&
                                profilController.user.fonctionOccupe ==
                                    "Directeur de finance" ||
                            depList.contains('Finances') &&
                                widget.salaire.approbationFin == '-' &&
                                profilController.user.fonctionOccupe ==
                                    "Directeur de budget" ||
                            depList.contains('Finances') &&
                                widget.salaire.approbationFin == '-' &&
                                profilController.user.fonctionOccupe ==
                                    "Directeur de departement" ||
                            depList.contains('Finances') &&
                                widget.salaire.approbationFin == '-' &&
                                profilController.user.fonctionOccupe ==
                                    "Directeur générale")
                        Padding(
                            padding: const EdgeInsets.all(p10),
                            child: ResponsiveChildWidget(
                                child1: approbationFinWidget(controller),
                                child2:
                                    (controller.approbationFin == "Unapproved")
                                        ? motifFinWidget(controller)
                                        : Container())),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget approbationDDWidget(SalaireController controller) {
    List<String> approbationList = ['Approved', 'Unapproved', '-'];
    return Container(
      margin: const EdgeInsets.only(bottom: p10),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Approbation',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: controller.approbationDD,
        isExpanded: true,
        items: approbationList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            controller.approbationDD = value!;
            if (controller.approbationDD == "Approved") {
              controller.submitDD(widget.salaire);
            }
          });
        },
      ),
    );
  }

  Widget motifDDWidget(SalaireController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p10),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: TextFormField(
                controller: controller.motifDDController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  labelText: 'Ecrivez le motif...',
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Ce champs est obligatoire';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                  tooltip: 'Soumettre le Motif',
                  onPressed: () {
                    controller.submitDD(widget.salaire);
                  },
                  icon: Icon(Icons.send, color: Colors.red.shade700)),
            )
          ],
        ));
  }

  Widget approbationBudgetWidget(SalaireController controller) {
    List<String> approbationList = ['Approved', 'Unapproved', '-'];
    return Container(
      margin: const EdgeInsets.only(bottom: p10),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Approbation',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: controller.approbationBudget,
        isExpanded: true,
        items: approbationList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            controller.approbationBudget = value!;
            final form = controller.formKeyBudget.currentState!;
            if (form.validate()) {
              if (controller.approbationBudget == "Approved") {
                controller.submitBudget(widget.salaire);
              }
            }
          });
        },
      ),
    );
  }

  Widget motifBudgetWidget(SalaireController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p10),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: TextFormField(
                controller: controller.motifBudgetController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  labelText: 'Ecrivez le motif...',
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Ce champs est obligatoire';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                  tooltip: 'Soumettre le Motif',
                  onPressed: () {
                    controller.submitBudget(widget.salaire);
                  },
                  icon: Icon(Icons.send, color: Colors.red.shade700)),
            )
          ],
        ));
  }

  Widget approbationFinWidget(SalaireController controller) {
    List<String> approbationList = ['Approved', 'Unapproved', '-'];
    return Container(
      margin: const EdgeInsets.only(bottom: p10),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Approbation',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: controller.approbationFin,
        isExpanded: true,
        items: approbationList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            controller.approbationFin = value!;
            if (controller.approbationFin == "Approved") {
              controller.submitFin(widget.salaire);
            }
          });
        },
      ),
    );
  }

  Widget motifFinWidget(SalaireController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p10),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: TextFormField(
                controller: controller.motifFinController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  labelText: 'Ecrivez le motif...',
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Ce champs est obligatoire';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                  tooltip: 'Soumettre le Motif',
                  onPressed: () {
                    controller.submitFin(widget.salaire);
                  },
                  icon: Icon(Icons.send, color: Colors.red.shade700)),
            )
          ],
        ));
  }

  // Soumettre une ligne budgetaire
  Widget ligneBudgtaireWidget(SalaireController controller) {
    final BudgetPrevisionnelController budgetPrevisionnelController =
        Get.find();
    final LignBudgetaireController lignBudgetaireController = Get.find();

    return budgetPrevisionnelController.obx((state) {
      return lignBudgetaireController.obx((ligne) {
        List<String> dataList = [];
        for (var i in state!) {
          dataList = ligne!
              .where((element) =>
                  element.periodeBudgetDebut.microsecondsSinceEpoch ==
                      i.periodeDebut.microsecondsSinceEpoch &&
                  i.approbationDG == "Approved" &&
                  i.approbationDD == "Approved" &&
                  DateTime.now().isBefore(element.periodeBudgetFin) &&
                  element.departement == "Ressources Humaines")
              .map((e) => e.nomLigneBudgetaire)
              .toList();
        }
        return Container(
          margin: const EdgeInsets.only(bottom: p10),
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Ligne Budgetaire',
              labelStyle: const TextStyle(),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              contentPadding: const EdgeInsets.only(left: 5.0),
            ),
            value: controller.ligneBudgtaire,
            isExpanded: true,
            items: dataList.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            validator: (value) =>
                value == null ? "Select Ligne Budgetaire" : null,
            onChanged: (value) {
              setState(() {
                controller.ligneBudgtaire = value!;
              });
            },
          ),
        );
      });
    });
  }

  Widget resourcesWidget(SalaireController controller) {
    List<String> dataList = ['caisse', 'banque', 'finExterieur'];
    return Container(
      margin: const EdgeInsets.only(bottom: p10),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Resource',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: controller.ressource,
        isExpanded: true,
        items: dataList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        validator: (value) => value == null ? "Select Resource" : null,
        onChanged: (value) {
          setState(() {
            controller.ressource = value!;
          });
        },
      ),
    );
  }
}
