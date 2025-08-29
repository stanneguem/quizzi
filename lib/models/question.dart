class Question {
  String id;
  String questionText;
  String? categoryId;
  double point;

  Question({required this.id, required this.questionText, this.categoryId, required this.point});

  Map<String, dynamic> toJson() => {
    'id': id,
    'question_text': questionText,
    'category_id': categoryId,
    'point' : point
  };

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json['id'],
    questionText: json['question_text'],
    categoryId: json['category_id'],
    point: json['point'],
  );
}
