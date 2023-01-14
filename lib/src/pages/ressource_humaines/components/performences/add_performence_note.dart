import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/rh/perfomence_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/performences/performence_note_controller.dart';
import 'package:wm_solution/src/widgets/btn_widget.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/responsive_child3_widget.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

class AddPerformenceNote extends StatefulWidget {
  const AddPerformenceNote({super.key, required this.performenceModel});
  final PerformenceModel performenceModel;

  @override
  State<AddPerformenceNote> createState() => _AddPerformenceNoteState();
}

class _AddPerformenceNoteState extends State<AddPerformenceNote> {
  final PerformenceNoteController controllerNote = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Ressources Humaines";

  @override
  Widget build(BuildContext context) {
    
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: headerBar(context, scaffoldKey, title,
            "${widget.performenceModel.prenom} ${widget.performenceModel.nom}"),
        drawer: const DrawerMenu(),
        body: controllerNote.obx(
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
                          child: Form(
                            key: controllerNote.formKey,
                            child: Column(
                              children: [
                                const TitleWidget(title: "Ajout performence"),
                                const SizedBox(
                                  height: p20,
                                ),
                                ResponsiveChildWidget(
                                    flex1: 1,
                                    flex2: 3,
                                    child1: Text('Nom :',
                                        textAlign: TextAlign.start,
                                        style: bodyMedium!.copyWith(
                                            fontWeight: FontWeight.bold)),
                                    child2: SelectableText(
                                        widget.performenceModel.nom,
                                        textAlign: TextAlign.start,
                                        style: bodyMedium)),
                                Divider(
                                  color: mainColor,
                                ),
                                ResponsiveChildWidget(
                                    flex1: 1,
                                    flex2: 3,
                                    child1: Text('Post-Nom :',
                                        textAlign: TextAlign.start,
                                        style: bodyMedium.copyWith(
                                            fontWeight: FontWeight.bold)),
                                    child2: SelectableText(
                                        widget.performenceModel.postnom,
                                        textAlign: TextAlign.start,
                                        style: bodyMedium)),
                                Divider(
                                  color: mainColor,
                                ),
                                ResponsiveChildWidget(
                                    flex1: 1,
                                    flex2: 3,
                                    child1: Text('Prénom :',
                                        textAlign: TextAlign.start,
                                        style: bodyMedium.copyWith(
                                            fontWeight: FontWeight.bold)),
                                    child2: SelectableText(
                                        widget.performenceModel.prenom,
                                        textAlign: TextAlign.start,
                                        style: bodyMedium)),
                                Divider(
                                  color: mainColor,
                                ),
                                ResponsiveChildWidget(
                                    flex1: 1,
                                    flex2: 3,
                                    child1: Text('Matricule :',
                                        textAlign: TextAlign.start,
                                        style: bodyMedium.copyWith(
                                            fontWeight: FontWeight.bold)),
                                    child2: SelectableText(
                                        widget.performenceModel.agent,
                                        textAlign: TextAlign.start,
                                        style: bodyMedium)),
                                Divider(
                                  color: mainColor,
                                ),
                                ResponsiveChildWidget(
                                    flex1: 1,
                                    flex2: 3,
                                    child1: Text('Département :',
                                        textAlign: TextAlign.start,
                                        style: bodyMedium.copyWith(
                                            fontWeight: FontWeight.bold)),
                                    child2: SelectableText(
                                        widget.performenceModel.departement,
                                        textAlign: TextAlign.start,
                                        style: bodyMedium)),
                                Divider(
                                  color: mainColor,
                                ),
                                ResponsiveChild3Widget(
                                    flex1: 3,
                                    flex2: 3,
                                    flex3: 3,
                                    child1: hospitaliteWidget(),
                                    child2: ponctualiteWidget(),
                                    child3: travailleWidget()),
                                noteWidget(),
                                const SizedBox(
                                  height: p20,
                                ),
                                Obx(() => BtnWidget(
                                    title: 'Soumettre',
                                    isLoading: controllerNote.isLoading,
                                    press: () {
                                      final form =
                                          controllerNote.formKey.currentState!;
                                      if (form.validate()) {
                                        controllerNote
                                            .submit(widget.performenceModel);
                                      }
                                      form.reset();
                                    }))  
                              ],
                            ),
                          )),
                    ))
              ],
            ),
          )
      ),
    );
  }

 
  Widget hospitaliteWidget() {
    final headlineMedium = Theme.of(context).textTheme.headlineMedium;
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: TextFormField(
                controller: controllerNote.hospitaliteController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  labelText: 'Hospitalité',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.allow(RegExp(r'^[1-9]$|^10$')),
                ],
                style: const TextStyle(),
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
                child: Text("/10",
                    style:
                        headlineMedium!.copyWith(color: Colors.blue.shade700)))
          ],
        ));
  }

  Widget ponctualiteWidget() {
    final headlineMedium = Theme.of(context).textTheme.headlineMedium;
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: TextFormField(
                controller: controllerNote.ponctualiteController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  labelText: 'Ponctualité',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.allow(RegExp(r'^[1-9]$|^10$')),
                ],
                style: const TextStyle(),
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
                child: Text("/10",
                    style:
                        headlineMedium!.copyWith(color: Colors.green.shade700)))
          ],
        ));
  }

  Widget travailleWidget() {
    final headlineMedium = Theme.of(context).textTheme.headlineMedium;
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: TextFormField(
                controller: controllerNote.travailleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  labelText: 'Travaille',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.allow(RegExp(r'^[1-9]$|^10$')),
                ],
                style: const TextStyle(),
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
                child: Text("/10",
                    style: headlineMedium!
                        .copyWith(color: Colors.purple.shade700)))
          ],
        ));
  }

  Widget noteWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controllerNote.noteController,
          keyboardType: TextInputType.multiline,
          minLines: 3,
          maxLines: 5,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Note',
          ),
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
}
