
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:file_picker/file_picker.dart'; 
import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/components/mails_nav.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';  
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/mailling/controller/mailling_controller.dart';
import 'package:wm_solution/src/utils/regex.dart';
import 'package:wm_solution/src/widgets/btn_widget.dart';  
import 'package:wm_solution/src/widgets/title_widget.dart'; 

class NewMail extends StatefulWidget {
  const NewMail({Key? key}) : super(key: key);

  @override
  State<NewMail> createState() => _NewMailState();
}

class _NewMailState extends State<NewMail> {
  final MaillingController controller = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Mails";
  String subTitle = "Nouveau mail";

  final ScrollController controllerScrollCC = ScrollController();
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: headerBar(context, scaffoldKey, title, subTitle),
      drawer: const MailNav(), 
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
                visible: !Responsive.isMobile(context),
                child: const Expanded(flex: 1, child: DrawerMenu())),
            Visibility(
                visible: !Responsive.isMobile(context),
                child: const Expanded(flex: 1, child: MailNav())),
          Expanded(
              flex: 3,
              child: SingleChildScrollView(
                  controller: ScrollController(),
                  physics: const ScrollPhysics(),
                  child: Container(
                    margin: const EdgeInsets.only(
                        top: p20, bottom: p8, right: p20, left: p20),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: p20),
                        child: Form(
                          key: controller.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TitleWidget(title: "Nouveau mail"),
                              const SizedBox(
                                height: p20,
                              ),
                              emailWidget(),
                              // ccWidget(),
                              const SizedBox(height: p20),
                              objetWidget(),
                              ccWidget(),
                              messageWidget(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  fichierWidget(),
                                ],
                              ),
                              const SizedBox(
                                height: p20,
                              ),
                              Obx(() => BtnWidget(
                                  title: 'Envoyez',
                                  isLoading: controller.isLoading,
                                  press: () {
                                    final form =
                                        controller.formKey.currentState!;
                                    if (form.validate()) {
                                      controller.send();
                                      form.reset();
                                    }
                                  }))  
                            ],
                          ),
                        ),
                      ),
                    ),
                  )))
        ],
      ));
  }
 

  Widget emailWidget() { 
    List<String> suggestionList = controller.mailList
        .map((e) => e.email).toSet().toList();
    return Container(
      margin: const EdgeInsets.only(bottom: p20),
      child:  EasyAutocomplete(
        // controller: controller.emailController,
        decoration: InputDecoration(
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          labelText: "Email",
        ),
        keyboardType: TextInputType.emailAddress,
        suggestions: suggestionList,
        validator: (value) => RegExpIsValide().validateEmail(value),
        onChanged: (value) {
            controller.emailController = value;
          },
      ) );
  }

  Widget ccWidget() {
    return Material(
      color: Colors.amber.shade50,
      child: ExpansionTile(
        leading: const Icon(Icons.person),
        title: const Text('Cc'),
        subtitle: SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          height: 20,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.ccList.length,
              itemBuilder: (BuildContext context, index) {
                final agent = controller.ccList[index];
                return Text("${agent.email}; ");
              }),
        ),
        onExpansionChanged: (val) {
          setState(() {
            isOpen = !val;
          });
        },
      trailing: const Icon(Icons.arrow_drop_down),
      children: [
        SizedBox(
          height: 100,
          child: Scrollbar(
              controller: controllerScrollCC,
              trackVisibility: true,
              thumbVisibility: true,
              child: ListView.builder(
              itemCount: controller.usersController.usersList.length,
              controller: controllerScrollCC,
              itemBuilder: (context, i) {
                var user = controller.usersController.usersList[i];
                return ListTile(
                    title: Text(user.email),
                    leading: Checkbox(
                      value: controller.ccList.contains(user),
                      onChanged: (val) {
                        if (val == true) {
                          setState(() {
                            controller.ccList.add(user);
                          });
                        } else {
                          setState(() {
                            controller.ccList.remove(user);
                          });
                        }
                      },
                    ));
                  }),
            ),
          )
        ],
      ),
    );
  }

  Widget objetWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.objetController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: "Objet",
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

  Widget messageWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: TextFormField(
          controller: controller.messageController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: "Ecrivez mail ...",
            helperText: "Ecrivez mail ...",
          ),
          keyboardType: TextInputType.multiline,
          minLines: 10,
          maxLines: 20,
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

  Widget fichierWidget() {
    return Container(
        margin: const EdgeInsets.only(bottom: p20),
        child: Obx(() => controller.isUploading
            ? const SizedBox(height: 50.0, width: 50.0, child: LinearProgressIndicator())
            : TextButton.icon(
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: [
                      'pdf',
                      'doc',
                      'docx',
                      'xlsx',
                      'pptx',
                      'jpg',
                      'png'
                    ],
                  );
                  if (result != null) {
                    controller.uploadFile(result.files.single.path!);
                  } else {
                    const Text("Votre fichier n'existe pas");
                  }
                },
                icon: controller.isUploadingDone
                    ? Icon(Icons.check_circle_outline,
                        color: Colors.green.shade700)
                    : const Icon(Icons.attach_email),
                label: controller.isUploadingDone
                    ? Text("Téléchargement terminé",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.green.shade700))
                    : Text("Pièce jointe",
                        style: Theme.of(context).textTheme.bodyLarge)) ));
  }
}
