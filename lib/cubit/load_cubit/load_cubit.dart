import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../models/country_model.dart';
import '../../services/api/api_service.dart';

part 'load_state.dart';

class LoadCubit extends Cubit<LoadState> {
  final ApiService _apiService;

  LoadCubit(this._apiService) : super(LoadStateInitial());

  @override
  Stream<LoadState> get stream => super.stream.doOnListen(() {
        if (state is LoadStateInitial) {
          _loadCountries();
        }
      });

  Future<void> _loadCountries() async {
    try {
      if (state is LoadStateInitial) {
        emit(LoadStateWaiting());
        List<CountryModel> countries = await _apiService.getCountries();
        emit(LoadStateSucceed(countries));
      }
    } catch (e) {
      emit(LoadStateFailed(e.toString()));
    }
  }

  Future<void> searchCountries(
      List<CountryModel> countries, String term) async {
    try {
      if (state is LoadStateSucceed) {
        emit(LoadStateWaiting());

        emit(LoadStateSearchSucceed(countries));
      }
    } catch (e) {
      emit(LoadStateFailed(e.toString()));
    }
  }
}
