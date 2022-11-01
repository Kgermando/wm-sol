import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/comptabilites/components/journals/table_journal_livre.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/journals/journal_livre_controller.dart';
import 'package:wm_solution/src/widgets/button_widget.dart';
import 'package:wm_solution/src/widgets/loading.dart';

class JournalLivreComptabilite extends StatefulWidget {
  const JournalLivreComptabilite({super.key});

  @override
  State<JournalLivreComptabilite> createState() =>
      _JournalLivreComptabiliteState();
}

class _JournalLivreComptabiliteState extends State<JournalLivreComptabilite> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Comptabilités";
  String subTitle = "journal";

  @override
  Widget build(BuildContext context) {
    final JournalLivreController controller = Get.put(JournalLivreController());
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
              floatingActionButton: FloatingActionButton.extended(
                  label: const Text("Feuille journal"),
                  tooltip: "Nouveau Journal",
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    newjournalDialog(controller);
                  }),
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
                          child: TableJournalLivre(
                              journalLivreList: controller.journalLivreList,
                              controller: controller))),
                ],
              ))),
    );
  }

  newjournalDialog(JournalLivreController controller) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (dialogContext) { 
          bool isLoading = false;
          String getPlageDate() {
            if (controller.dateRange == null) {
              return 'Date de Debut et Fin';
            } else {
              return '${DateFormat('dd/MM/yyyy').format(controller.dateRange!.start)} - ${DateFormat('dd/MM/yyyy').format(controller.dateRange!.end)}';
            }
          }

          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              title: Text('New document', style: TextStyle(color: mainColor)),
              content: SizedBox(
                  height: 200,
                  width: 300,
                  child: isLoading
                      ? loading()
                      : Form(
                          key: controller.formKey,
                          child: Column(
                            children: [
                              intituleWidget(controller),
                              Container(
                                margin: const EdgeInsets.only(bottom: p20),
                                child: ButtonWidget(
                                  text: getPlageDate(),
                                  onClicked: () => setState(() {
                                    pickDateRange(context, controller);
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                  }),
                                ),
                              )
                            ],
                          ))),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Annuler'),
                ),
                TextButton(
                  onPressed: () {
                    isLoading = true;
                    final form = controller.formKey.currentState!;
                    if (form.validate()) {
                      controller.submit();
                      form.reset();
                    }
                    Navigator.pop(context, 'ok');
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          });
        });
  }

  Widget intituleWidget(JournalLivreController controller) {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.intituleController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Libelé',
            contentPadding:
                const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
          ),
          keyboardType: TextInputType.text,
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

  Future pickDateRange(
      BuildContext context, JournalLivreController controller) async {
    final initialDateRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now().add(const Duration(hours: 24 * 3)),
    );
    final newDateRange = await showDateRangePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.input,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 20),
      initialDateRange: controller.dateRange ?? initialDateRange,
    );

    if (newDateRange == null) return;

    setState(() => controller.dateRange = newDateRange);
  }
}
