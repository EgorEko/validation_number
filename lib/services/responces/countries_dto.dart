class CountriesDTO {
  final String name;
  final int code;

  CountriesDTO._(this.name, this.code);

  factory CountriesDTO.fromJson(Map<String, dynamic> json) {
    return CountriesDTO._(json['name'], json['code']);
  }
}
