part of 'api_cubit.dart';

abstract class ApiState extends Equatable {
  const ApiState();

  @override
  List<Object> get props => [];
}

class ApiStateInitial extends ApiState {}

class ApiStateWaiting extends ApiState {}

class ApiStateSucceed extends ApiState {
  final List<CountryModel> countries;

  const ApiStateSucceed(this.countries);

  @override
  List<Object> get props => [countries];
}

class ApiStateFailed extends ApiState {
  final String error;

  const ApiStateFailed(this.error);

  @override
  List<Object> get props => [error];
}
