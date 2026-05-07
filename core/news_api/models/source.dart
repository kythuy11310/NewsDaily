class Source {
  final String id;
  final String name;
  final String description;
  final String url;
  final String category;
  final String language;
  final String country;

  const Source({
    required this.id,
    required this.name,
    this.description = '',
    this.url = '',
    this.category = '',
    this.language = '',
    this.country = '',
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      url: json['url'] as String? ?? '',
      category: json['category'] as String? ?? '',
      language: json['language'] as String? ?? '',
      country: json['country'] as String? ?? '',
    );
  }
}
