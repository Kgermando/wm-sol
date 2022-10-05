import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart'; 
import 'package:wm_solution/src/models/rh/paiement_salaire_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/salaires/salaire_pdf.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/salaire_controller.dart';
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
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Ressources Humaines"; 

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: headerBar(context, scaffoldKey, title, "${widget.salaire.prenom} ${widget.salaire.nom}"),
        drawer: const DrawerMenu(),
        body: Row(
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: p20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment:
                                    MainAxisAlignment.end,
                          children: [
                            PrintWidget(onPressed: () async {
                              await SalairePdf.generate(widget.salaire);
                            }),
                          ],
                        ),
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.start,
                          children: [
                            Expanded(child: Text(
                              'Bulletin de paie du ${DateFormat("dd-MM-yyyy HH:mm").format(widget.salaire.createdAt)}',
                              style: Theme.of(context).textTheme.headlineSmall,
                            )) 
                          ],
                        ),
                        const SizedBox(
                          height: p20,
                        ),
                        agentWidget(),
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
                  )),
              ))
          ],
        ),
      ),
    );
  }

  Widget agentWidget() {
    final ProfilController profilController = Get.find();
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
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
          )
        ),
        Divider(color: mainColor),
        ResponsiveChildWidget(
          child1: Text(
                'Salaire',
                style: bodyMedium.copyWith(fontWeight: FontWeight.bold),
              ), 
          child2: SelectableText(
              "${NumberFormat.decimalPattern('fr').format(double.parse(widget.salaire.salaire))} USD",
              style: bodyMedium.copyWith(color: Colors.blueGrey),
            )
        ),
        Divider(color: mainColor),
        ResponsiveChild3Widget(
          child1: Text(
            'Observation',
            style: bodyMedium.copyWith(fontWeight: FontWeight.bold),
          ),
          child2: (widget.salaire.observation == 'false' &&
                profilController.user.departement == "Finances") 
              ? checkboxRead() : Container(), 
          child3: (widget.salaire.observation == 'true') 
            ? SelectableText(
              'Payé',
              style: bodyMedium.copyWith(
                  color: Colors.greenAccent.shade700),
            ) : SelectableText(
                'Non payé',
                style: bodyMedium.copyWith(
                    color: Colors.redAccent.shade700),
              )
        ),
        Divider(color: mainColor),
        ResponsiveChildWidget(
          child1: Text(
                'Mode de paiement',
                style: bodyMedium.copyWith(fontWeight: FontWeight.bold),
              ), 
          child2: SelectableText(
              widget.salaire.modePaiement,
              style: bodyMedium,
            )
        ) 
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

  checkboxRead() {
    final SalaireController salaireController = Get.find();
    isChecked = false;
    return ListTile(
      leading: Checkbox(
        checkColor: Colors.white,
        fillColor: MaterialStateProperty.resolveWith(getColor),
        value: isChecked,
        onChanged: (bool? value) { 
          setState(() {
            isChecked = value!;
            salaireController.submitObservation(widget.salaire);
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
          )
        )
      ) 
    );
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
          )
        )
      ) 
    );
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
        child1: Expanded(
          child: Text(
                    'Supplement dû travail du samedi, du dimanche et jours ferié',
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
        )) 
    );
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
        )
      ) 
    );
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
        )
      ) 
    );
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
          )
        )
      ) 
    );
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
          )
        )
      )
    );
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
        )
      ) 
    );
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
          )
        )
      ) 
    );
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
        )
      ) 
    );
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
        )
      ) 
    );
  }

  Widget montantPrisConsiderationCalculCotisationsINSSWidget(
      ) {
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
        child1: Expanded(
          child: Text(
            'Montant pris en consideration pour le calcul des cotisations INSS',
            style: bodyMedium!.copyWith(fontWeight: FontWeight.bold)
          ),
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
        )
      ) 
    );
  }
}
