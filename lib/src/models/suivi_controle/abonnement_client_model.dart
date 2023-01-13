class AbonnementClientModel {
  late int? id;
  late int reference;
  late DateTime dateFinContrat;
  late String typeContrat; // Abonnement // Achat Licence
  late String montant; // Montant du contrat
  late String dateDebutEtFinContrat; // Date et de fin du contrat
  late String
      signataireContrat; // Personne qui signé le contrat pour l'entreprise
  late String signature;
  late DateTime created;
  late String nomSocial;
 
  AbonnementClientModel(
      {this.id,
      required this.reference,
      required this.dateFinContrat,
      required this.typeContrat,
      required this.montant,
      required this.dateDebutEtFinContrat,
      required this.signataireContrat,
      required this.signature,
      required this.created,
      required this.nomSocial});

  factory AbonnementClientModel.fromSQL(List<dynamic> row) {
    return AbonnementClientModel(
      id: row[0],
      reference: row[1],
      dateFinContrat: row[2],
      typeContrat: row[3],
      montant: row[4],
      dateDebutEtFinContrat: row[5],
      signataireContrat: row[6],
      signature: row[7],
      created: row[8],
      nomSocial: row[9]
    );
  }

  factory AbonnementClientModel.fromJson(Map<String, dynamic> json) {
    return AbonnementClientModel(
      id: json['id'],
      reference: json['reference'],
      dateFinContrat: DateTime.parse(json['dateFinContrat']),
      typeContrat: json['typeContrat'],
      montant: json['montant'],
      dateDebutEtFinContrat: json['dateDebutEtFinContrat'],
      signataireContrat: json['signataireContrat'],
      signature: json['signature'],
      created: DateTime.parse(json['created']),
      nomSocial: json['nomSocial'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reference': reference,
      'dateFinContrat': dateFinContrat.toIso8601String(),
      'typeContrat': typeContrat,
      'montant': montant,
      'dateDebutEtFinContrat': dateDebutEtFinContrat,
      'signataireContrat': signataireContrat,
      'signature': signature,
      'created': created.toIso8601String(),
      'nomSocial': nomSocial
    };
  }
}
