class University {
  final String name;
  final String country;
  final String alphaTwoCode;

  University({
    required this.name,
    required this.country,
    required this.alphaTwoCode,
  });

  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      name: json['name'] ?? '',
      country: json['country'] ?? '',
      alphaTwoCode: json['alpha_two_code'] ?? '',
    );
  }
}
