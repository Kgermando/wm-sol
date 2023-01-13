class SuiviModel {
  late int? id;
  late String nomSocial; // Nom de l'entreprise
  late String travailEffectue;
  late String accuseeReception;
  late String signature;
  late DateTime created;
  late DateTime createdDay;

  SuiviModel(
      {this.id,
      required this.nomSocial,
      required this.travailEffectue,
      required this.accuseeReception,
      required this.signature,
      required this.created,
      required this.createdDay});

      
  factory SuiviModel.fromSQL(List<dynamic> row) {
    return SuiviModel(
      id: row[0],
      nomSocial: row[1],
      travailEffectue: row[2],
      accuseeReception: row[3],
      signature: row[4],
      created: row[5],
        createdDay: row[6]
    );
  }

  factory SuiviModel.fromJson(Map<String, dynamic> json) {
    return SuiviModel(
      id: json['id'],
      nomSocial: json['nomSocial'],
      travailEffectue: json['travailEffectue'],
      accuseeReception: json['accuseeReception'],
      signature: json['signature'],
      created: DateTime.parse(json['created']),
      createdDay: DateTime.parse(json['createdDay']),);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nomSocial': nomSocial,
      'travailEffectue': travailEffectue,
      'accuseeReception': accuseeReception,
      'signature': signature,
      'created': created.toIso8601String(),
      'createdDay': createdDay.toIso8601String()
    };
  }
}
