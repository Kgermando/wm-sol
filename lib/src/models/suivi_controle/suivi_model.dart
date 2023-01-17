class SuiviModel {
  late int? id;
  late String nomSocial; // Nom de l'entreprise
  late String travailEffectue; // constat seur le travail
  late String accuseeReception;
  late String signature;
  late DateTime created;
  late DateTime createdDay; // Date du SfCalendar
  late String background; // Effectuer, Interrompu, Non Effectuer
  late String eventName; // Effectuer, Interrompu, Non Effectuer

  SuiviModel(
      {this.id,
      required this.nomSocial,
      required this.travailEffectue,
      required this.accuseeReception,
      required this.signature,
      required this.created,
      required this.createdDay,
      required this.background,
      required this.eventName});

  factory SuiviModel.fromSQL(List<dynamic> row) {
    return SuiviModel(
        id: row[0],
        nomSocial: row[1],
        travailEffectue: row[2],
        accuseeReception: row[3],
        signature: row[4],
        created: row[5],
        createdDay: row[6],
        background: row[7],
        eventName: row[8]);
  }

  factory SuiviModel.fromJson(Map<String, dynamic> json) {
    return SuiviModel(
        id: json['id'],
        nomSocial: json['nomSocial'],
        travailEffectue: json['travailEffectue'],
        accuseeReception: json['accuseeReception'],
        signature: json['signature'],
        created: DateTime.parse(json['created']),
        createdDay: DateTime.parse(json['createdDay']),
        background: json['background'],
        eventName: json['eventName']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nomSocial': nomSocial,
      'travailEffectue': travailEffectue,
      'accuseeReception': accuseeReception,
      'signature': signature,
      'created': created.toIso8601String(),
      'createdDay': createdDay.toIso8601String(),
      'background': background,
      'eventName': eventName
    };
  }
}
