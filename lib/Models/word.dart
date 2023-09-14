class Word {
  final String id;
  final String word;
  final String explanation;
  final String language;
  final int difficulty;

  Word({
    required this.id,
    required this.word,
    this.explanation = "",
    this.language = "uk",
    this.difficulty = 1,
  });

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      id: json['id'],
      word: json['word'],
      explanation: json['explanation'] ?? "",
      language: json['language'] ?? "uk",
      difficulty: json['difficulty'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'word': word,
      'explanation': explanation,
      'language': language,
      'difficulty': difficulty,
    };
  }
}
