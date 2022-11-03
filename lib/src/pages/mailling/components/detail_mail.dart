import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/mail/mail_model.dart';
import 'package:wm_solution/src/navigation/drawer/components/mails_nav.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/mailling/controller/mailling_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class DetailMail extends StatefulWidget {
  const DetailMail({super.key, required this.mailColor});
  final MailColor mailColor;

  @override
  State<DetailMail> createState() => _DetailMailState();
}

class _DetailMailState extends State<DetailMail> {
  final MaillingController controller = Get.put(MaillingController());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Mails";

  @override
  Widget build(BuildContext context) {
    return controller.obx(
        onLoading: loadingPage(context),
        onEmpty: const Text('Aucune donnée'),
        onError: (error) => loadingError(context, error!),
        (state) => Scaffold(
              key: scaffoldKey,
              appBar: headerBar(context, scaffoldKey, title,
                  widget.mailColor.mail.fullNameDest),
              drawer: const MailsNAv(),
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
                              child: pageDetail())))
                ],
              ),
            ));
  }

  Widget pageDetail() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Card(
        // elevation: 10,
        child: Container(
          margin: const EdgeInsets.all(p16),
          width: (Responsive.isDesktop(context))
              ? MediaQuery.of(context).size.width / 1.5
              : double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(p10),
            border: Border.all(
              color: Colors.blueGrey.shade700,
              width: 2.0,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: p20),
              Padding(
                padding: const EdgeInsets.all(p8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SelectableText(
                        timeago.format(widget.mailColor.mail.dateSend,
                            locale: 'fr_short'),
                        textAlign: TextAlign.start),
                    IconButton(
                        onPressed: () {
                          Get.toNamed(MailRoutes.mailRepondre,
                              arguments: widget.mailColor.mail);
                        },
                        tooltip: 'Repondre',
                        icon: const Icon(Icons.reply)),
                    IconButton(
                        onPressed: () {
                          Get.toNamed(MailRoutes.mailTransfert,
                              arguments: widget.mailColor.mail);
                        },
                        tooltip: 'Transferer',
                        icon: const Icon(Icons.redo)),
                    IconButton(
                        onPressed: () {
                          controller.deleteData(widget.mailColor.mail.id!);
                        },
                        tooltip: 'Suypprimer',
                        icon: const Icon(Icons.delete)),
                  ],
                ),
              ),
              dataWidget()
            ],
          ),
        ),
      ),
    ]);
  }

  Widget dataWidget() {
    final headlineSmall = Theme.of(context).textTheme.headlineSmall;
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final bodySmall = Theme.of(context).textTheme.bodySmall;
    final String firstLettter = widget.mailColor.mail.fullNameDest[0];
    // var ccList = jsonDecode(data.cc);
    return Padding(
      padding: const EdgeInsets.all(p10),
      child: Column(
        children: [
          ListTile(
            leading: SizedBox(
              width: 50,
              height: 50,
              child: CircleAvatar(
                backgroundColor: widget.mailColor.color,
                child: AutoSizeText(
                  firstLettter.toUpperCase(),
                  style: headlineSmall!.copyWith(color: Colors.white),
                  maxLines: 1,
                ),
              ),
            ),
            title: AutoSizeText(widget.mailColor.mail.objet,
                style: bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.mailColor.mail.email ==
                    controller.profilController.user.email)
                  Row(children: [
                    AutoSizeText("à".toUpperCase()),
                    const SizedBox(height: p8),
                    const AutoSizeText("moi."),
                  ]),
                SizedBox(
                  width: 500,
                  child: ExpansionTile(
                    title: const Text("Voir plus", textAlign: TextAlign.end),
                    children: [
                      Row(
                        children: [
                          const AutoSizeText("De:"),
                          const SizedBox(width: p10),
                          AutoSizeText(widget.mailColor.mail.emailDest,
                              style: bodySmall),
                          const SizedBox(width: p10),
                          AutoSizeText(widget.mailColor.mail.fullNameDest,
                              style: bodySmall!
                                  .copyWith(fontWeight: FontWeight.w600)),
                        ],
                      ),
                      Row(
                        children: [
                          AutoSizeText("à:".toUpperCase()),
                          const SizedBox(width: p10),
                          AutoSizeText(widget.mailColor.mail.email,
                              style: bodySmall),
                          const SizedBox(width: p10),
                          AutoSizeText(widget.mailColor.mail.fullName,
                              style: bodySmall.copyWith(
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                      const SizedBox(width: p10),
                      Row(
                        children: [
                          const Text("Date:"),
                          const SizedBox(width: p10),
                          SelectableText(
                              DateFormat("dd-MM-yyyy HH:mm")
                                  .format(widget.mailColor.mail.dateSend),
                              style: bodySmall,
                              textAlign: TextAlign.start),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.lock,
                              size: 15.0, color: Colors.green.shade700),
                          const SizedBox(width: p10),
                          Text("Chiffrement Standard (TLS).",
                              style: bodySmall.copyWith(
                                  color: Colors.green.shade700))
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Divider(color: mainColor),
          const SizedBox(height: p20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SelectableText(widget.mailColor.mail.message,
                    textAlign: TextAlign.start, style: bodyMedium),
              ),
            ],
          ),
          const SizedBox(height: p20)
        ],
      ),
    );
  }
}
