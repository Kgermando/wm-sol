class SuiviModel {
  late int? id;
  late int refence;
  late String travailEffectue;
  late String accuseeReception;
  late String signature;
  late DateTime created;


  SuiviModel(
     {this.id,
      required this.refence,
      required this.travailEffectue,
      required this.accuseeReception,
      required this.signature,
      required this.created
    }
  );

  
  factory SuiviModel.fromSQL(List<dynamic> row) {
    return SuiviModel(
     id: row[0],
      refence: row[1],
      travailEffectue: row[2],
      accuseeReception: row[3],
      signature: row[4],
      created: row[5]
    );
  }
  
  factory SuiviModel.fromJson(Map<String, dynamic> json) {
    return SuiviModel(
     id: json['id'],
      refence: json['refence'],
      travailEffectue: json['travailEffectue'],
      accuseeReception: json['accuseeReception'],
      signature: json['signature'],
      created: DateTime.parse(json['created'])
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'refence': refence,
      'travailEffectue': travailEffectue,
      'accuseeReception': accuseeReception,
      'signature': signature,
      'created': created.toIso8601String()
    };
  }
}