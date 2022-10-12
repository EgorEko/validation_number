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
        print(countries.length);

        emit(LoadStateSucceed(countries));
      }
    } catch (e) {
      emit(LoadStateFailed(e.toString()));
    }
  }

  Future<void> clearHistory() async {
    emit(LoadStateInitial());
  }

  Future<void> fixCountry(CountryModel item) async {
    try {
      if (state is LoadStateSucceed || state is LoadStateSearchFounded) {
        emit(LoadStateFixedCountry(item));
      }
    } catch (e) {
      emit(LoadStateFailed(e.toString()));
    }
  }

  Future<void> _startSearching() async {
    final currentState = state;
    if (currentState is LoadStateSucceed) {
      final items = currentState.countries;
      emit(LoadStateSearchUninitialized(items));
    }
  }

  Future<void> search(String term) async {
    if (term.isNotEmpty && state is LoadStateSucceed) {
      _startSearching;
    }

    if (term.isEmpty && state is LoadStateSearchUninitialized) {
      emit(const LoadStateSearchLoading());
      if (term.length > 1 && state is LoadStateSearchUninitialized) {
        final items = await _doSearch(term);
        if (items.isNotEmpty) {
          emit(LoadStateSearchFounded(term, [...items]));
        } else {
          emit(const LoadStateSearchEmpty());
        }
      }
    } else if (term.isEmpty) {
      final items = await _doSearch(term);
      emit(LoadStateSucceed([...items]));
    } else if (term.isNotEmpty) {
      if (term.length > 1) {
        final items = await _doSearch(term);
        if (items.isNotEmpty) {
          emit(LoadStateSearchFounded(term, [...items]));
        } else {
          emit(const LoadStateSearchEmpty());
        }
      }
    }
  }

  Future<List<CountryModel>> _doSearch(String term) async {
    final countryModel = await _apiService.getCountries();

    if (term.isEmpty) {
      return countryModel;
    }

    if (_isNumeric(term)) {
      if (term.length < 3) {
        return countryModel
            .where((element) => element.root.startsWith(term))
            .toList();
      }

      return <CountryModel>[];
    }

    final foundedItems = countryModel.where((element) {
      final termFormatted = '${term[0].toUpperCase()}${term.substring(1)}';

      return element.name.startsWith(termFormatted);
    }).toList();
    return foundedItems;
  }

  bool _isNumeric(String term) {
    if (term.isEmpty) {
      return false;
    }
    return int.tryParse(term) != null;
  }

  Future<void> searchClear() async {
    final items = await _doSearch('');
    emit(LoadStateSucceed([...items]));
  }
}
