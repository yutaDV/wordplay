class Dictionary {
  final String language;
  final List<String> easyCategory;
  final List<String> mediumCategory;
  final List<String> hardCategory;

  Dictionary({
    required this.language,
    required this.easyCategory,
    required this.mediumCategory,
    required this.hardCategory,
  });

  factory Dictionary.fromJson(Map<String, dynamic> json) {
    return Dictionary(
      language: json['language'],
      easyCategory: List<String>.from(json['easyCategory']),
      mediumCategory: List<String>.from(json['mediumCategory']),
      hardCategory: List<String>.from(json['hardCategory']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'language': language,
      'easyCategory': easyCategory,
      'mediumCategory': mediumCategory,
      'hardCategory': hardCategory,
    };
  }
}
