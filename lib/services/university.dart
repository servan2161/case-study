class University {
  final String name;
  final String country;
  final String alphaTwoCode;
  final List<String> domains;
  final List<String> webPages;

  University({
    required this.name,
    required this.country,
    required this.alphaTwoCode,
    required this.domains,
    required this.webPages,
  });

  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      name: json['name'] ?? '',
      country: json['country'] ?? '',
      alphaTwoCode: json['alpha_two_code'] ?? '',
      // Listeleri güvenli bir şekilde çekiyoruz
      domains: List<String>.from(json['domains'] ?? []),
      webPages: List<String>.from(json['web_pages'] ?? []),
    );
  }
}
