class RapportModel {
  late int? id;
  late String nom;
  late String numeroTache;
  late String rapport;
  late String signature;
  late DateTime created;
  late int reference;
  late String readRapport; // Notifie au chef d'un nouveau rapport
  late String signatureResp;

  RapportModel(
      {this.id,
      required this.nom,
      required this.numeroTache,
      required this.rapport,
      required this.signature,
      required this.created,
      required this.reference,
      required this.readRapport,
      required this.signatureResp});

  factory RapportModel.fromSQL(List<dynamic> row) {
    return RapportModel(
        id: row[0],
        nom: row[1],
        numeroTache: row[2],
        rapport: row[3],
        signature: row[4],
        created: row[5],
        reference: row[6],
        readRapport: row[7],
        signatureResp: row[8]);
  }

  factory RapportModel.fromJson(Map<String, dynamic> json) {
    return RapportModel(
        id: json['id'],
        nom: json['nom'],
        numeroTache: json['numeroTache'],
        rapport: json['rapport'],
        signature: json['signature'],
        created: DateTime.parse(json['created']),
        reference: json['reference'],
        readRapport: json['readRapport'],
        signatureResp: json['signatureResp']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'numeroTache': numeroTache,
      'rapport': rapport,
      'signature': signature,
      'created': created.toIso8601String(),
      'reference': reference,
      'readRapport': readRapport,
      'signatureResp': signatureResp
    };
  }
}
