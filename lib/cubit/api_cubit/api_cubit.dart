import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/api/api_service.dart';
import '../../services/responces/countries_dto.dart';

part 'api_state.dart';

class ApiCubit extends Cubit<ApiState> {
  final ApiService _apiService;
  List<CountriesDTO>? _countries;
  ApiCubit(this._apiService) : super(ApiStateInitial());

  Future<void> load() async {
    try {
      if (state is ApiStateInitial) {
        emit(ApiStateWaiting());
        _countries ??= await _apiService.getCountries();
        emit(ApiStateSucceed(_countries ?? []));
      }
    } catch (e) {
      emit(ApiStateFailed(e.toString()));
    }
  }
}
