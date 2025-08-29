class Option {
  String id;
  String questionId;
  String optionText;
  bool isCorrect;

  Option({
    required this.id,
    required this.questionId,
    required this.optionText,
    required this.isCorrect,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'question_id': questionId,
    'option_text': optionText,
    'is_correct': isCorrect ? 1 : 0,
  };

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    id: json['id'],
    questionId: json['question_id'],
    optionText: json['option_text'],
    isCorrect: json['is_correct'] == 1,
  );
}
