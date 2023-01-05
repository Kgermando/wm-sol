import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/taches/tache_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/taches/controller/rapport_controller.dart';
import 'package:wm_solution/src/widgets/btn_widget.dart'; 
import 'package:wm_solution/src/widgets/title_widget.dart'; 

class AddRapport extends StatefulWidget {
  const AddRapport({super.key, required this.tacheModel});
  final TacheModel tacheModel;

  @override
  State<AddRapport> createState() => _AddRapportState();
}

class _AddRapportState extends State<AddRapport> {
  final RapportController controller = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Rapports";
  String subTitle = "Nouveau rapport";

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) { 
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
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        Card(
                          elevation: 3,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: p20),
                            child: Form(
                              key: controller.formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const TitleWidget(title: "Nouveau rapport"),
                                      SelectableText(
                                          DateFormat("Le dd-MM-yyyy").format(
                                              DateTime.now()),
                                          textAlign: TextAlign.start), 
                                    ],
                                  ),
                                  const SizedBox(
                                    height: p30,
                                  ),
                                  quillControllerWidget(), 
                                  // rapportControllerWidget(),
                                  const SizedBox(
                                    height: p20,
                                  ),
                                  BtnWidget(
                                      title: 'Soumettre',
                                      isLoading: controller.isLoading,
                                      press: () {
                                        final form =
                                            controller.formKey.currentState!;
                                        if (form.validate()) {
                                          controller.submit(widget.tacheModel);
                                          form.reset();
                                        }
                                      })
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )))
        ],
      ),
    );
  }

  Widget quillControllerWidget() {
    return Column(
      children: [ 
        QuillToolbar.basic(controller: controller.quillController),
        SizedBox(
          height: MediaQuery.of(context).size.height / 1.5, 
          child: Row(
            children: [ 
              Expanded(
                child: QuillEditor(
                  controller: controller.quillController,
                  readOnly: false, // true for view only mode
                  scrollController: ScrollController(),
                  scrollable: true,
                  focusNode: _focusNode,
                  autoFocus: false,
                  placeholder: 'Ecrire votre rapport ici...', 
                  expands: true,
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  // Widget rapportControllerWidget() {
  //   return Container(
  //       margin: const EdgeInsets.only(bottom: p20),
  //       child: TextFormField(
  //         controller: controller.rapportController,
  //         keyboardType: TextInputType.multiline,
  //         minLines: 5,
  //         maxLines: 50,
  //         decoration: InputDecoration(
  //           border:
  //               OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
  //           labelText: 'Ecrivez votre rapport ici...',
  //         ),
  //         style: const TextStyle(),
  //         validator: (value) {
  //           if (value != null && value.isEmpty) {
  //             return 'Ce champs est obligatoire';
  //           } else {
  //             return null;
  //           }
  //         },
  //       ));
  // }
}
