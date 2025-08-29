import 'category.dart';

class Player{
  String? id;
  String name;
  double score;
  String? playerCategoryId;
  Category? playerCategory;

  Player({this.id, required this.name, required this.score, this.playerCategoryId,this.playerCategory});

  Map<String, dynamic> toJson(){
    return {
      'id' : id,
      'name' : name,
      'score' : score,
      'playerCategoryId' : playerCategoryId,
      'playerCategory' : playerCategory,
    };
  }

  factory Player.fromJson(Map<String, dynamic> json){
    return Player(
        id: json['id'],
        name: json['name'],
        score: json['score'],
        playerCategoryId: json['playerCategoryId'],
        playerCategory: json['playerCategory']
    );
  }
}