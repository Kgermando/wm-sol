import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/models/rh/agent_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/salaires/salaire_controller.dart';
import 'package:wm_solution/src/widgets/btn_widget.dart';
import 'package:wm_solution/src/widgets/responsive_child3_widget.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class AddSalaire extends StatefulWidget {
  const AddSalaire({super.key, required this.personne});
  final AgentModel personne;

  @override
  State<AddSalaire> createState() => _AddSalaireState();
}

class _AddSalaireState extends State<AddSalaire> {
  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Ressources Humaines";
  String subTitle = "New bulletin";

  @override
  Widget build(BuildContext context) {
    final SalaireController controller = Get.find();
    return Scaffold(
        key: scaffoldKey,
        appBar: headerBar(context, scaffoldKey, title, subTitle),
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
                        // border: Border.all(
                        //   // color: Colors.red,
                        // ),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: p20),
                        child: Form(
                          key: controller.formKey,
                          child: Column(
                            children: [
                              const TitleWidget(
                                  title: "Generer le bulletin de paie"),
                              const SizedBox(height: p20),
                              agentWidget(),
                              const SizedBox(
                                height: p20,
                              ),
                              salaireWidget(controller),
                              const SizedBox(
                                height: p20,
                              ),
                              heureSupplementaireWidget(controller),
                              const SizedBox(
                                height: p20,
                              ),
                              supplementTravailSamediDimancheJoursFerieWidget(
                                  controller),
                              const SizedBox(
                                height: p20,
                              ),
                              primeWidget(controller),
                              const SizedBox(
                                height: p20,
                              ),
                              diversWidget(controller),
                              const SizedBox(
                                height: p20,
                              ),
                              congesPayeWidget(controller),
                              const SizedBox(
                                height: p20,
                              ),
                              maladieAccidentWidget(controller),
                              const SizedBox(
                                height: p20,
                              ),
                              totalDuBrutWidget(controller),
                              const SizedBox(
                                height: p20,
                              ),
                              deductionWidget(controller),
                              const SizedBox(
                                height: p20,
                              ),
                              allocationsFamilialesWidget(controller),
                              const SizedBox(
                                height: p20,
                              ),
                              netAPayerWidget(controller),
                              const SizedBox(
                                height: p20,
                              ),
                              montantPrisConsiderationCalculCotisationsINSSWidget(
                                  controller),
                              const SizedBox(
                                height: p20,
                              ),
                              BtnWidget(
                                  title: 'Soumettre',
                                  isLoading: controller.isLoading,
                                  press: () {
                                    controller.submit(widget.personne);
                                  })
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
          ],
        ));
  }

  Widget agentWidget() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return Column(
      children: [
        ResponsiveChildWidget(
            child1: Text(
              'Matricule',
              style: bodyMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
            child2: SelectableText(
              widget.personne.matricule,
              style: bodyMedium,
            )),
        Divider(color: mainColor),
        ResponsiveChildWidget(
            child1: Text(
              'Numéro de securité sociale',
              style: bodyMedium.copyWith(fontWeight: FontWeight.bold),
            ),
            child2: SelectableText(
              widget.personne.numeroSecuriteSociale,
              style: bodyMedium,
            )),
        Divider(color: mainColor),
        ResponsiveChildWidget(
            child1: Text(
              'Nom',
              style: bodyMedium.copyWith(fontWeight: FontWeight.bold),
            ),
            child2: SelectableText(
              widget.personne.nom,
              style: bodyMedium,
            )),
        Divider(color: mainColor),
        ResponsiveChildWidget(
            child1: Text(
              'Prénom',
              style: bodyMedium.copyWith(fontWeight: FontWeight.bold),
            ),
            child2: SelectableText(
              widget.personne.prenom,
              style: bodyMedium,
            )),
        Divider(color: mainColor),
        ResponsiveChildWidget(
            child1: Text(
              'Téléphone',
              style: bodyMedium.copyWith(fontWeight: FontWeight.bold),
            ),
            child2: SelectableText(
              widget.personne.telephone,
              style: bodyMedium,
            )),
        Divider(color: mainColor),
        ResponsiveChildWidget(
            child1: Text(
              'Adresse',
              style: bodyMedium.copyWith(fontWeight: FontWeight.bold),
            ),
            child2: SelectableText(
              widget.personne.adresse,
              style: bodyMedium,
            )),
        Divider(color: mainColor),
        ResponsiveChildWidget(
            child1: Text(
              'Département',
              style: bodyMedium.copyWith(fontWeight: FontWeight.bold),
            ),
            child2: SelectableText(
              widget.personne.departement,
              style: bodyMedium,
            )),
        Divider(color: mainColor),
        ResponsiveChildWidget(
            child1: Text(
              'Services d\'affectation',
              style: bodyMedium.copyWith(fontWeight: FontWeight.bold),
            ),
            child2: SelectableText(
              widget.personne.servicesAffectation,
              style: bodyMedium,
            )),
        Divider(color: mainColor),
        ResponsiveChildWidget(
            child1: Text(
              'Salaire',
              style: bodyMedium.copyWith(fontWeight: FontWeight.bold),
            ),
            child2: SelectableText(
              "${NumberFormat.decimalPattern('fr').format(double.parse(widget.personne.salaire))} ${monnaieStorage.monney}",
              style: bodyMedium,
            )),
      ],
    );
  }

  Widget salaireWidget(SalaireController controller) {
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    return Container(
      padding: const EdgeInsets.only(top: p16, bottom: p16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0, color: mainColor),
          bottom: BorderSide(width: 1.0, color: mainColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 3,
              child: Text('Salaires',
                  style: bodyLarge!.copyWith(fontWeight: FontWeight.bold))),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                tauxJourHeureMoisSalaireWidget(controller),
                ResponsiveChildWidget(
                    mainAxisAlignment: MainAxisAlignment.center,
                    child1:
                        joursHeuresPayeA100PourecentSalaireWidget(controller),
                    child2: totalDuSalaireWidget(controller)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget tauxJourHeureMoisSalaireWidget(SalaireController controller) {
    return Container(
      margin: const EdgeInsets.only(bottom: p10, left: p5),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Taux, Jour, Heure, Mois',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        value: controller.tauxJourHeureMoisSalaire,
        isExpanded: true,
        items: controller.tauxJourHeureMoisSalaireList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        validator: (value) => value == null ? "Select Taux" : null,
        onChanged: (value) {
          setState(() {
            controller.tauxJourHeureMoisSalaire = value!;
          });
        },
      ),
    );
  }

  Widget joursHeuresPayeA100PourecentSalaireWidget(
      SalaireController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p10, left: p5),
        child: TextFormField(
          controller: controller.joursHeuresPayeA100PourecentSalaireController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'en %',
            hintText: 'en %',
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          style: const TextStyle(),
          validator: (value) {
            if (value != null && value.isEmpty) {
              return 'Ce champs est obligatoire';
            } else {
              return null;
            }
          },
        ));
  }

  Widget totalDuSalaireWidget(SalaireController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p10, left: p5),
        child: TextFormField(
          controller: controller.totalDuSalaireController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Total dû',
            hintText: 'Total dû',
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          style: const TextStyle(),
          validator: (value) {
            if (value != null && value.isEmpty) {
              return 'Ce champs est obligatoire';
            } else {
              return null;
            }
          },
        ));
  }

  Widget heureSupplementaireWidget(SalaireController controller) {
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    return Container(
      padding: const EdgeInsets.only(top: p16, bottom: p16),
      decoration: BoxDecoration(
        border: Border(
          // top: BorderSide(width: 1.0),
          bottom: BorderSide(width: 1.0, color: mainColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 3,
              child: Text('Heure supplementaire',
                  style: bodyLarge!.copyWith(fontWeight: FontWeight.bold))),
          Expanded(
              flex: 3,
              child: ResponsiveChild3Widget(
                  mainAxisAlignment: MainAxisAlignment.center,
                  flex1: 3,
                  flex2: 2,
                  flex3: 2,
                  child1: nombreHeureSupplementairesWidget(controller),
                  child2: tauxHeureSupplementairesWidget(controller),
                  child3: totalDuHeureSupplementairesWidget(controller))),
        ],
      ),
    );
  }

  Widget nombreHeureSupplementairesWidget(SalaireController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p10, left: p5),
        child: TextFormField(
          controller: controller.nombreHeureSupplementairesController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Nombre Heure',
            hintText: 'Nombre Heure',
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          style: const TextStyle(),
        ));
  }

  Widget tauxHeureSupplementairesWidget(SalaireController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p10, left: p5),
        child: TextFormField(
          controller: controller.tauxHeureSupplementairesController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Taux',
            hintText: 'Taux',
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          style: const TextStyle(),
        ));
  }

  Widget totalDuHeureSupplementairesWidget(SalaireController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p10, left: p5),
        child: TextFormField(
          controller: controller.totalDuHeureSupplementairesController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Total dû',
            hintText: 'Total dû',
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          style: const TextStyle(),
        ));
  }

  Widget supplementTravailSamediDimancheJoursFerieWidget(
      SalaireController controller) {
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    return Container(
      padding: const EdgeInsets.only(top: p16, bottom: p16),
      decoration: BoxDecoration(
        border: Border(
          // top: BorderSide(width: 1.0),
          bottom: BorderSide(width: 1.0, color: mainColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 3,
              child: Text(
                  'Supplement dû travail du samedi, du dimanche et jours ferié',
                  style: bodyLarge!.copyWith(fontWeight: FontWeight.bold))),
          Expanded(
            flex: 3,
            child: supplementairesWidget(controller),
          ),
        ],
      ),
    );
  }

  Widget supplementairesWidget(SalaireController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p10, left: p5),
        child: TextFormField(
          controller:
              controller.supplementTravailSamediDimancheJoursFerieController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Supplement dû travail',
            hintText: 'Supplement dû travail',
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          style: const TextStyle(),
        ));
  }

  Widget primeWidget(SalaireController controller) {
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    return Container(
      padding: const EdgeInsets.only(top: p16, bottom: p16),
      decoration: BoxDecoration(
        border: Border(
          // top: BorderSide(width: 1.0),
          bottom: BorderSide(width: 1.0, color: mainColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 3,
              child: Text('Prime',
                  style: bodyLarge!.copyWith(fontWeight: FontWeight.bold))),
          Expanded(flex: 3, child: primeFielWidget(controller)),
        ],
      ),
    );
  }

  Widget primeFielWidget(SalaireController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p10, left: p5),
        child: TextFormField(
          controller: controller.primeController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Prime',
            hintText: 'Prime',
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          style: const TextStyle(),
        ));
  }

  Widget diversWidget(SalaireController controller) {
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    return Container(
      padding: const EdgeInsets.only(top: p16, bottom: p16),
      decoration: BoxDecoration(
        border: Border(
          // top: BorderSide(width: 1.0),
          bottom: BorderSide(width: 1.0, color: mainColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 3,
              child: Text('Divers',
                  style: bodyLarge!.copyWith(fontWeight: FontWeight.bold))),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Expanded(child: diversFielWidget(controller))],
            ),
          ),
        ],
      ),
    );
  }

  Widget diversFielWidget(SalaireController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p10, left: p5),
        child: TextFormField(
          controller: controller.diversController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Divers',
            hintText: 'Divers',
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          style: const TextStyle(),
        ));
  }

  Widget congesPayeWidget(SalaireController controller) {
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    return Container(
      padding: const EdgeInsets.only(top: p16, bottom: p16),
      decoration: BoxDecoration(
        border: Border(
          // top: BorderSide(width: 1.0),
          bottom: BorderSide(width: 1.0, color: mainColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 3,
              child: Text('Congés Payé',
                  style: bodyLarge!.copyWith(fontWeight: FontWeight.bold))),
          Expanded(
              flex: 3,
              child: ResponsiveChild3Widget(
                  mainAxisAlignment: MainAxisAlignment.center,
                  flex1: 3,
                  flex2: 2,
                  flex3: 2,
                  child1: joursCongesPayeWidget(controller),
                  child2: tauxCongesPayeWidget(controller),
                  child3: totalDuCongesPayeWidget(controller))),
        ],
      ),
    );
  }

  Widget joursCongesPayeWidget(SalaireController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p10, left: p5),
        child: TextFormField(
          controller: controller.joursCongesPayeController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Jours',
            hintText: 'Jours',
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          style: const TextStyle(),
        ));
  }

  Widget tauxCongesPayeWidget(SalaireController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p10, left: p5),
        child: TextFormField(
          controller: controller.tauxCongesPayeController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Taux',
            hintText: 'Taux',
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          style: const TextStyle(),
        ));
  }

  Widget totalDuCongesPayeWidget(SalaireController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p10, left: p5),
        child: TextFormField(
          controller: controller.totalDuCongePayeController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Total dû',
            hintText: 'Total dû',
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          style: const TextStyle(),
        ));
  }

  Widget totalDuCongePayeWidget(SalaireController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p10, left: p5),
        child: TextFormField(
          controller: controller.totalDuCongePayeController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Total dû',
            hintText: 'Total dû',
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          style: const TextStyle(),
        ));
  }

  Widget maladieAccidentWidget(SalaireController controller) {
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    return Container(
      padding: const EdgeInsets.only(top: p16, bottom: p16),
      decoration: BoxDecoration(
        border: Border(
          // top: BorderSide(width: 1.0),
          bottom: BorderSide(width: 1.0, color: mainColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 3,
              child: Text('Maladie ou Accident',
                  style: bodyLarge!.copyWith(fontWeight: FontWeight.bold))),
          Expanded(
              flex: 3,
              child: ResponsiveChild3Widget(
                  mainAxisAlignment: MainAxisAlignment.center,
                  flex1: 3,
                  flex2: 2,
                  flex3: 2,
                  child1: jourPayeMaladieAccidentWidget(controller),
                  child2: tauxJournalierMaladieAccidentWidget(controller),
                  child3: totalDuMaladieAccidentWidget(controller))),
        ],
      ),
    );
  }

  Widget jourPayeMaladieAccidentWidget(SalaireController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p10, left: p5),
        child: TextFormField(
          controller: controller.jourPayeMaladieAccidentController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Jours Payé',
            hintText: 'Jours Payé',
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          style: const TextStyle(),
        ));
  }

  Widget tauxJournalierMaladieAccidentWidget(SalaireController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p10, left: p5),
        child: TextFormField(
          controller: controller.tauxJournalierMaladieAccidentController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Taux',
            hintText: 'Taux',
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          style: const TextStyle(),
        ));
  }

  Widget totalDuMaladieAccidentWidget(SalaireController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p10, left: p5),
        child: TextFormField(
          controller: controller.totalDuMaladieAccidentController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Total dû',
            hintText: 'Total dû',
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          style: const TextStyle(),
        ));
  }

  Widget totalDuBrutWidget(SalaireController controller) {
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    return Container(
      padding: const EdgeInsets.only(top: p16, bottom: p16),
      decoration: BoxDecoration(
        border: Border(
          // top: BorderSide(width: 1.0),
          bottom: BorderSide(width: 1.0, color: mainColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 3,
              child: Text('Total brut dû',
                  style: bodyLarge!.copyWith(fontWeight: FontWeight.bold))),
          Expanded(flex: 3, child: totalDuBrutFieldWidget(controller)),
        ],
      ),
    );
  }

  Widget totalDuBrutFieldWidget(SalaireController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p10, left: p5),
        child: TextFormField(
          controller: controller.totalDuBrutController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Total dû',
            hintText: 'Total dû',
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          style: const TextStyle(),
        ));
  }

  Widget deductionWidget(SalaireController controller) {
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    return Container(
      padding: const EdgeInsets.only(top: p16, bottom: p16),
      decoration: BoxDecoration(
        border: Border(
          // top: BorderSide(width: 1.0),
          bottom: BorderSide(width: 1.0, color: mainColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 3,
              child: Text('Deduction',
                  style: bodyLarge!.copyWith(fontWeight: FontWeight.bold))),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                indemniteCompensatricesDeductionWidget(controller),
                ResponsiveChild3Widget(
                    mainAxisAlignment: MainAxisAlignment.center,
                    child1: pensionDeductiontWidget(controller),
                    child2: avancesDeductionWidget(controller),
                    child3: diversDeductionWidget(controller)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: retenuesFiscalesDeductionWidget(controller))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget pensionDeductiontWidget(SalaireController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p10, left: p5),
        child: TextFormField(
          controller: controller.pensionDeductionController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Pension',
            hintText: 'Pension',
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          style: const TextStyle(),
        ));
  }

  Widget indemniteCompensatricesDeductionWidget(SalaireController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p10, left: p5),
        child: TextFormField(
          controller: controller.indemniteCompensatricesDeductionController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Indemnité compensatrices',
            hintText: 'Indemnité compensatrices',
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          style: const TextStyle(),
        ));
  }

  Widget avancesDeductionWidget(SalaireController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p10, left: p5),
        child: TextFormField(
          controller: controller.avancesDeductionController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Avances',
            hintText: 'Avances',
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          style: const TextStyle(),
        ));
  }

  Widget diversDeductionWidget(SalaireController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p10, left: p5),
        child: TextFormField(
          controller: controller.diversDeductionController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Divers',
            hintText: 'Divers',
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          style: const TextStyle(),
        ));
  }

  Widget retenuesFiscalesDeductionWidget(SalaireController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p10, left: p5),
        child: TextFormField(
          controller: controller.retenuesFiscalesDeductionController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Retenues fiscales',
            hintText: 'Retenues fiscales',
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          style: const TextStyle(),
        ));
  }

  Widget allocationsFamilialesWidget(SalaireController controller) {
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    return Container(
      padding: const EdgeInsets.only(top: p16, bottom: p16),
      decoration: BoxDecoration(
        border: Border(
          // top: BorderSide(width: 1.0),
          bottom: BorderSide(width: 1.0, color: mainColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 3,
              child: Text('Allocations familiales',
                  style: bodyLarge!.copyWith(fontWeight: FontWeight.bold))),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                nombreEnfantBeneficaireAllocationsFamilialesWidget(controller),
                nombreDeJoursAllocationsFamilialesWidget(controller),
                ResponsiveChildWidget(
                  mainAxisAlignment: MainAxisAlignment.center,
                  child1: tauxJoursAllocationsFamilialesWidget(controller),
                  child2: totalAPayerAllocationsFamilialesWidget(controller),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget nombreEnfantBeneficaireAllocationsFamilialesWidget(
      SalaireController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p10, left: p5),
        child: TextFormField(
          controller:
              controller.nombreEnfantBeneficaireAllocationsFamilialesController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Nombre des enfants béneficaire',
            hintText: 'Nombre des enfants béneficaire',
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          style: const TextStyle(),
        ));
  }

  Widget nombreDeJoursAllocationsFamilialesWidget(
      SalaireController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p10, left: p5),
        child: TextFormField(
          controller: controller.nombreDeJoursAllocationsFamilialesController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Nombre des Jours',
            hintText: 'Nombre des Jours',
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          style: const TextStyle(),
        ));
  }

  Widget tauxJoursAllocationsFamilialesWidget(SalaireController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p10, left: p5),
        child: TextFormField(
          controller: controller.tauxJoursAllocationsFamilialesController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Taux journalier',
            hintText: 'Taux journalier',
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          style: const TextStyle(),
        ));
  }

  Widget totalAPayerAllocationsFamilialesWidget(SalaireController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p10, left: p5),
        child: TextFormField(
          controller: controller.totalAPayerAllocationsFamilialesController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Total à payer',
            hintText: 'Total à payer',
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          style: const TextStyle(),
        ));
  }

  Widget netAPayerWidget(SalaireController controller) {
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    return Container(
      padding: const EdgeInsets.only(top: p16, bottom: p16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: mainColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 3,
              child: Text('Net à payer',
                  style: bodyLarge!.copyWith(fontWeight: FontWeight.bold))),
          Expanded(flex: 3, child: netAPayerFieldWidget(controller)),
        ],
      ),
    );
  }

  Widget netAPayerFieldWidget(SalaireController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p10, left: p5),
        child: TextFormField(
          controller: controller.netAPayerController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Total à payer',
            hintText: 'Total à payer',
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          style: const TextStyle(),
        ));
  }

  Widget montantPrisConsiderationCalculCotisationsINSSWidget(
      SalaireController controller) {
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    return Container(
      padding: const EdgeInsets.only(top: p16, bottom: p16),
      decoration: BoxDecoration(
        border: Border(
          // top: BorderSide(width: 1.0),
          bottom: BorderSide(width: 1.0, color: mainColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 3,
              child: Text(
                  'Montant pris en consideration pour le calcul des cotisations INSS',
                  style: bodyLarge!.copyWith(fontWeight: FontWeight.bold))),
          Expanded(
              flex: 3,
              child: montantPrisConsiderationCalculCotisationsINSSFieldWidget(
                  controller)),
        ],
      ),
    );
  }

  Widget montantPrisConsiderationCalculCotisationsINSSFieldWidget(
      SalaireController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p10, left: p5),
        child: TextFormField(
          controller: controller
              .montantPrisConsiderationCalculCotisationsINSSController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Montant pris pour la Cotisations INSS',
            hintText: 'Montant pris pour la Cotisations INSS',
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          style: const TextStyle(),
        ));
  }
}
