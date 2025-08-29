class Category {
  String? id;
  String titre;
  String description;

  // Constructeur
  Category({this.id, required this.titre, required this.description});

  // Convertir un objet Category en Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titre': titre,
      'description': description,
    };
  }

  // Créer un objet Category à partir d'un Map (JSON)
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      titre: json['titre'],
      description: json['description'],
    );
  }
}
