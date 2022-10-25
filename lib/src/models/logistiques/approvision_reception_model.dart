class ApprovisionReceptionModel {
  late int? id;
  late String provision; 
  late String departement;
  late String quantity;
  late String unite;
  late String signatureLivraison;
  late DateTime created;
  late String accuseReception;  // True ou False
  late String signatureReception;
  late DateTime createdReception;


  ApprovisionReceptionModel({
    this.id, 
    required this.provision,
    required this.departement,  
    required this.quantity, 
    required this.unite, 
    required this.signatureLivraison, 
    required this.created,
    required this.accuseReception,
    required this.signatureReception,
    required this.createdReception
    });

  factory ApprovisionReceptionModel.fromSQL(List<dynamic> row) {
    return ApprovisionReceptionModel(
      id: row[0],
      provision: row[1],
      departement: row[1],
      quantity: row[2],
      unite: row[3],
      signatureLivraison: row[4],
      created: row[5],
      accuseReception: row[6],
      signatureReception: row[7],
      createdReception: row[8] 
    );
  }

  factory ApprovisionReceptionModel.fromJson(Map<String, dynamic> json) {
    return ApprovisionReceptionModel(
      id: json['id'],
      provision: json['provision'], 
      departement: json['departement'],
      quantity: json['quantity'],
      unite: json['unite'], 
      signatureLivraison: json["signatureLivraison"], 
      created: DateTime.parse(json['created']),
      accuseReception: json["accuseReception"],
      signatureReception: json["signatureReception"],
      createdReception: DateTime.parse(json['createdReception']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'provision': provision, 
      'departement': departement,
      'quantity': quantity,
      'unite': unite,
      'signatureLivraison': signatureLivraison,  
      'created': created.toIso8601String(),
      'accuseReception': accuseReception,  
      'signatureReception': signatureReception,
      'createdReception': createdReception.toIso8601String(),
    };
  }
}
