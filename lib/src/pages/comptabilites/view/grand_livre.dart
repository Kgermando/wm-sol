import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/comptabilites/grand_livre_model.dart';
import 'package:wm_solution/src/models/comptabilites/journal_livre_model.dart';
import 'package:wm_solution/src/models/comptabilites/journal_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/journals/journal_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/journals/journal_livre_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';


class GrandLivre extends StatefulWidget {
  const GrandLivre({super.key});

  @override
  State<GrandLivre> createState() => _GrandLivreState();
}

class _GrandLivreState extends State<GrandLivre> {
  
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Comptabilités";
  String subTitle = "grand livre";


  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  JournalLivreModel? reference;
  // int? reference;
  TextEditingController compteController = TextEditingController();

  @override
  void dispose() {
    compteController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final JournalLivreController controller = Get.put(JournalLivreController());
    final JournalController journalController = Get.put(JournalController());
    return SafeArea(
      child: controller.obx(
    onLoading: loading(),
    onEmpty: const Text('Aucune donnée'),
    onError: (error) => Text(
        "Une erreur s'est produite $error veiller actualiser votre logiciel. Merçi."),
    (data) => Scaffold(
        key: scaffoldKey,
        appBar: headerBar(context, scaffoldKey, title, subTitle),
        drawer: const DrawerMenu(),
        body: Row(
          children: [
            Visibility(
                visible: !Responsive.isMobile(context),
                child: const Expanded(flex: 1, child: DrawerMenu())),
            Expanded(
                flex: 5,
                child: Container(
                    margin: const EdgeInsets.only(
                        top: p20, right: p20, left: p20, bottom: p8),
                    decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(20))),
                    child: pageView(journalController.journalList, controller)
                )
            ),
          ],
        ))),
    );
  }


  Widget pageView(List<JournalModel> data, JournalLivreController controller) {
    return Container( 
      padding: const EdgeInsets.all(p20),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    color: Colors.green,
                    tooltip: "Actualiser la page",
                    onPressed: () {
                      Navigator.pushNamed(
                          context, ComptabiliteRoutes.comptabiliteGrandLivre);
                    },
                    icon: const Icon(Icons.refresh)),
              ],
            ),
            const SizedBox(height: p10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.book, size: p50, color: Colors.red),
                        TitleWidget(title: "Grand Livre"),
                      ],
                    ),
                    const SizedBox(height: p20),
                    Responsive.isMobile(context)
                        ? Column(children: [
                            compteWidget(data),
                            livreWidget(controller),
                            buttonWidget(data)
                          ])
                        : Row(children: [
                            SizedBox(width: 300.0, child: compteWidget(data)),
                            const SizedBox(width: p10),
                            SizedBox(width: 250.0, child: livreWidget(controller)),
                            const SizedBox(width: p10),
                            SizedBox(
                                width: 150.0,
                                height: 70,
                                child: buttonWidget(data))
                          ]),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget livreWidget(JournalLivreController controller) {
    return Container(
      margin: const EdgeInsets.only(bottom: p20),
      child: DropdownButtonFormField<JournalLivreModel>(
        decoration: InputDecoration(
          labelText: 'Livre',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: reference,
        isExpanded: true,
        items: controller.journalLivreList
            .map((JournalLivreModel? value) {
              return DropdownMenuItem<JournalLivreModel>(
                value: value,
                child: Text(value!.intitule),
              );
            })
            .toSet()
            .toList(),
        validator: (value) => value == null ? "Select Livre" : null,
        onChanged: (value) {
          setState(() {
            reference = value;
          });
        },
      ),
    );
  }

  Widget compteWidget(List<JournalModel> data) {
    List<String> suggestionList = data.map((e) => e.compte).toList();
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: EasyAutocomplete(
          controller: compteController,
          decoration: InputDecoration(
            labelText: 'Compte',
            labelStyle: const TextStyle(),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
            contentPadding: const EdgeInsets.only(left: 5.0),
          ),
          keyboardType: TextInputType.text,
          suggestions: suggestionList,
          validator: (value) {
            if (value != null && value.isEmpty) {
              return 'Ce champs est obligatoire';
            } else {
              return null;
            }
          },
        ));
  }

  Widget buttonWidget(List<JournalModel> data) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return Container(
      margin: const EdgeInsets.only(bottom: p20),
      child: ElevatedButton.icon(
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(40),
          ),
          onPressed: () {
            final form = formKey.currentState!;
            if (form.validate()) {
              searchKey(data);
              form.reset();
            }
          },
          icon: const Icon(Icons.search, color: Colors.white),
          label: Text("Recherche",
              style: bodyMedium!.copyWith(color: Colors.white))),
    );
  }

  void searchKey(List<JournalModel> data) {
    final livre = GrandLivreModel(
        reference: reference!.id!, compte: compteController.text);
    final search = data
        .where((element) =>
            element.compte == livre.compte &&
                element.reference == livre.reference ||
            element.compte == compteController.text)
        .toList();
    Get.toNamed(ComptabiliteRoutes.comptabiliteGrandLivreSearch, arguments: search);
  }
}