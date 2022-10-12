class CountriesDTO {
  final Map<String, dynamic> name;
  final String code;
  final Map<String, dynamic> flag;
  final Map<String, dynamic> idd;

  CountriesDTO._(this.name, this.code, this.flag, this.idd);

  factory CountriesDTO.fromJson(Map<String, dynamic> json) {
    return CountriesDTO._(
      json['name'],
      json['ccn3'] ?? '',
      json['flags'] ?? {'svg': ''},
      json['idd'] == null
          ? {
              'root': '',
              'suffixes': ['']
            }
          : json['idd'] == {}
              ? {
                  'root': '',
                  'suffixes': ['']
                }
              : json['idd'],
    );
  }
}
