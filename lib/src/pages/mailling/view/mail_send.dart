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

class MailSend extends StatefulWidget {
  const MailSend({super.key});

  @override
  State<MailSend> createState() => _MailSendState();
}

class _MailSendState extends State<MailSend> {
  final MaillingController controller = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Mails";
  String subTitle = "Mail envoyés";

  @override
  Widget build(BuildContext context) {
    return controller.obx(
        onLoading: loadingPage(context),
        onEmpty: const Text('Aucune donnée'),
        onError: (error) => loadingError(context, error!),
        (state) => Scaffold(
              key: scaffoldKey,
              appBar: headerBar(context, scaffoldKey, title, subTitle),
              drawer: const MailsNAv(),
              floatingActionButton: FloatingActionButton.extended(
                  label: Row(
                    children: const [
                      Icon(Icons.add),
                      SizedBox(width: p20),
                      Text("Nouveau mail")
                    ],
                  ),
                  onPressed: () {
                    Get.toNamed(MailRoutes.addMail);
                  }),
              body: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                      visible: !Responsive.isMobile(context),
                      child: const Expanded(flex: 1, child: MailsNAv())),
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
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount:
                                              controller.mailSendList.length,
                                          itemBuilder: (context, index) {
                                            final mail =
                                                controller.mailSendList[index];
                                            final color = _lightColors[index];
                                            return pageWidget(mail, color);
                                          })),
                                )
                              ],
                            ),
                          )))
                ],
              ),
            ));
  }

  Widget pageWidget(MailModel mail, Color color) {
    // var ccList = jsonDecode(mail.cc);

    return InkWell(
      onTap: () async {
        Get.toNamed(MailRoutes.mailDetail,
            arguments: MailColor(mail: mail, color: color));
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
}
