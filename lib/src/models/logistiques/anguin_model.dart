class AnguinModel {
  late int? id;
  late String modele;
  late String marque;
  late String numeroChassie;
  late String couleur;
  late String genre; // Form viture(voiture, camion, bus, mini-bus...)
  late String qtyMaxReservoir;
  late DateTime dateFabrication;
  late String nomeroPLaque;
  // numero que l'entreprise donne donne a ses anguins
  late String nomeroEntreprise;
  late String kilometrageInitiale;
  late String provenance;
  late String typeCaburant;
  late String typeMoteur;

  late String signature; // celui qui fait le document
  late DateTime created;

  // Approbations DG
  late String approbationDG;
  late String motifDG;
  late String signatureDG;
  // Approbations DD
  late String approbationDD;
  late String motifDD;
  late String signatureDD;

  AnguinModel(
      {this.id,
      required this.modele,
      required this.marque,
      required this.numeroChassie,
      required this.couleur,
      required this.genre,
      required this.qtyMaxReservoir,
      required this.dateFabrication,
      required this.nomeroPLaque,
      required this.nomeroEntreprise,
      required this.kilometrageInitiale,
      required this.provenance,
      required this.typeCaburant,
      required this.typeMoteur,
      required this.signature,
      required this.created,
      required this.approbationDG,
      required this.motifDG,
      required this.signatureDG,
      required this.approbationDD,
      required this.motifDD,
      required this.signatureDD});

  factory AnguinModel.fromSQL(List<dynamic> row) {
    return AnguinModel(
        id: row[0],
        modele: row[1],
        marque: row[2],
        numeroChassie: row[3],
        couleur: row[4],
        genre: row[5],
        qtyMaxReservoir: row[6],
        dateFabrication: row[7],
        nomeroPLaque: row[8],
        nomeroEntreprise: row[9],
        kilometrageInitiale: row[10],
        provenance: row[11],
        typeCaburant: row[12],
        typeMoteur: row[13],
        signature: row[14],
        created: row[15],
        approbationDG: row[16],
        motifDG: row[17],
        signatureDG: row[18],
        approbationDD: row[19],
        motifDD: row[20],
        signatureDD: row[21]);
  }

  factory AnguinModel.fromJson(Map<String, dynamic> json) {
    return AnguinModel(
        id: json['id'],
        modele: json['modele'],
        marque: json['marque'],
        numeroChassie: json['numeroChassie'],
        couleur: json['couleur'],
        genre: json['genre'],
        qtyMaxReservoir: json['qtyMaxReservoir'],
        dateFabrication: DateTime.parse(json['dateFabrication']),
        nomeroPLaque: json['nomeroPLaque'],
        nomeroEntreprise: json['nomeroEntreprise'],
        kilometrageInitiale: json['kilometrageInitiale'],
        provenance: json['provenance'],
        typeCaburant: json['typeCaburant'],
        typeMoteur: json['typeMoteur'],
        signature: json['signature'],
        created: DateTime.parse(json['created']),
        approbationDG: json['approbationDG'],
        motifDG: json['motifDG'],
        signatureDG: json['signatureDG'],
        approbationDD: json['approbationDD'],
        motifDD: json['motifDD'],
        signatureDD: json['signatureDD']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'modele': modele,
      'marque': marque,
      'numeroChassie': numeroChassie,
      'couleur': couleur,
      'genre': genre,
      'qtyMaxReservoir': qtyMaxReservoir,
      'dateFabrication': dateFabrication.toIso8601String(),
      'nomeroPLaque': nomeroPLaque,
      'nomeroEntreprise': nomeroEntreprise,
      'kilometrageInitiale': kilometrageInitiale,
      'provenance': provenance,
      'typeCaburant': typeCaburant,
      'typeMoteur': typeMoteur,
      'signature': signature,
      'created': created.toIso8601String(),
      'approbationDG': approbationDG,
      'motifDG': motifDG,
      'signatureDG': signatureDG,
      'approbationDD': approbationDD,
      'motifDD': motifDD,
      'signatureDD': signatureDD
    };
  }
}
