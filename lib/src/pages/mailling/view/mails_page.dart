import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/mail/mail_model.dart';
import 'package:wm_solution/src/navigation/drawer/components/mails_nav.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/mailling/components/list_mails.dart';
import 'package:wm_solution/src/pages/mailling/controller/mailling_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/loading.dart';

final _lightColors = [
  Colors.pinkAccent.shade700,
  Colors.tealAccent.shade700,
  mainColor,
  Colors.lightGreen.shade700,
  Colors.lightBlue.shade700,
  Colors.orange.shade700,
  Colors.brown.shade700,
  Colors.grey.shade700,
  Colors.blueGrey.shade700,
];

class MailPages extends StatefulWidget {
  const MailPages({Key? key}) : super(key: key);

  @override
  State<MailPages> createState() => _MailPagesState();
}

class _MailPagesState extends State<MailPages> {
  final MaillingController controller = Get.put(MaillingController());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Mails";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: controller.obx(
          onLoading: loadingPage(context),
          onEmpty: const Text('Aucune donnée'),
          onError: (error) => loadingError(context, error!),
          (data) => Scaffold(
              key: scaffoldKey,
              appBar: headerBar(context, scaffoldKey, title, ''),
              drawer: const MailsNAv(),
              floatingActionButton: FloatingActionButton.extended(
                  icon: const Icon(Icons.add),
                  label: const Text("Nouveau mail"),
                  onPressed: () {
                    Get.toNamed(MailRoutes.addMail);
                  }),
              body: Row(
                children: [
                  Visibility(
                      visible: !Responsive.isMobile(context),
                      child: const Expanded(flex: 1, child: MailsNAv())),
                  Expanded(
                      flex: 5,
                      child: Container(
                          margin: const EdgeInsets.only(
                              top: p20, right: p20, left: p20, bottom: p8),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.mailList.length,
                              itemBuilder: (context, index) {
                                final mail = controller.mailList[index];
                                final color = _lightColors[index];
                                return pageWidget(mail, color);
                              }))),
                ],
              ))),
    );
  }

  Widget pageWidget(MailModel mail, Color color) {
    return InkWell(
      onTap: () {
        controller.readMail(mail, color);
      },
      child: Padding(
        padding: const EdgeInsets.all(p10),
        child: ListMails(
            fullName: mail.fullName,
            email: mail.email,
            // cc: ccList,
            objet: mail.objet,
            read: mail.read,
            dateSend: mail.dateSend,
            color: color),
      ),
    );
  }

  Widget alertWidget() {
    final headline6 = Theme.of(context).textTheme.headline6;
    // Duration isDuration = const Duration(minutes: 1);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("En attente d'une connexion API sécurisée ...",
              style: headline6),
          // const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
