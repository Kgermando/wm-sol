class JournalLivreModel {
  late int? id;
  late String intitule;
  late DateTime debut;
  late DateTime fin;
  late String isSubmit;

  late String signature;
  late DateTime created;
  // Approbations DD
  late String approbationDD;
  late String motifDD;
  late String signatureDD;

  JournalLivreModel(
      {this.id,
      required this.intitule,
      required this.debut,
      required this.fin,
      required this.isSubmit,
      required this.signature,
      required this.created,
      required this.approbationDD,
      required this.motifDD,
      required this.signatureDD});

  factory JournalLivreModel.fromSQL(List<dynamic> row) {
    return JournalLivreModel(
        id: row[0],
        intitule: row[1],
        debut: row[2],
        fin: row[3],
        isSubmit: row[4],
        signature: row[5],
        created: row[6],
        approbationDD: row[7],
        motifDD: row[8],
        signatureDD: row[9]);
  }

  factory JournalLivreModel.fromJson(Map<String, dynamic> json) {
    return JournalLivreModel(
        id: json['id'],
        intitule: json['intitule'],
        debut: DateTime.parse(json['debut']),
        fin: DateTime.parse(json['fin']),
        isSubmit: json['isSubmit'],
        signature: json['signature'],
        created: DateTime.parse(json['created']),
        approbationDD: json['approbationDD'],
        motifDD: json['motifDD'],
        signatureDD: json['signatureDD']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'intitule': intitule,
      'debut': debut.toIso8601String(),
      'fin': fin.toIso8601String(),
      'isSubmit': isSubmit,
      'signature': signature,
      'created': created.toIso8601String(),
      'approbationDD': approbationDD,
      'motifDD': motifDD,
      'signatureDD': signatureDD
    };
  }
}
