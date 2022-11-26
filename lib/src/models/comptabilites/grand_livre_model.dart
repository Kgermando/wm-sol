class GrandLivreModel { 
  late String compte;

  GrandLivreModel({ 
    required this.compte});

  factory GrandLivreModel.fromJson(Map<String, dynamic> json) {
    return GrandLivreModel( 
        compte: json['compte'],
    );
  }

  Map<String, dynamic> toJson() {
    return { 
      'compte': compte
    };
  }
}
