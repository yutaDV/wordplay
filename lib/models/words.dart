class Word {
  final String word;
  final String language;
  final int difficulty;

  Word({
    required this.word,
    required this.language,
    required this.difficulty,
  });
}

class Dictionary {
  final String id; // Унікальний ідентифікатор словника (мови)
  final List<Word> easyWords;
  final List<Word> mediumWords;
  final List<Word> hardWords;

  Dictionary({
    required this.id,
    required this.easyWords,
    required this.mediumWords,
    required this.hardWords,
  });
}
