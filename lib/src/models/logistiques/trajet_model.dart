class TrajetModel {
  late int? id;
  late String nomeroEntreprise;
  late String conducteur;
  late String trajetDe;
  late String trajetA;
  late String mission;
  late String kilometrageSorite;
  late String kilometrageRetour;
  late String signature; // celui qui fait le document
  late int reference;
  late DateTime created; 
  // Approbations DD
  late String approbationDD;
  late String motifDD;
  late String signatureDD;


  TrajetModel(
      {this.id,
      required this.nomeroEntreprise,
      required this.conducteur,
      required this.trajetDe,
      required this.trajetA,
      required this.mission,
      required this.kilometrageSorite,
      required this.kilometrageRetour, 
      required this.signature,
      required this.reference,
      required this.created, 
      required this.approbationDD,
      required this.motifDD,
      required this.signatureDD
  });

  factory TrajetModel.fromSQL(List<dynamic> row) {
    return TrajetModel(
        id: row[0],
        nomeroEntreprise: row[1],
        conducteur: row[2],
        trajetDe: row[3],
        trajetA: row[4],
        mission: row[5],
        kilometrageSorite: row[6],
        kilometrageRetour: row[7], 
        signature: row[8],
        reference: row[9],
        created: row[10], 
        approbationDD: row[11],
        motifDD: row[12],
        signatureDD: row[13]
        
    );
  }

  factory TrajetModel.fromJson(Map<String, dynamic> json) {
    return TrajetModel(
        id: json['id'],
        nomeroEntreprise: json['nomeroEntreprise'],
        conducteur: json['conducteur'],
        trajetDe: json['trajetDe'],
        trajetA: json['trajetA'],
        mission: json['mission'],
        kilometrageSorite: json['kilometrageSorite'],
        kilometrageRetour: json['kilometrageRetour'],
        signature: json['signature'],
        reference: json['reference'],
        created: DateTime.parse(json['created']),
        approbationDD: json['approbationDD'],
        motifDD: json['motifDD'],
        signatureDD: json['signatureDD']
      );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nomeroEntreprise': nomeroEntreprise,
      'conducteur': conducteur,
      'trajetDe': trajetDe,
      'trajetA': trajetA,
      'mission': mission,
      'kilometrageSorite': kilometrageSorite,
      'kilometrageRetour': kilometrageRetour,
      'signature': signature,
      'reference': reference,
      'created': created.toIso8601String(), 
      'approbationDD': approbationDD,
      'motifDD': motifDD,
      'signatureDD': signatureDD
    };
  }
}
