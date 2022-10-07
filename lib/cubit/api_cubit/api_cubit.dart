import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/country_model.dart';
import '../../services/api/api_service.dart';

part 'api_state.dart';

class ApiCubit extends Cubit<ApiState> {
  final ApiService _apiService;

  ApiCubit(this._apiService) : super(ApiStateInitial());

  Future<void> load() async {
    try {
      if (state is ApiStateInitial) {
        emit(ApiStateWaiting());
        List<CountryModel> countries = await _apiService.getCountries();
        emit(ApiStateSucceed(countries));
      }
    } catch (e) {
      emit(ApiStateFailed(e.toString()));
    }
  }
}
