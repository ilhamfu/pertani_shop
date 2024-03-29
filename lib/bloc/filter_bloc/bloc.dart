import 'package:pertani_shop/bloc/filter_bloc/events.dart';
import 'package:pertani_shop/bloc/filter_bloc/states.dart';
import 'package:bloc/bloc.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  @override
  FilterState get initialState => FilterInitialized.empty();

  @override
  Stream<FilterState> mapEventToState(FilterEvent event) async* {
    if (event is FilterSetCategory) {
      yield FilterInitialized.fromInitialized(currentState,
          clearCategory: event.clearCategory, category: event.productCategory);
    } else if (event is FilterSetPrice) {
      yield FilterInitialized.fromInitialized(currentState,
          maxPrice: event.maxPrice, minPrice: event.minPrice);
    } else if (event is FilterSetStar) {
      yield FilterInitialized.fromInitialized(currentState, star: event.star);
    } else if (event is FilterSetSearch) {
      yield FilterInitialized.fromInitialized(currentState,
          search: event.search);
    } else if (event is FilterClear) {
      yield FilterInitialized.empty();
    }
  }
}
