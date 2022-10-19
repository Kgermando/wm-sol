import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/commercial_marketing/controller/marketing/agenda/agenda_controller.dart'; 
import 'package:wm_solution/src/widgets/btn_widget.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/models/comm_maketing/agenda_model.dart'; 


class UpdateAgenda extends StatefulWidget {
  const UpdateAgenda({super.key, required this.agendaColor});
  final AgendaColor agendaColor;

  @override
  State<UpdateAgenda> createState() => _UpdateAgendaState();
}

class _UpdateAgendaState extends State<UpdateAgenda> {
  final AgendaController controller = Get.put(AgendaController());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Ressources Humaines";

  @override
  void initState() {
    setState(() {
      controller.titleController =
          TextEditingController(text: widget.agendaColor.agendaModel.title);
      controller.descriptionController = TextEditingController(
          text: widget.agendaColor.agendaModel.description);
      controller.dateRappelController = TextEditingController(
          text: widget.agendaColor.agendaModel.dateRappel.toIso8601String());
    });
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {  
    return controller.obx(
        onLoading: loading(),
        onEmpty: const Text('Aucune donnée'),
        onError: (error) => Text(
            "Une erreur s'est produite $error veiller actualiser votre logiciel. Merçi."),
        (state) => Scaffold(
          key: scaffoldKey,
          appBar: headerBar(
              context, scaffoldKey, title, widget.agendaColor.agendaModel.title),
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
                                   dateRappelWidget(),
                                    const SizedBox(height: p8),
                                    buildTitle(),
                                    const SizedBox(height: p8),
                                    buildDescription(),
                                    const SizedBox(
                                      height: p20,
                                    ),
                                    BtnWidget(
                                      title: 'Soumettre',
                                      isLoading: controller.isLoading,
                                      press: () {
                                        final form =
                                            controller
                                                .formKey.currentState!;
                                        if (form.validate()) {
                                          controller.submit();
                                          form.reset();
                                        }
                                      })
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

   Widget dateRappelWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: DateTimePicker(
          initialEntryMode: DatePickerEntryMode.input,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.date_range),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Rappel',
          ),
          controller: controller.dateRappelController,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          validator: (value) {
            if (value != null && value.isEmpty) {
              return 'Ce champs est obligatoire';
            } else {
              return null;
            }
          },
        ));
  }

  Widget buildTitle() {
    final bodyText1 = Theme.of(context).textTheme.bodyText1;
    return TextFormField(
      maxLines: 1,
      style: bodyText1,
      controller: controller.titleController,
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        hintText: 'Objet...',
      ),
      validator: (value) {
        if (value != null && value.isEmpty) {
          return 'Ce champs est obligatoire';
        } else {
          return null;
        }
      },
    );
  }

  Widget buildDescription() {
    final bodyText2 = Theme.of(context).textTheme.bodyText2;
    return TextFormField(
      maxLines: 10,
      style: bodyText2,
      controller: controller.descriptionController,
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        hintText: 'Ecrivez quelque chose...',
        // hintStyle: TextStyle(color: Colors.black54),
      ),
      validator: (value) {
        if (value != null && value.isEmpty) {
          return 'Ce champs est obligatoire';
        } else {
          return null;
        }
      },
    );
  }
}
