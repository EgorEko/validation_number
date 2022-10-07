part of 'load_cubit.dart';

abstract class LoadState extends Equatable {
  const LoadState();

  @override
  List<Object?> get props => [];
}

class LoadStateInitial extends LoadState {}

class LoadStateWaiting extends LoadState {}

class LoadStateSucceed extends LoadState {
  final List<CountryModel> countries;

  const LoadStateSucceed(this.countries);

  @override
  List<Object?> get props => [countries];
}

class LoadStateFailed extends LoadState {
  final String error;

  const LoadStateFailed(this.error);

  @override
  List<Object?> get props => [error];
}

class LoadStateSearchUninitialized extends LoadState {
  final List<CountryModel> countryModel;

  const LoadStateSearchUninitialized(this.countryModel);

  @override
  List<Object?> get props => [countryModel];
}

class LoadStateSearchLoading extends LoadState {
  const LoadStateSearchLoading();
}

class LoadStateSearchEmpty extends LoadState {
  const LoadStateSearchEmpty();
}

class LoadStateSearchFounded extends LoadState {
  final String term;
  final List<CountryModel> countryModel;

  const LoadStateSearchFounded(this.term, this.countryModel);

  @override
  List<Object?> get props => [term, countryModel];
}
