import '../services/responces/countries_dto.dart';

class CountryModel {
  final String name;
  final String code;
  final String flag;
  final String root;
  final List<dynamic> suffixes;

  CountryModel._(
    this.name,
    this.code,
    this.flag,
    this.root,
    this.suffixes,
  );

  factory CountryModel.fromCountriesDTO(CountriesDTO countriesDTO) {
    return CountryModel._(
      countriesDTO.name['common'],
      countriesDTO.code,
      countriesDTO.flag['svg'] ?? '',
      countriesDTO.idd['root'] ?? '',
      countriesDTO.idd['suffixes'] ?? [],
    );
  }
}
