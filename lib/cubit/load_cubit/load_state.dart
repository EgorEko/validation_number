part of 'load_cubit.dart';

abstract class LoadState extends Equatable {
  const LoadState();

  @override
  List<Object> get props => [];
}

class LoadStateInitial extends LoadState {}

class LoadStateWaiting extends LoadState {}

class LoadStateSucceed extends LoadState {
  final List<CountryModel> countries;

  const LoadStateSucceed(this.countries);

  @override
  List<Object> get props => [countries];
}

class LoadStateFailed extends LoadState {
  final String error;

  const LoadStateFailed(this.error);

  @override
  List<Object> get props => [error];
}

class LoadStateSearchWaiting extends LoadState {}

class LoadStateSearchSucceed extends LoadState {
  final List<CountryModel> countries;

  const LoadStateSearchSucceed(this.countries);

  @override
  List<Object> get props => [countries];
}
